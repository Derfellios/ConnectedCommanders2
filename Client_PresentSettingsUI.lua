function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('Allow transfering: ' .. tostring(Mod.Settings.allowTransfering));
	UI.CreateLabel(vert).SetText('Reconnaisance cards spawn a commander: ' .. tostring(Mod.Settings.allowRecon));
end
