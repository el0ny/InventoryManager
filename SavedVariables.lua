InventoryManager.variableVersion = 2

local defaultData = {
	debug = false,
	checkbox_checked = true,
	raw_material = true,
	refined_material = true,
	trait_material = true,
	rune_material = true,
	alchemy = true,
	bank_management = true,
	house_chests_management = true,
	booster = true,
	trophy = true,
	colour = {
		warnings = "|cba6a1a",
		notifications = "|c638C29"
	},
}

function InventoryManager:UpdateSettingsData()
	d("Updating setiings...")
	self.valid_item_types[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = self.savedVariables.raw_material
	self.valid_item_types[ITEMTYPE_WOODWORKING_RAW_MATERIAL] = self.savedVariables.raw_material
	self.valid_item_types[ITEMTYPE_CLOTHIER_RAW_MATERIAL] = self.savedVariables.raw_material
	self.valid_item_types[ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = self.savedVariables.raw_material

	self.valid_item_types[ITEMTYPE_WOODWORKING_MATERIAL] = self.savedVariables.refined_material
	self.valid_item_types[ITEMTYPE_BLACKSMITHING_MATERIAL] = self.savedVariables.refined_material
	self.valid_item_types[ITEMTYPE_CLOTHIER_MATERIAL] = self.savedVariables.refined_material
	self.valid_item_types[ITEMTYPE_JEWELRYCRAFTING_MATERIAL] = self.savedVariables.refined_material
	
	self.valid_item_types[ITEMTYPE_ARMOR_TRAIT] = self.savedVariables.trait_material
	self.valid_item_types[ITEMTYPE_WEAPON_TRAIT] = self.savedVariables.trait_material
	self.valid_item_types[ITEMTYPE_JEWELRY_TRAIT] = self.savedVariables.trait_material
	self.valid_item_types[ITEMTYPE_JEWELRY_RAW_TRAIT] = self.savedVariables.trait_material
	
	self.valid_item_types[ITEMTYPE_ENCHANTING_RUNE_ASPECT] = self.savedVariables.rune_material
	self.valid_item_types[ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = self.savedVariables.rune_material
	self.valid_item_types[ITEMTYPE_ENCHANTING_RUNE_POTENCY] = self.savedVariables.rune_material
	
	self.valid_item_types[ITEMTYPE_BLACKSMITHING_BOOSTER] = self.savedVariables.booster
	self.valid_item_types[ITEMTYPE_WOODWORKING_BOOSTER] = self.savedVariables.booster
	self.valid_item_types[ITEMTYPE_CLOTHIER_BOOSTER] = self.savedVariables.booster
	self.valid_item_types[ITEMTYPE_JEWELRYCRAFTING_BOOSTER] = self.savedVariables.booster
	self.valid_item_types[ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER] = self.savedVariables.booster
	self.valid_item_types[ITEMTYPE_ENCHANTMENT_BOOSTER] = self.savedVariables.booster
	
	self.valid_item_types[ITEMTYPE_INGREDIENT] = self.savedVariables.alchemy
	self.valid_item_types[ITEMTYPE_REAGENT] = self.savedVariables.alchemy
	self.valid_item_types[ITEMTYPE_POTION_BASE] = self.savedVariables.alchemy
	self.valid_item_types[ITEMTYPE_POISON_BASE] = self.savedVariables.alchemy
	
	self.valid_item_types[ITEMTYPE_TROPHY] = self.savedVariables.trophy

	
	
	self.valid_storage_types[BAG_BANK] = self.savedVariables.bank_management
	for bag_id = BAG_HOUSE_BANK_ONE, BAG_HOUSE_BANK_TEN do
		self.valid_storage_types[bag_id] = self.savedVariables.house_chests_management
    end
end

function InventoryManager:InitSavedVariables()

	self.savedVariables = ZO_SavedVars:NewAccountWide("InventoryManagerData", self.variableVersion, nil, defaultData)
	-------------------------------------------------------------------------------------------------
	-- If we reloadui whilst in combat, we still need to return the skill after combat ends --
	-------------------------------------------------------------------------------------------------
	self.valid_item_types = {
		--[ITEMTYPE_WOODWORKING_MATERIAL] = self.savedVariables.refined_material,
		--[ITEMTYPE_BLACKSMITHING_MATERIAL] = self.savedVariables.refined_material,
		--[ITEMTYPE_CLOTHIER_MATERIAL] = self.savedVariables.refined_material,
		--[ITEMTYPE_JEWELRYCRAFTING_MATERIAL] = self.savedVariables.refined_material,
		
		--[ITEMTYPE_ENCHANTING_RUNE_ASPECT] = true,
		--[ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = true,
		--[ITEMTYPE_ENCHANTING_RUNE_POTENCY] = true,
		
		--[ITEMTYPE_INGREDIENT] = true,
		--[ITEMTYPE_REAGENT] = true,
		--[ITEMTYPE_POTION_BASE] = true,
		--[ITEMTYPE_POISON_BASE] = true,
		

		
		[ITEMTYPE_STYLE_MATERIAL] = true,
		
		--[ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = true,
		--[ITEMTYPE_WOODWORKING_RAW_MATERIAL] = true,
		--[ITEMTYPE_CLOTHIER_RAW_MATERIAL] = true,
		--[ITEMTYPE_JEWELRY_RAW_TRAIT] = true,
		--[ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = true,
		
		--[ITEMTYPE_TROPHY] = true,
		
		--[ITEMTYPE_ARMOR_TRAIT] = true,
		--[ITEMTYPE_WEAPON_TRAIT] = true,
		--[ITEMTYPE_JEWELRY_TRAIT] = true,
		
		[ITEMTYPE_FURNISHING_MATERIAL] = true,
		
		--[ITEMTYPE_BLACKSMITHING_BOOSTER] = true,
		--[ITEMTYPE_WOODWORKING_BOOSTER] = true,
		--[ITEMTYPE_CLOTHIER_BOOSTER] = true,
		--[ITEMTYPE_JEWELRYCRAFTING_BOOSTER] = true,
		--[ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER] = true,
		--[ITEMTYPE_ENCHANTMENT_BOOSTER] = true,
		
		[ITEMTYPE_LURE] = true
	}
	self.valid_storage_types = {}
	InventoryManager:UpdateSettingsData()

end

function InventoryManager.ResetSavedVariables()
	InventoryManager.savedVariables = defaultData
end