function startsWith(str, sub)
	return string.sub(str, 1, string.len(sub)) == sub;
end

function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	local proxtype = order.proxyType
	
	if proxtype == 'GameOrderCustom' and startsWith(order.Payload, 'BuildCommander_') then
		local territoryID = string.sub(order.Payload, 18);
        local CardPlayer = order.PlayerID;
		local Unit = WL.Commander.Create(CardPlayer); 
		local effect = WL.TerritoryModification.Create(territoryID);
		effect.AddSpecialUnits = {Unit};
		addNewOrder(WL.GameOrderEvent.Create(CardPlayer, game.ServerGame.Game.Players[CardPlayer].DisplayName(nil, false) .. " deploys a Commander in " .. game.Map.Territories[territoryID].Name, {}, {effect}))
		skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
	end
	
	if (proxtype == 'GameOrderAttackTransfer') then
		-- Recreates the order if the commanders attacks or transfers when transfering is not allowed
		if not Mod.Settings.allowAttacking and (result.IsAttack or not Mod.Settings.allowTransfering) and NotTableEmpty(order.NumArmies.SpecialUnits) then		
			skipThisOrder(WL.ModOrderControl.Skip)
		end
	end
end

function Server_AdvanceTurn_End(game, addNewOrder)
	for Player,_ in pairs(game.ServerGame.Game.PlayingPlayers) do
		local PlayerTerr = {};
		local PlayerComm = {};
		local PlayerConnected = {};
		
		for _, territory in pairs(game.ServerGame.LatestTurnStanding.Territories) do
			if territory.OwnerPlayerID == Player then
				table.insert(PlayerTerr, territory.ID)
				if NotTableEmpty(territory.NumArmies.SpecialUnits) then
					table.insert(PlayerComm, territory.ID)
					table.insert(PlayerConnected, territory.ID)
				end
			end
		end
		for _,StartTerr in pairs(PlayerComm) do
			local NewTerr = {StartTerr}
			local count = 1
			while count > 0 do
				count = 0
				local NewNewTerr = {}
				for _,Terr in pairs(NewTerr) do
					local TerrConnected = game.Map.Territories[Terr].ConnectedTo;
					for TerrConnID,_ in pairs(TerrConnected) do
						local PlayerOwnID = game.ServerGame.LatestTurnStanding.Territories[TerrConnID].OwnerPlayerID
						if NotinTable(PlayerConnected, TerrConnID) and NotinTable(NewNewTerr, TerrConnID) and (PlayerOwnID == Player) then
							count = count + 1
							table.insert(PlayerConnected, TerrConnID)
							table.insert(NewNewTerr, TerrConnID)
						end
					end
				end
				NewTerr = NewNewTerr;
			end
		end
		
		local LostTerr = {}
		for _,TerrID in pairs(PlayerTerr) do
			if NotinTable(PlayerConnected, TerrID) then
				table.insert(LostTerr, TerrID)
			end
		end
		
		local Effect = {};
		local DoEffect = false
		for _,terr in pairs(LostTerr) do
			Effect[tablelength(Effect)+1] = WL.TerritoryModification.Create(terr); 
			Effect[tablelength(Effect)].SetOwnerOpt = WL.PlayerID.Neutral;
			DoEffect = true
		end
		
		if DoEffect then 
			addNewOrder(WL.GameOrderEvent.Create(Player, "Lost some territories because they were not connected to a commander", {}, Effect));
		end
	end
end

function NotTableEmpty(List)
	for a,b in pairs(List) do
		return true
	end
	return false
end

function NotinTable(tbl, item)
    for key, value in pairs(tbl) do
        if value == item then 
		return false 
	end
    end
    return true
end

function tablelength(t)
	local count = 0;
	for _,elem in pairs(t)do
		count = count + 1;
	end
	return count;
end
