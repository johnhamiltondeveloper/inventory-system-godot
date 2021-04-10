extends Resource

class_name InventoryObject

var Inventory = []
var used_slots = 0

var slot_ui_elements = []

var MaxSize = 5

func set_size(size):
	
	MaxSize = size
	
	Inventory.resize(MaxSize)
	slot_ui_elements.resize(MaxSize)

func get_size():
	return MaxSize

func registerSlot(slotID,object):
	slot_ui_elements[slotID] = object

func drop_into_Inventory(item):
	
	for i in get_size():
		
		if hasItem(i) and !is_slot_full(i):
			if get_item_ID(i) == item.id:
				item = combine(i,item)
				if item == null:
					break
	
	for i in get_size():
		if !hasItem(i):
			put_item(i,item)
			item = null
	
	return item

func is_slot_full(slotID):
	return (Inventory[slotID].quantity >= ItemDatabase.get_item_stack_size(Inventory[slotID].id))

func hasItem(slotID):
	if slotID < MaxSize:
		return (Inventory[slotID] != null)
	else:
		return false

func combine(slotID,item):
	
	var stack_max = ItemDatabase.get_item_stack_size(item.id)
	
	var new_quantity = Inventory[slotID].quantity + item.quantity
	
	if new_quantity <= stack_max:
		Inventory[slotID].quantity = new_quantity
		
		refresh(slotID)
		
		return null
	else:
		Inventory[slotID].quantity = stack_max
		item.quantity = new_quantity-stack_max
		
		refresh(slotID)
		
		return item

func take_sub_item(slotID,quantity):
	
	if quantity >= Inventory[slotID].quantity:
		
		return take_item(slotID)
	else:
		
		var newItem = ItemInstance.new()
		
		newItem.id = Inventory[slotID].id
		newItem.quantity = quantity
		
		Inventory[slotID].quantity -= quantity
		
		refresh(slotID)
		
		return newItem

func get_item_ID(slot):
	if Inventory[slot] == null:
		return null
	else:
		return Inventory[slot].id

func refresh(slotID):
	
	if slot_ui_elements[slotID] != null:
		slot_ui_elements[slotID].refresh(Inventory[slotID])

func refreshALL():
	
	for i in slot_ui_elements.size():
	
		if slot_ui_elements[i] != null:
			slot_ui_elements[i].refresh(Inventory[i])

func put_item(slot : int,item : ItemInstance):
		
	Inventory[slot] = item
	
	refresh(slot)

func take_item(slot : int):
	
	var returnItem = Inventory[slot]
	
	Inventory[slot] = null
	
	refresh(slot)
	
	return returnItem

func get_used_count():
	return used_slots

func ref_item(slotID):
	return Inventory[slotID]
