extends GutTest

var utility = load("res://src/utility.gd")

func test_map():
	var arr = [-1, 0, 1, 2]
	var result = utility.map(func(x): return x*x, arr)
	assert_eq_deep(result, [1, 0, 1, 4])

func test_probability_remap():
	var arr_1 = [0.2, 0.3, 0.5]
	assert_eq_deep(utility.probability_remap(arr_1), [0.2, 0.5, 1.0])
	
	var arr_2 = [0, 0.3, 0.3, 0.4]
	assert_eq_deep(utility.probability_remap(arr_2), [0, 0.3, 0.6, 1.0])
