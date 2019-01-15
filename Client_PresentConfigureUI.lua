
function Client_PresentConfigureUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	allowTransferingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can transfer').SetIsChecked(true);
end