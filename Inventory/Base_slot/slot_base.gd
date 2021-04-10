extends Control

export(int) var inventory_ID
export(int) var slot_ID

export(bool) var enable = true

signal refresh

func setup():
	get_parent().register_slot(inventory_ID,slot_ID,self)

func get_slot_id():
	return slot_ID

func get_inventory_ID():
	return inventory_ID

func refresh(item : ItemInstance):
	emit_signal("refresh")

func _ready():
	get_parent().register_self_object(self)

func _notification(what):
	
	match what:
		
		NOTIFICATION_MOUSE_ENTER:
			if enable == true:
				get_parent().set_hover_object(self)
				
		NOTIFICATION_MOUSE_EXIT:
			if enable == true:
				get_parent().set_hover_object(null)
