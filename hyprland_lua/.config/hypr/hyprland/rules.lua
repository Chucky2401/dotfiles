--
-- LOOK AND FEEL --
--
-- Workspace
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "1", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "2", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "3", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "4", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "5", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "6", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "7", monitor = "desc:Samsung Electric Company C27F390 H4ZT602474" })
hl.workspace_rule({ workspace = "8", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "9", monitor = "desc:Samsung Electric Company C27F390 H4ZT603085" })

-- Windows rules
hl.window_rule({
	name = "Fullscreen window red border",
	match = {
		fullscreen_state_client = 1,
		workspace = "w[tv1-99]",
	},
	border_color = "rgb(cc1d1d)",
	border_size = 3,
})

hl.window_rule({
	name = "One window on workspace",
	match = {
		float = false,
		workspace = "w[tv1]",
	},
	border_size = 0,
})

hl.window_rule({
	name = "Fullscreen window",
	match = {
		float = false,
		workspace = "f[1]",
	},
	rounding = 0,
})

--
-- CUSTOM --
--
hl.window_rule({
	name = "Ignore maximize request from apps",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name = "Fix dragging issues with XWayland",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- CopyQ floating
-- windowrule {
--   name = windowrule-6
--   tag = +copyq_menu
--   match:title = (CopyQ)
-- }
--
-- windowrule {
--   name = windowrule-7
--   float = on
--   stay_focused = on
--   size = (monitor_w*0.22) (monitor_h*0.6)
--   match:tag = copyq_menu
-- }

hl.window_rule({
	name = "Ghostty opacity",
	match = {
		class = "com\\.mitchellh\\.ghostty",
	},
	opacity = "0.95 0.75",
})

-- Gnome App
hl.window_rule({
	name = "Tagging Gnome app",
	match = {
		class = "(org\\.gnome\\.(Calculator|Settings))",
	},
	tag = "+gnome_app",
})

hl.window_rule({
	name = "Gnome app tagged",
	match = {
		tag = "gnome_app",
	},
	float = true,
	size = { "(monitor_w*0.5)", "(monitor_h*0.6)" },
})

hl.window_rule({
	name = "Gnome control center",
	match = {
		class = "org\\.gnome\\.Settings",
	},
	size = { 800, 850 },
})

-- KDE app
hl.window_rule({
	name = "Tagging KDE app",
	match = {
		class = "(org\\.kde\\.kcalc)",
	},
	tag = "+kde_app",
})

hl.window_rule({
	name = "KDE app tagged",
	match = {
		tag = "kde_app",
	},
	float = true,
	size = { 442, 419 },
})

-- Show me the key
hl.window_rule({
	name = "ShowMeTheKey",
	match = {
		class = "showmethekey-gtk",
	},
	float = true,
	size = { 1900, 90 },
	opacity = "0.8",
})
