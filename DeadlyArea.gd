extends Area2D

func _ready():
	self.connect("body_entered", self, "_on_Area2D_body_entered")

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.die()
