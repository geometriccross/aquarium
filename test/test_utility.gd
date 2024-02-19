extends GutTest

var utility = load("res://src/utility.gd")

func test_map():
	var arr = [-1, 0, 1, 2]
	var result = utility.map(func(x): return x*x, arr)
	assert_eq_deep(result, [1, 0, 1, 4])
