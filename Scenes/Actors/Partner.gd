extends KinematicBody2D

export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGER_RANGE = 4

enum {
	IDLE,
	WANDER,
	CHASE
}

func _ready():
	pass
