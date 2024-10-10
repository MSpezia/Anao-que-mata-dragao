class_name HealthComponent extends Node

signal on_damage(hp)
signal on_dead

var hp: float
var dead: bool

func take_damage(damage: float) -> void:
	if dead: return
	
	hp -= damage
	if hp <= 0:
		dead = true
		on_dead.emit()
		
	else:
		on_damage.emit(hp)
