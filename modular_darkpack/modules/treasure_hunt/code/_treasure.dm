GLOBAL_LIST_INIT(treasure_strings, populate_treasure_strings())

/proc/populate_treasure_strings()
	var/list/all_strings = list()
	var/list/str_lists = list(
		"animal",
		"animalgroup",
		"apparel",
		"artconjunction",
		"artextra_clause",
		"artstyle_adj",
		"character",
		"color",
		"community",
		"composition",
		"concept_angsty",
		"concept_badass",
		"concept_positive",
		"conceptany",
		"depiction",
		"depicts",
		"emotional_expression",
		"enemy",
		"gore",
		"idles",
		"pawn_adj",
		"personjob",
		"quantity_adjphrase",
		"shape",
		"side_position",
		"style_clause",
		"stylegroup",
		"subimageany",
		"subimageplural",
		"subimagesingle",
		"symbolizes",
		"terrainfeature",
		"treetype",
		"vegetable",
		"weapon",)

	for(var/string_list in str_lists)
		all_strings[string_list] = world.file2list("modular_darkpack/modules/treasure_hunt/strings/[string_list].txt")

	return all_strings

/proc/compose_treasure_description()
	var/string = pick(GLOB.treasure_strings["stylegroup"])

	for(var/i = 0 to 50)
		var/bracket_index = findtext(string, "\[")
		if(!bracket_index)
			break
		var/end_bracket_index = findtext(string, "\]", bracket_index)

		var/capture_group = copytext(string, bracket_index+1, end_bracket_index)

		var/string_decided = pick(GLOB.treasure_strings[capture_group])
		if(!istext(string_decided))
			CRASH("Our decided string isn't a string!")

		string = replacetext(string, "\[[capture_group]\]", string_decided)


	return sentence_capitalize(capitalize(string))

/proc/sentence_capitalize(input)
	var/regex/first_letter = new("(?:^|\[.!?\]\\s*)(\\w+)")
	return replacetext(input, first_letter, /proc/capitalize)


#warn test verb in here
/client/verb/font_test()
	set category = "ZZZZZZZdebug"
	set name = "treasure desc"
	set desc = "See all of your achievements!"

	to_chat(src, "[compose_treasure_description()]")
