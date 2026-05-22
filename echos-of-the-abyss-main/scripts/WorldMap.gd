# WorldMap.gd
class_name WorldMap
extends Node

# The different types of nodes the diver can encounter on the map
enum NodeType { 
	BATTLE,    # Fight a deep sea creature
	REST,      # Catch your breath and heal
	MERCHANT,  # Trade cards and gear
	EVENT,     # A mysterious deep sea encounter
	BOSS       # The abyss creature
}

# Tracks where the diver is in the dive
var depth: int = 0

# The map is a list of depth levels
# Each depth has multiple possible nodes the player can choose between
var map_data = [
	# Depth 0 — always a battle to start the dive
	[{ "type": NodeType.BATTLE }],
	# Depth 1 — first choice, fight or rest
	[{ "type": NodeType.BATTLE }, { "type": NodeType.REST }],
	# Depth 2 — second choice, strange event or merchant
	[{ "type": NodeType.EVENT }, { "type": NodeType.MERCHANT }],
	# Depth 3 — another battle before the final descent
	[{ "type": NodeType.BATTLE }, { "type": NodeType.REST }],
	# Depth 4 — the final boss waits
	[{ "type": NodeType.BOSS }]
]

func get_current_choices() -> Array:
	# Returns what nodes are available at the current depth
	if depth < map_data.size():
		return map_data[depth]
	return []

func choose_node(index: int):
	# Called when the player picks a path
	var choices = get_current_choices()
	if index >= choices.size():
		print("Invalid choice")
		return
	# Get the chosen node and go deeper
	var chosen = choices[index]
	print("Diving deeper... depth ", depth + 1)
	depth += 1
	# Trigger whatever the node type is
	match chosen["type"]:
		NodeType.BATTLE:   start_battle()
		NodeType.REST:     start_rest()
		NodeType.MERCHANT: start_merchant()
		NodeType.EVENT:    start_event()
		NodeType.BOSS:     start_boss()

func start_battle():
	print("A creature emerges from the dark...")

func start_rest():
	print("You find a thermal vent to rest beside. Recovering health...")

func start_merchant():
	print("A strange deep sea salvager offers you cards and gear...")

func start_event():
	print("Something ancient stirs in the water around you...")

func start_boss():
	print("The abyss opens beneath you. The creature awakens...")
