extends Control

var inventory_ID = 0
var slot_ID = 0

func _ready():
	get_parent().get_parent().register_self_object(self)

func setup():
	get_parent().get_parent().register_slot(inventory_ID,slot_ID,self)

func _process(delta):
	self.rect_global_position = get_global_mouse_position()

func get_slot_id():
	return slot_ID

func get_inventory_ID():
	return inventory_ID

func refresh(item : ItemInstance):
	
	if item != null:
		$Label.text = str(item.get_quantity())
		$item.texture = ItemDatabase.get_item_texture(item.get_id())
		
	else:
		$Label.text = ""
		$item.texture = null
