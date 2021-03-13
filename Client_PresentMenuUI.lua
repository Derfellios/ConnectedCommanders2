 function map(array, func, j)
	local new_array = {}
	local i = 1;
	for _,v in pairs(array) do
		new_array[i] = func(v, j);
		i = i + 1;
	end
	return new_array
end

 function filter(array, func)
	local new_array = {}
	local i = 1;
	for _,v in pairs(array) do
		if (func(v)) then
			new_array[i] = v;
			i = i + 1;
		end
	end
	return new_array
end

function startsWith(str, sub)
	return string.sub(str, 1, string.len(sub)) == sub;
end

 function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)
 
	Game = game; --make it globally accessible
	
    if (Game.Game.TurnNumber) == 1 and Game.Us ~= nil then
	
		local vert = UI.CreateVerticalLayoutGroup(rootParent);
	
		UI.CreateLabel(vert).SetText('Place your '..Mod.Settings.NumberOfCommanders..' commanders by clicking on the territories. You can place multiple commanders on one territory. This is the only turn you can build commanders.');

		TargetTerritoryBtn = {};
		TargetTerritoryFunctions = {};
		for i = 1, Mod.Settings.NumberOfCommanders, 1 do
		
            TargetTerritoryFunctions[i] = function()
				PlayerId = Game.Us.PlayerID;
				local IndexTerritoryBox = i;
				local options = map(filter(Game.LatestStanding.Territories, 
				function(t) return  t.FogLevel == 1 and t.OwnerPlayerID == PlayerId end), TerritoryButton, IndexTerritoryBox);
					UI.PromptFromList("Select the territory where you want to place a commander", options); 
			end;
			
			TargetTerritoryBtn[i] = UI.CreateButton(vert).SetText("Select new territory for commander").SetOnClick(TargetTerritoryFunctions[i]);
		end
	end
end


function TerritoryButton(terr, index)
	local name = Game.Map.Territories[terr.ID].Name;
	local ret = {};
	ret["text"] = name;
	ret["selected"] = function()
		TargetTerritoryBtn[index].SetText(name);
		
		local PlayId = Game.Us.PlayerID;

		local Message = Game.Game.Players[PlayId].DisplayName(nil, false) .. " deploys a Commander in " .. Game.Map.Territories[terr.ID].Name;

        local payload = "BuildCommander_" .. index .."_" .. terr.ID;
		local order = WL.GameOrderCustom.Create(PlayId, Message, payload, {});
		local orders = Game.Orders;
		
		local NewOrders = {};
		for _, oldorder in pairs(orders) do
			if (oldorder.proxyType ~= 'GameOrderCustom') or (not startsWith(oldorder.Payload, 'BuildCommander_' .. index)) then
				table.insert(NewOrders, oldorder);
			end
		end
		
		table.insert(NewOrders, order);
		Game.Orders = NewOrders;
 	end
	return ret;
end

