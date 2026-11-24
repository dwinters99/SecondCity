// Most common drop, we fall back to this if we fail to roll a real reward on the drop table (i.e. an artifact or fetish)
/obj/item/treasure
	name = "debug treasure"
	desc = "Yarrrrr. If ye' be seein' this, anchor yerself at port an' fill th' ears of a code monkey with yer tale!"
	icon_state = null
	icon = 'icons/obj/maintenance_loot.dmi'
	#warn icon not def
	var/generate_treasure_name = TRUE
	var/generate_treasure_description = TRUE
	var/treasure_color
	var/list/possible_treasure_colors = list()
	var/list/possible_icon_states = list("skub")

/obj/item/treasure/Initialize(mapload)
	. = ..()
	if(generate_treasure_name)
		name = generate_treasure_name()

	if(generate_treasure_description)
		desc = compose_treasure_description(src)

	if(isnull(icon_state))
		icon_state = pick(possible_icon_states)

	color = treasure_color || pick(possible_treasure_colors)

///obj/item/treasure
