extends Node

var enemyList = {
	"Test Foe": preload("res://Enemies/TestFoe.tscn")
}

func createEnemy(enemyName):
	if enemyName in enemyList:
		var newEnemey = enemyList[enemyName].instantiate()
		return newEnemey
