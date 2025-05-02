extends Node

var enemyList = {
	"Test Foe": preload("res://Actors/Enemies/TestFoe.tscn")
}

func createEnemy(enemyName):
	if enemyName in enemyList:
		var newEnemey = enemyList[enemyName].instantiate()
		return newEnemey
