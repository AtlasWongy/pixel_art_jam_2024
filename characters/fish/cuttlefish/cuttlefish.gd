extends Fish
class_name CuttleFish

func trigger_death_skill(body: Node2D) -> void:
	SignalBus.on_cuttlefish_death.emit()

