extends Control

onready var slot_hand = $sort/hand

var slot_hover = null

var inventories = []

var slots = []

var active = false

func _ready():
	inventories.append(InventoryHelper.get_hand_Inventory())

func setup(InventoryList : Array):
	
	inventories.resize(InventoryList.size()+1)
	
	for i in InventoryList.size():
		inventories[i+1] = InventoryList[i]
	
	for i in slots:
		i.setup()
		
		# updates the item with the item values and textures
		if inventories[i.get_inventory_ID()].hasItem(i.get_slot_id()):
			i.refresh(inventories[i.get_inventory_ID()].ref_item(i.get_slot_id()))
	
	for i in inventories:
		i.refreshALL()
		
	active = true

func close():
	active = false

func register_slot(inventory_ID,slot_ID,object):
	
	inventories[inventory_ID].registerSlot(slot_ID,object)

func register_self_object(object):
	slots.append(object)

func set_hover_object(object):
	
	# this allow for a margin of error around the slot that you can still select
	if object == null:
		# creates a delay time of you to interacte with the slot after the mouse has left it
		$Last_hover.start(0.1)
	else:
		# if a new slot is hovered then it swaps to that
		slot_hover = object
		$Last_hover.stop()

func _input(event):
	
	if active == false:
		return
	
	if slot_hover != null:
		
		var slotID = slot_hover.get_slot_id()
		
		var SlotInventory = inventories[slot_hover.get_inventory_ID()]
		var handInventory = inventories[0]
		
		if Input.is_action_just_pressed("left_select"):
			
			if SlotInventory.hasItem(slotID) and handInventory.hasItem(0):
			
				if SlotInventory.get_item_ID(slotID) == handInventory.get_item_ID(0):
					
					var overflow = SlotInventory.combine(slotID,handInventory.take_item(0))
					
					if overflow != null:
						handInventory.put_item(0,overflow)
					
				else:
					
					var SwapTemp = handInventory.take_item(0)
					
					handInventory.put_item(0,SlotInventory.take_item(slotID))
					SlotInventory.put_item(slotID,SwapTemp)
					
			
			# picks up the item in the slot
			elif SlotInventory.hasItem(slotID) and !handInventory.hasItem(0):
				handInventory.put_item(0,SlotInventory.take_item(slotID))
			
			# place the object in the hand into the slot
			elif !SlotInventory.hasItem(slotID) and handInventory.hasItem(0):
				
				SlotInventory.put_item(slotID,handInventory.take_item(0))
		
		if Input.is_action_just_pressed("right_select"):
			if !SlotInventory.hasItem(slotID) and handInventory.hasItem(0):
				SlotInventory.put_item(slotID,handInventory.take_sub_item(0,1))
				
			elif SlotInventory.hasItem(slotID) and handInventory.hasItem(0):
				var overflow = SlotInventory.combine(slotID,handInventory.take_sub_item(0,1))
				if overflow != null:
					handInventory.combine(0,overflow)

# this is used to set the object that is hover over to null after it is not hover over
func _on_Last_hover_timeout():
	slot_hover = null
