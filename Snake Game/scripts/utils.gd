extends Node

func wall_teleport(value: float, length: float) -> float:
	return fposmod(value, length)
