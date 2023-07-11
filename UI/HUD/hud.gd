extends Control

func set_score(score : int = 0):
	$ScoreLabel.text = str(score)

func set_money(money : float = 0):
	$MoneyLabel.text = "R$" + str(money)
