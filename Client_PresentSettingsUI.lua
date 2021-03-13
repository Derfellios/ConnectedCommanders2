function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('Allow that a commander can transfer: ' .. tostring(Mod.Settings.allowTransfering));
	UI.CreateLabel(vert).SetText('Allow that a commander can attack/transfer: ' .. tostring(Mod.Settings.allowAttacking));
    UI.CreateLabel(vert).SetText('Number of commanders each player gets on the first turn:' .. Mod.Settings.NumberOfCommanders);
end
