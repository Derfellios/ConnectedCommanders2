function Client_SaveConfigureUI(alert)
	Mod.Settings.startWithCommander = startWithCommanderBox.GetIsChecked()
	Mod.Settings.allowTransfering = allowTransferingBox.GetIsChecked();
	Mod.Settings.allowAttacking = allowAttackingBox.GetIsChecked();
	Mod.Settings.allowRecon = allowReconBox.GetIsChecked();
end
