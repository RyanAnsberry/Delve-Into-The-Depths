extends Control

@onready var money_label = $Money

func set_money_label(amount):
	money_label.text = str(amount)
