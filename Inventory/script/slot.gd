extends Control

export(int) var inventory_ID
export(int) var slot_ID

export(bool) var enable = true

export(StyleBox) var StyleBackground

const size = 0.8


func setup():
	get_parent().register_slot(inventory_ID,slot_ID,self)

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

func _ready():
	$item.rect_pivot_offset = $item.rect_size/2
	$background.set("custom_styles/panel",StyleBackground)
	
	$MouseDetecter.rect_pivot_offset = $MouseDetecter.rect_size/2
	$MouseDetecter.rect_scale = Vector2(1.3,1.3)
	
	get_parent().register_self_object(self)

func _on_MouseDetecter_mouse_entered():
	
	$Tween.interpolate_property($item, "rect_scale",
		$item.rect_scale, Vector2(size, size), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	$Tween.start()
	
	AlertEnterPerent()

func _on_MouseDetecter_mouse_exited():
	
	$Tween.interpolate_property($item, "rect_scale",
		$item.rect_scale, Vector2(1, 1), 0.1,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		
	$Tween.start()
	
	AlertExitPerent()

func AlertExitPerent():
	if enable == true:
		get_parent().set_hover_object(null)

func AlertEnterPerent():
	if enable == true:
		get_parent().set_hover_object(self)
