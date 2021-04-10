extends Node

var items = {}

func _ready():
	
	## Opens items directory
	var directory = Directory.new()
	
	if directory.dir_exists("res://Items") == false:
		print("No item directory at: res://Items")
		return
	
	directory.open("res://Items")
	
	# Stars reading files
	directory.list_dir_begin()
	
	# get first file
	var filename = directory.get_next()
	
	# loops though all files
	while(filename):
		
		# chack if this is a file and not a directory
		if not directory.current_is_dir():
			
			# load resource
			var LoadedResource = load("res://Items/%s" % filename)
			
			# chacks if the resource is of type item
			if LoadedResource is Item:
				
				# chack if there is an item with the same id
				if items.has(LoadedResource.id) == false:
					items[LoadedResource.id] = LoadedResource
				# prints and error with the items that have overlaping ids
				else:
					printerr("Item -> ##", LoadedResource.name, "## has an overlaping ID with item -> ##", items[LoadedResource.id].name,"##")
				
		
		filename = directory.get_next()
	
	directory.list_dir_end()

func get_item_texture(id) -> Texture:
	
	if items.has(id):
		return items[id].texture
		
	return preload("res://icon.png")

func get_item_name(id) -> String:
	if items.has(id):
		return items[id].name
	return ""

func get_item_stack_size(id) -> int:
	if items.has(id):
		return items[id].stack_size
	
	return 0
