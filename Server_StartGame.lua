function Server_StartGame(game, standing)
	
	if (not Mod.Settings.startWithCommander) then 
		return
	end
	
	if (game.Settings.LimitDistributionTerritories > 10)  then
		print "allowed only with no more than 4 starts"
		return
	end

	for _, territory in pairs(standing.Territories) do
		if (not territory.IsNeutral) then
			local numArmies = territory.NumArmies.NumArmies
			local newArmies = WL.Armies.Create(numArmies, { WL.Commander.Create(territory.OwnerPlayerID) }); 
			territory.NumArmies = newArmies
		end
	end
	
end
