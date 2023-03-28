-----------------------------------------------------------------------------------
-- Addon Name: InventoryManager
-- Creator: elDrag0n
-- Addon Ideal: Manages resources between bank and inventory
-- Addon Creation Date: July 18, 2022
--
-- File Name: BankManagement.lua
-- File Description: This file manages resources between banks and inventory
-- Load Order Requirements: None
-- 
-----------------------------------------------------------------------------------

InventoryManager = InventoryManager or {}
InventoryManager.version = "0.2.0"
InventoryManager.name = 'InventoryManager'
InventoryManager.colours = {
	greenCP = "|c557C29",
	author = "|c5959D5"
}
name = "test"


function InventoryManagement:buildStorageTable(storage_bag_id)
	storage_table = {}
	local slot_id = ZO_GetNextBagSlotIndex(storage_bag_id)
	while slot_id do
		local item_type = GetItemType(storage_bag_id, slot_id)
		if self.valid_item_types[item_type] then
			local item_id = GetItemId(storage_bag_id, slot_id)
			storage_table[item_id] = slot_id
		end
		--d(GetItemName(storage_bag_id, slot_id))

		slot_id = ZO_GetNextBagSlotIndex(storage_bag_id, slot_id)
	end
	return storage_table
end

--local function findTargetSlotId(targetItemId, storage_bag_id)
--
--	local slot_id = ZO_GetNextBagSlotIndex(storage_bag_id)
--	while slot_id do
--		local item_id = GetItemId(storage_bag_id, slot_id)
--		--d(GetItemName(storage_bag_id, slot_id))
--		if item_id == targetItemId then return slot_id end
--
--		slot_id = ZO_GetNextBagSlotIndex(storage_bag_id, slot_id)
--	end
--end


function InventoryManager.main(event, storage_bag_id)
	if not InventoryManager.valid_storage_types[storage_bag_id] then
		d("oops: " .. storage_bag_id)
		return
	end
 	--local bagId = BAG_BACKPACK
	--d(storage_bag_id)
	--d(InventoryManager.valid_item_types)

	local inventory_slot = ZO_GetNextBagSlotIndex(BAG_BACKPACK)
	storage_table = InventoryManagement:buildStorageTable(storage_bag_id)

	while inventory_slot do
		local item_type = GetItemType(BAG_BACKPACK, inventory_slot)
		local item_id = GetItemId(BAG_BACKPACK, inventory_slot)
		if InventoryManager.valid_item_types[item_type] and storage_table[item_id] then
			
			local storage_slot = storage_table[item_id]
			--d(GetItemName(BAG_BACKPACK, slot))
			--d(item_type .. GetItemName(storage_bag_id, inventory_slot))
			if storage_slot then
				local bank_slot_size, max_bank_slot_size = GetSlotStackSize(storage_bag_id, storage_slot)
				local bag_slot_size, max_bag_slot_size = GetSlotStackSize(BAG_BACKPACK, inventory_slot)

				if bag_slot_size ~= max_bag_slot_size then				
					local available_space = max_bank_slot_size - bank_slot_size

					if available_space > bag_slot_size then
						--d(GetItemName(BAG_BACKPACK, inventory_slot)..' Bank slot size: '..bank_slot_size..' Bank max slot size: '..max_bank_slot_size..' Bag slot size: '..bag_slot_size)
						--d("wow2")
						if IsProtectedFunction("RequestMoveItem") then
							--d(GetItemName(BAG_BACKPACK, inventory_slot))
							CallSecureProtected("RequestMoveItem", BAG_BACKPACK, inventory_slot, storage_bag_id, storage_slot, bag_slot_size)
						else
							RequestMoveItem(BAG_BACKPACK, inventory_slot, storage_bag_id, storage_slot, bag_slot_size)
						end
					else
						local available_bag_space = max_bag_slot_size - bag_slot_size
						local bank_remain = bank_slot_size - available_bag_space
						d(GetItemName(BAG_BACKPACK, inventory_slot)..' x'..max_bag_slot_size..' was withdrawn, x'..bank_remain..' remains in bank ')
						if IsProtectedFunction("RequestMoveItem") then
							CallSecureProtected("RequestMoveItem", storage_bag_id, storage_slot, BAG_BACKPACK, inventory_slot, available_bag_space)
						else
							RequestMoveItem(storage_bag_id, storage_slot, BAG_BACKPACK, inventory_slot, available_bag_space)
						end
					end
				end
			end
		end
		inventory_slot = ZO_GetNextBagSlotIndex(BAG_BACKPACK, inventory_slot)
		--d(inventory_slot)
	end
end


slot_surveys = function (event, bag) 
	d('lol')
	local bagId = BAG_BACKPACK

	local slot = ZO_GetNextBagSlotIndex(bagId)
	while slot do
		item_type = GetItemType(bagId, slot)
		local item_id = GetItemId(BAG_BACKPACK, slot)
		d(GetItemName(bagId, slot)..'     '..item_type)
		slot = ZO_GetNextBagSlotIndex(bag, slot)
	end
end

InventoryManager.slot_surveys = slot_surveys


function InventoryManager:Initialize()
	
	InventoryManager:InitSavedVariables()

	--InventoryManager.setupInventoryMoveEvents()

	InventoryManager:InitMenu()
	EVENT_MANAGER:UnregisterForEvent(name, EVENT_ADD_ON_LOADED)
end

function InventoryManager.OnAddOnLoaded(event, addonName)
	if addonName == InventoryManager.name then
		InventoryManager:Initialize()
	end
end

EVENT_MANAGER:RegisterForEvent(InventoryManager.name, EVENT_ADD_ON_LOADED, InventoryManager.OnAddOnLoaded)
EVENT_MANAGER:RegisterForEvent(InventoryManager.name, EVENT_OPEN_BANK, InventoryManager.main)


--
 local function _onInventoryChanged(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, updateReason, stackCountChange)
   local link = GetItemLink(bagId, slotIndex)
   local item_type = GetItemType(bagId, slotIndex)
   d("Picked up a " .. link .. "." .. item_type .. " Bag: " .. bagId)
end
EVENT_MANAGER:RegisterForEvent(InventoryManager.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, _onInventoryChanged)
--EVENT_MANAGER:AddFilterForEvent("MyExampleEvent", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_IS_NEW_ITEM, true)
--EVENT_MANAGER:AddFilterForEvent(InventoryManager.name, EVENT_OPEN_BANK, REGISTER_FILTER_BAG_ID, BAG_BANK)
--EVENT_MANAGER:AddFilterForEvent("MyExampleEvent", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)
