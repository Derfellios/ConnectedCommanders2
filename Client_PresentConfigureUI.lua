
function Client_PresentConfigureUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	allowTransferingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can transfer').SetIsChecked(true);
	allowReconBox = UI.CreateCheckBox(vert).SetText('Reconnaissance cards spawn a commander at a territory').SetIsChecked(true);
end
