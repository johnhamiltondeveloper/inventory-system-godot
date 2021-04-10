extends Node

var hand

func _init():
	hand = InventoryObject.new()
	hand.set_size(1)

func _ready():
	pass # Replace with function body.
	
func get_inventory(inventory: Array, inventoryOwner: Array, inventoryInterface: PackedScene):
	pass

func Update_Inventory(inventory: Array, inventoryOwner: Array):
	pass

func get_hand_Inventory():
	return hand
