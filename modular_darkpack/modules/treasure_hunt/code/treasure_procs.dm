GLOBAL_LIST_INIT(treasure_strings, populate_treasure_strings())

GLOBAL_LIST_INIT(treasure_adjectives, world.file2list("modular_darkpack/modules/treasure_hunt/strings/names/adjectives.txt"))
GLOBAL_LIST_INIT(treasure_nouns, world.file2list("modular_darkpack/modules/treasure_hunt/strings/names/nouns.txt"))
GLOBAL_LIST_INIT(treasure_objects, world.file2list("modular_darkpack/modules/treasure_hunt/strings/names/objects.txt"))

/proc/populate_treasure_strings()
	var/list/all_strings = list()
	var/list/str_lists = list(
		"adjangsty",
		"adjany",
		"adjbadass",
		"adjfriendly",
		"adjnatural",
		"ally",
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
		"descpawn",
		"descsentence",
		"emotional_expression",
		"enemy",
		"game",
		"gore",
		"idles",
		"image",
		"naturalobject",
		"pawn_adj",
		"personjob",
		"physicaldescriptionroot",
		"quantity_adjphrase",
		"sculpture",
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

/proc/compose_treasure_description(thing)
	if(isnull(thing))
		CRASH("compose_treasure_description() called without args!")
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

		string = replacetext(string, "\[[capture_group]\]", string_decided, max(1, bracket_index-1), end_bracket_index+1)

	string = replacetext(string, "%ATOM%", thing)

	return sentence_capitalize(capitalize(string))

/proc/sentence_capitalize(text)
	var/static/regex/reg
	if(!reg)
		reg = regex(@"(^|[.!?]\s*)([a-z])", "g")

	while(reg.Find(text))
		var/start = reg.index
		var/matched = reg.match
		var/prefix = reg.group[1]
		var/letter = reg.group[2]

		text = copytext(text, 1, start) + prefix + uppertext(letter) + copytext(text, start + length(matched))

	return text

/proc/generate_treasure_name()
	var/t_adj = pick(GLOB.treasure_adjectives)
	var/t_noun = pick(GLOB.treasure_nouns)
	var/t_obj = pick(GLOB.treasure_objects)

	var/generated_name

	if(prob(25))
		generated_name = "[t_adj] [t_noun] [t_obj]"
	else if(prob(33))
		generated_name = "[t_adj] [t_obj]"
	else if(prob(50))
		generated_name = "[t_noun] [t_obj]"
	else
		generated_name = "[t_obj]"

	return generated_name

#warn test verb in here
/client/verb/font_test()
	set category = "ZZZZZZZdebug"
	set name = "treasure desc"
	set desc = "See all of your achievements!"

	to_chat(src, "[compose_treasure_description(src)]")

/obj/item/treasure/proc/generate_treasure_name()
	var/t_adj = pick(GLOB.treasure_adjectives)
	var/t_noun = pick(GLOB.treasure_nouns)
	var/t_obj = pick(GLOB.treasure_objects)

	var/generated_name = name

	if(prob(25))
		generated_name = "[t_adj] [t_noun] [t_obj]"
	else if(prob(33))
		generated_name = "[t_adj] [t_obj]"
	else if(prob(50))
		generated_name = "[t_noun] [t_obj]"
	else
		generated_name = "[t_obj]"

	return generated_name
