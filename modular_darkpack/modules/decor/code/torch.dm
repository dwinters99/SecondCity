/obj/structure/bonfire/torch
	name = "torch"
	desc = "A stick on fire. Revolutionary."
	icon = 'modular_darkpack/modules/decor/icons/torch.dmi'
	icon_state = "torch"
	base_icon_state = "torch"
	density = TRUE
	pass_flags_self = LETPASSTHROW
	burn_icon = "_lit"
	var/start_lit = TRUE

/obj/structure/bonfire/torch/unlit
	start_lit = FALSE

/obj/structure/bonfire/torch/Initialize(mapload)
	. = ..()
	return INITIALIZE_HINT_LATELOAD

// Late init so that we can wait for air to exist in lazyloaded templates
/obj/structure/bonfire/torch/LateInitialize()
	if(start_lit)
		start_burning()
