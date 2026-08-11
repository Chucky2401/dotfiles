--
-- AUTOSTART --
--

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	-- hl.exec_cmd(waybar)
	hl.exec_cmd("qs -c TBW-Shell")
	hl.exec_cmd("swaync")
	hl.exec_cmd("swayosd-server")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("~/.local/bin/random_wallpapers.sh")
end)

-- exec-once = swww-daemon & swww img ~/.wallpapers/_Animate/doomguy.1920x1080.gif --transition-type grow --transition-pos top-right --transition-duration 2

-- exec-once = wl-paste --type text --watch cliphist store
-- exec-once = wl-paste --type image --watch cliphist store
