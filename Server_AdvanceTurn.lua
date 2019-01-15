function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)
	-- Add Commanders with recon card.
	local proxtype = order.proxyType
	if(proxtype == 'GameOrderPlayCardReconnaissance') then
		local territory = game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritory]
        local PlayerOwnedTerr = territory.OwnerPlayerID;
        local CardPlayer = order.PlayerID;
            if PlayerOwnedTerr == CardPlayer then
				local Unit = WL.Commander.Create(CardPlayer); 
				local effect = WL.TerritoryModification.Create(territory.ID);
				effect.AddSpecialUnits = {Unit};
				addNewOrder(WL.GameOrderEvent.Create(CardPlayer, "Commander", {}, {effect}))
            end
        end
		
	if (proxtype == 'GameOrderAttackTransfer') then
		local OrderTo = game.ServerGame.LatestTurnStanding.Territories[order.To]
		local OrderFrom = game.ServerGame.LatestTurnStanding.Territories[order.From]
		-- Recreates the order if the commanders attacks or tranfers when tranfering is not allowed
		if result.IsAttack and NotTableEmpty(order.NumArmies.SpecialUnits) then	
			--change true when transferring is not allowed
			if Mod.Settings.allowTransfering then		
				local NewArmies = WL.Armies.Create(order.NumArmies.NumArmies, {})
				addNewOrder(WL.GameOrderAttackTransfer.Create(OrderFrom.OwnerPlayerID , OrderFrom.ID, OrderTo.ID, order.AttackTransfer, order.ByPercent, NewArmies, order.AttackTeammates))
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage)
				--return
			end 
		end
		--[[
		if result.IsAttack and NotTableEmpty(OrderTo.NumArmies.SpecialUnits) then
			Terr = game.Map.Territories[OrderTo.ID].ConnectedTo
			count = 0
			PossibleTerr = {}
			PlayerAttacked = game.ServerGame.LatestTurnStanding.Territories[OrderTo.ID].OwnerPlayerID
			for TerrID,_ in pairs(Terr) do
				if game.ServerGame.LatestTurnStanding.Territories[TerrID].OwnerPlayerID == PlayerAttacked then
					count = count + 1
					table.insert(PossibleTerr, TerrID)
				end
			end
			print (count)
			if count > 0 then
				TerrTo = PossibleTerr[math.random(1,count)]
				NewCom = WL.Armies.Create(0, order.NumArmies.SpecialUnits)
				skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage)
				addNewOrder(WL.GameOrderAttackTransfer.Create(OrderTo.OwnerPlayerID , OrderTo.ID, TerrTo, order.AttackTransfer, false, NewCom, order.AttackTeammates))
				addNewOrder(WL.GameOrderAttackTransfer.Create(OrderFrom.OwnerPlayerID , OrderFrom.ID, OrderTo.ID, order.AttackTransfer, order.ByPercent, order.NumArmies, order.AttackTeammates))
			end
		end
		--]]
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
			addNewOrder(WL.GameOrderEvent.Create(Player, "Lost some territories because they were not connected", {}, Effect));
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