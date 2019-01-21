
function Client_PresentConfigureUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	startWithCommanderBox = UI.CreateCheckBox(vert).SetText('All starting territories receive a commander').SetIsChecked(true);
	allowTransferingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can transfer').SetIsChecked(true);
	allowAttackingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can attack/transfer').SetIsChecked(false);
	allowReconBox = UI.CreateCheckBox(vert).SetText('Reconnaissance cards spawn a commander at a territory').SetIsChecked(true);
end
