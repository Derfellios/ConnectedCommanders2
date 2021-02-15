function Client_PresentConfigureUI(rootParent)
	local vert = UI.CreateVerticalLayoutGroup(rootParent);
	local startWithCommander = Mod.Settings.startWithCommander;
	local allowTransfering = Mod.Settings.allowTransfering;
	local allowAttacking = Mod.Settings.allowAttacking;
	local allowReconBox = Mod.Settings.allowReconBox;

        if startWithCommander == nil then startWithCommander = true; end
	if allowTransfering == nil then allowTransfering = true; end
	if allowAttacking == nil then allowAttacking = false; end
	if allowReconBox == nil then allowReconBox = true; end

	startWithCommanderBox = UI.CreateCheckBox(vert).SetText('All starting territories receive a commander').SetIsChecked(startWithCommander);
	allowTransferingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can transfer').SetIsChecked(allowTransfering);
	allowAttackingBox = UI.CreateCheckBox(vert).SetText('Allows that a commander can attack/transfer').SetIsChecked(allowAttacking);
	allowReconBox = UI.CreateCheckBox(vert).SetText('Reconnaissance cards spawn a commander on a territory').SetIsChecked(allowReconBox);
end
