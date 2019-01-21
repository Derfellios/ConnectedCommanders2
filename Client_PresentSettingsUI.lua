function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('All starts get a commander: ' .. tostring(Mod.Settings.startWithCommander));
	UI.CreateLabel(vert).SetText('Allow that a commander can transfer: ' .. tostring(Mod.Settings.allowTransfering));
	UI.CreateLabel(vert).SetText('Allow that a commander can attack/transfer: ' .. tostring(Mod.Settings.allowAttacking));
	UI.CreateLabel(vert).SetText('Reconnaisance cards spawn a commander: ' .. tostring(Mod.Settings.allowRecon));	
end
