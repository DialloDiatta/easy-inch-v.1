extends Node

signal add(value: int)
signal clear
# Not necessary signal sub(value: int)

signal set_goal(goal: int)
signal complete
signal round_start
signal round_end

signal finalize_score(score: int)
signal new_highscore(highscore: int)
