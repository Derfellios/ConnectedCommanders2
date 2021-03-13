function Client_SaveConfigureUI(alert)
	Mod.Settings.allowTransfering = allowTransferingBox.GetIsChecked();
	Mod.Settings.allowAttacking = allowAttackingBox.GetIsChecked();
	Mod.Settings.NumberOfCommanders = NumberOfCommandersSlider.GetValue();
end
