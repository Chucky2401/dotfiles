--
-- Vars
--
-- Set programs that you use
local terminal = "ghostty"
local fileManager = "nautilus"
local menu = "vicinae toggle"

-- local mainMod = "SUPER"
local mainMod = "SUPER + "
local modShift = mainMod .. "SHIFT + "
local modAlt = mainMod .. "ALT + "
local modCtrl = mainMod .. "CTRL + "

--
-- KEYBINDINGS --
--
-- Hyprland
hl.bind(
	modShift .. "M",
	hl.dsp.exec_cmd("command -v hyprshutdown &>/dev/null && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

-- Suspend when laptop lid is closed
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend || loginctl suspend"), { locked = true })
-- bindl = ,switch:on:Lid Switch, exec, systemctl suspend || loginctl suspend

-- Apps
hl.bind(mainMod .. "E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. "M", hl.dsp.exec_cmd("eww open desktopmusic --toggle"))
hl.bind(mainMod .. "I", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=GNOME gnome-control-center"))
hl.bind(mainMod .. "N", hl.dsp.exec_cmd("networkmanager_dmenu"))
hl.bind(mainMod .. "W", hl.dsp.exec_cmd("vicinae vicinae://launch/wm/switch-windows"))
hl.bind(mainMod .. "RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. "SPACE", hl.dsp.exec_cmd(menu))

hl.bind(modShift .. "C", hl.dsp.exec_cmd("hyprpicker -a -f hex"))
hl.bind(modShift .. "E", hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"))
hl.bind(modShift .. "V", hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"))

hl.bind("Print", hl.dsp.exec_cmd("/usr/bin/flameshot gui"))
hl.bind("ALT + Print", hl.dsp.exec_cmd("/usr/bin/flameshot screen"))

-- Workspaces
-- Switch workspaces with mainMod + [0-9]
hl.bind(mainMod .. "ampersand", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. "eacute", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. "quotedbl", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. "apostrophe", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. "parenleft", hl.dsp.focus({ workspace = 5 }))
hl.bind(mainMod .. "minus", hl.dsp.focus({ workspace = 6 }))
hl.bind(mainMod .. "egrave", hl.dsp.focus({ workspace = 7 }))
hl.bind(mainMod .. "underscore", hl.dsp.focus({ workspace = 8 }))
hl.bind(mainMod .. "ccedilla", hl.dsp.focus({ workspace = 9 }))
hl.bind(mainMod .. "agrave", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. "TAB", hl.dsp.focus({ workspace = "previous" }))

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind(modShift .. "ampersand", hl.dsp.window.move({ workspace = 1 }))
hl.bind(modShift .. "eacute", hl.dsp.window.move({ workspace = 2 }))
hl.bind(modShift .. "quotedbl", hl.dsp.window.move({ workspace = 3 }))
hl.bind(modShift .. "apostrophe", hl.dsp.window.move({ workspace = 4 }))
hl.bind(modShift .. "parenleft", hl.dsp.window.move({ workspace = 5 }))
hl.bind(modShift .. "minus", hl.dsp.window.move({ workspace = 6 }))
hl.bind(modShift .. "egrave", hl.dsp.window.move({ workspace = 7 }))
hl.bind(modShift .. "underscore", hl.dsp.window.move({ workspace = 8 }))
hl.bind(modShift .. "ccedilla", hl.dsp.window.move({ workspace = 9 }))
hl.bind(modShift .. "agrave", hl.dsp.window.move({ workspace = 10 }))

-- Special workspace (scratchpad)
hl.bind(modCtrl .. "S", hl.dsp.workspace.toggle_special("security"))
hl.bind(modCtrl .. "SHIFT + S", hl.dsp.window.move({ workspace = "special:security" }))
hl.bind(modCtrl .. "O", hl.dsp.workspace.toggle_special("other"))
hl.bind(modCtrl .. "SHIFT + O", hl.dsp.window.move({ workspace = "special:other" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Windows
hl.bind(mainMod .. "C", hl.dsp.window.close())
hl.bind(mainMod .. "P", hl.dsp.window.pseudo())
hl.bind(mainMod .. "V", hl.dsp.window.float())
hl.bind(mainMod .. "Z", hl.dsp.layout("togglesplit"))
--- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. "J", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. "K", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. "L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. "F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))

hl.bind(modShift .. "F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(modShift .. "H", hl.dsp.window.move({ direction = "l" }))
hl.bind(modShift .. "J", hl.dsp.window.move({ direction = "u" }))
hl.bind(modShift .. "K", hl.dsp.window.move({ direction = "d" }))
hl.bind(modShift .. "L", hl.dsp.window.move({ direction = "r" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--- Testing group
--- TODO: VALIDATE
hl.bind(mainMod .. "G", hl.dsp.group.toggle())
hl.bind(mainMod .. "right", hl.dsp.group.next())
hl.bind(mainMod .. "left", hl.dsp.group.prev())

hl.bind(modAlt .. "H", hl.dsp.window.move({ into_group = "l" }))
hl.bind(modAlt .. "J", hl.dsp.window.move({ into_group = "u" }))
hl.bind(modAlt .. "K", hl.dsp.window.move({ into_group = "d" }))
hl.bind(modAlt .. "L", hl.dsp.window.move({ into_group = "r" }))
hl.bind(modAlt .. "G", hl.dsp.window.move({ out_of_group = true }))

hl.bind(modCtrl .. "right", hl.dsp.group.move_window({ forward = true }))
hl.bind(modCtrl .. "left", hl.dsp.group.move_window({ forward = false }))
-- bind = $mainMod, G, togglegroup
-- bind = $mainMod, left, changegroupactive, b
-- bind = $mainMod, right, changegroupactive, f
-- bind = $mainMod ALT, h, moveintogroup, l
-- bind = $mainMod ALT, j, moveintogroup, d
-- bind = $mainMod ALT, k, moveintogroup, u
-- bind = $mainMod ALT, l, moveintogroup, r
-- bind = $mainMod ALT, G, moveoutofgroup, r
-- bind = $mainMod CTRL, right, movegroupwindow, f
-- bind = $mainMod CTRL, left, movegroupwindow, b

-- Lock and sleep
hl.bind(mainMod .. "Escape", hl.dsp.exec_cmd("hyprlock"))
hl.bind(
	modAlt .. "I",
	hl.dsp.exec_cmd(
		"[[ -f ~/.inhib_idle ]] && (rm -f ~/.inhib_idle && notify-send -a 'Hyprland' 'Inhib Lock' 'System will lock normally' -u normal --icon=/home/tristan/Images/Icones/information.png) || (touch ~/.inhib_idle && notify-send -a 'Hyprland' 'Inhib Lock' 'System will not lock' -u critical --icon=/home/tristan/Images/Icones/urgent.png)"
	)
)
hl.bind(
	modShift .. "I",
	hl.dsp.exec_cmd(
		"[[ -f ~/.inhib_idle ]] && (notify-send -a 'Hyprland' 'Inhib Lock' 'System will not lock' -u critical --icon=/home/tristan/Images/Icones/urgent.png) || (notify-send -a 'Hyprland' 'Inhib Lock' 'System will lock normally' -u normal --icon=/home/tristan/Images/Icones/information.png)"
	)
)
-- bind = $mainMod, Escape, exec, hyprlock
-- bind = $mainMod ALT, I, exec, sh -c '[[ -f ~/.inhib_idle ]] && (rm -f ~/.inhib_idle && notify-send -a "Hyprland" "Inhib Lock" "System will lock normally" -u normal --icon=/home/tristan/Images/Icones/information.png) || (touch ~/.inhib_idle && notify-send -a "Hyprland" "Inhib Lock" "System will not lock" -u critical --icon=/home/tristan/Images/Icones/urgent.png)'
-- bind = $mainMod SHIFT, I, exec, sh -c "[[ -f ~/.inhib_idle ]] && (notify-send -a 'Hyprland' 'Inhib Lock' 'System will not lock' -u critical --icon=/home/tristan/Images/Icones/urgent.png) || (notify-send -a 'Hyprland' 'Inhib Lock' 'System will lock normally' -u normal --icon=/home/tristan/Images/Icones/information.png)"
-- bind = $mainMod Control_L+SHIFT, L, exec, hyprlock

-- Audio
hl.bind(modShift .. "P", hl.dsp.exec_cmd("playerctl play-pause"))
--- SwayOSD
--- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("swayosd-client --output-volume lower"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	modCtrl .. "SHIFT + M",
	hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	modCtrl .. "SHIFT + M",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
--- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"), { locked = true })

-- Screen
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("swayosd-client --brightness raise"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("swayosd-client --brightness lower"),
	{ locked = true, repeating = true }
)

-- Lock keys
hl.bind("CAPS + Caps_Lock", hl.dsp.exec_cmd("swayosd-client --caps-lock-led input4::capslock"))
hl.bind("Num_Lock", hl.dsp.exec_cmd("swayosd-client --num-lock-led input4::numlock"))

--
-- Submap --
--
-- Switch to a submap called `resize`.
hl.bind("ALT + R", function()
	hl.dsp.exec_cmd("swayosd-client --custom-message='Window resize mode' --custom-icon=dialog-information")
	hl.dsp.submap("resize")
end)

-- Start a submap called "resize".
hl.define_submap("resize", function()
	-- Set repeating binds for resizing the active window.
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })

	-- Use `reset` to go back to the global submap
	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("catchall", function()
		hl.dsp.exec_cmd("swayosd-client --custom-message='Exit resize mode' --custom-icon=dialog-information")
		hl.dsp.submap("reset")
	end)
end)

-- bind = ALT, R, exec, swayosd-client --custom-message="Window resize mode" --custom-icon=dialog-information
-- bind = ALT, R, submap, resize
-- -- Start a submap called "resize".
-- submap = resize
-- -- Set repeatable binds for resizing the active window.
-- binde = , H, resizeactive, -10 0
-- binde = , J, resizeactive, 0 -10
-- binde = , K, resizeactive, 0 10
-- binde = , L, resizeactive, 10 0
-- -- Use `reset` to go back to the global submap
-- bind = , catchall, submap, reset
-- bind = , catchall, exec, swayosd-client --custom-message="Exit resize mode" --custom-icon=dialog-information
-- -- bind = , escape, submap, reset
-- -- Reset the submap, which will return to the global submap
-- submap = reset

-- Misc
-- Reload WayBar
-- bind = $mainMod Alt_L, R, exec, killall -SIGUSR2 waybar

-- TODO: History
-- Swww
-- bind = $mainMod CTRL+SHIFT, w, exec, swww img ~/.wallpapers/_Animate/doomguy.1920x1080.gif --transition-type grow --transition-pos top-right --transition-duration 2
-- bind = $mainMod CTRL+SHIFT+ALT, w, exec, swww img ~/.wallpapers/_Animate/kaneki.gif --transition-type grow --transition-pos top-right --transition-duration 2
