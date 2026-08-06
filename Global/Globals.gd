extends Node

class_name Globals

enum Tag{Rifle,Weapon,Interactable}

static var tags : Array[Tag]
static var base : Dictionary[String,Dictionary]
static var weapon : Dictionary[String,Dictionary]
static var rifles : Dictionary[String,String]
static var pistols : Dictionary[String,String]

# Called when the node enters the scene tree for the first time.
static func _setup() -> void:
	rifles.set("FAMAS","Bullpup")
	rifles.set("SA80","Bullpup")
	rifles.set("M16","Assault")
	weapon.set("Rifle",rifles)
	weapon.set("Pistol",pistols)
	base.set("Weapon",weapon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
