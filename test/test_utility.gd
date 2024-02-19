extends GutTest

var utility = load("res://src/utility.gd")

func test_probability_remap():
	var arr_1 = [0.2, 0.3, 0.5]
	assert_eq_deep(utility.probability_remap(arr_1), [0.2, 0.5, 1.0])
	
	var arr_2 = [0, 0.3, 0.3, 0.4]
	assert_eq_deep(utility.probability_remap(arr_2), [0, 0.3, 0.6, 1.0])

func test_prpbability_remap_with_jag():
	var jag_arr = [[0.3, "hoge"], [0.3, "fuga"], [0.4, "piyo"]]
	assert_eq_deep(utility.probability_remap_with_jag(jag_arr), [[0.3, "hoge"], [0.6, "fuga"], [1.0, "piyo"]])
