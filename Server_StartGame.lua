function Server_StartGame(game, standing)
	if (game.Settings.LimitDistributionTerritories > 10) and (not false) then
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