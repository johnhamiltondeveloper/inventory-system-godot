extends Node2D

func _ready():
	changeTool(Item.new())

# update the tool that is in the hand
func changeTool(item : Item):
	if get_node("tool"):
		print("has tool")
	else:
		print("no tool")
