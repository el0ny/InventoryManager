function InventoryManager.test_func(panel)
	
   --only if MY addon's LAM panel was created
    if panel == InventoryManager.main_panel then
		InventoryManager:UpdateSettingsData()
    end
   	
end

function InventoryManager:InitMenu()
    local LAM = LibAddonMenu2
	
	if LAM == nil then return end
    local panelName = "InventoryManagerPannel"
    local panelData = {
        type = "panel",
        name = "Inventory Management",
        displayName = string.format("%s%s|u5:0::Inventory Management|u", "|t32:32:esoui/art/champion/champion_points_stamina_icon-hud-32.dds|t", ""),
        author = string.format("%s@elDrag0n|r", self.colours.author),
        --website = "https://www.esoui.com/forums/showthread.php?p=43242",
        version = self.version,
        slashCommand = "/im",
        registerForRefresh = true
    }
	
	local panel = LAM:RegisterAddonPanel(panelName, panelData)
	InventoryManager.main_panel = panel
	local optionsData = 
	{
		{
            type = "description",
            text = SI_INVENTORY_MANAGER,
			width = "full"

		},
		{
            type = "header",
            name = "Storage settings",
            width = "full"
        },
		{
            type = "description",
            text = "Enable specific storage types to work with",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Bank",
            getFunc = function() return self.savedVariables.bank_management end,
            setFunc = function(value) self.savedVariables.bank_management = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "checkbox",
            name = "House chests",
            getFunc = function() return self.savedVariables.house_chests_management end,
            setFunc = function(value) self.savedVariables.house_chests_management = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "header",
            name = "Item types settings",
            width = "full"
        },
		{
            type = "description",
            text = "Enable specific item types to work with",
            width = "full"
        },
        {
            type = "checkbox",
            name = "Rune materials",
            getFunc = function() return self.savedVariables.rune_material end,
            setFunc = function(value) self.savedVariables.rune_material = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Raw Materials",
            getFunc = function() return self.savedVariables.raw_material end,
            setFunc = function(value) self.savedVariables.raw_material = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Refined Materials",
            getFunc = function() return self.savedVariables.refined_material end,
            setFunc = function(value) self.savedVariables.refined_material = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Traits",
            getFunc = function() return self.savedVariables.trait_material end,
            setFunc = function(value) self.savedVariables.trait_material = value end,
            tooltip = "Best tooltip!",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Boosters",
            getFunc = function() return self.savedVariables.booster end,
            setFunc = function(value) self.savedVariables.booster = value end,
            tooltip = "Various boosters",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Alchemy",
            getFunc = function() return self.savedVariables.alchemy end,
            setFunc = function(value) self.savedVariables.alchemy = value end,
            tooltip = "Alchemy materials",
            width = "full"
        },
		{
            type = "checkbox",
            name = "Trophy",
            getFunc = function() return self.savedVariables.trophy end,
            setFunc = function(value) self.savedVariables.trophy = value end,
			disabled = function() return not self.savedVariables.alchemy end,
            tooltip = "Maps, fragments etc.",
            width = "full"
        },
	}
	LAM:RegisterOptionControls(panelName, optionsData)
	CALLBACK_MANAGER:RegisterCallback("LAM-PanelClosed", self.test_func)

end