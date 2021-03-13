
function Client_PresentConfigureUI(rootParent)

    if initialValue == nil then initialValue = 3; end
	
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	allowTransferingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can transfer').SetIsChecked(true);
	allowAttackingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can attack/transfer').SetIsChecked(true);

    local horz = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(horz).SetText('Number of commanders each player gets on turn 1');
    NumberOfCommandersSlider = UI.CreateNumberInputField(horz)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(4)
		.SetValue(initialValue);
end
