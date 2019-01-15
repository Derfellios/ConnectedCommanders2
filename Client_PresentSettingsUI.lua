function Client_PresentSettingsUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	UI.CreateLabel(vert).SetText('Allow transfering: ' .. tostring(Mod.Settings.allowTransfering));
end