function Client_GameRefresh(game)
	if game.Game.TurnNumber > 0 then return end; -- don't pop up in ongoing games, could be removed later

	if not Mod.PlayerGameData.InitialPopupDisplayed and game.Us ~= nil then
		UI.Alert("This game includes the connected commanders mod - In the first turn you can deploy commanders. Click on the menu and than on this mod. Good luck!")
		local payload = {};
		payload.Message = "InitialPopupDisplayed";
		game.SendGameCustomMessage("Please wait... ", payload, function(reply)end);
	end
end