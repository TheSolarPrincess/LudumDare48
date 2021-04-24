extends Area2D

export var nominal = 1

func _ready():
	self.connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		get_parent().queue_free()
		get_tree().get_nodes_in_group("UI")[0].add_coin(nominal)
