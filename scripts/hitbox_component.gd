class_name HitboxComponent extends Area3D

@export var health_component: HealthComponent

func _take_damage(damage: float) -> void:
	if health_component:
		health_component.take_damage(damage)
