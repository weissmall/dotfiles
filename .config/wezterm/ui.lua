local wezterm = require("wezterm")

local M = {}

function M.setColorScheme(config)
	config.color_scheme = "tokyonight_night"
	config.window_background_opacity = 0.90
end

function M.setFonts(config)
	config.font = wezterm.font("JetBrains Mono")
	-- config.font = wezterm.font("Lotion", {
	-- 	weight = "Bold",
	-- })
	-- config.font = wezterm.font("Fira Code", {
	-- 	weight = "Medium",
	-- })
	config.font_size = 12
end

function M.setShell(config)
	config.default_prog = {
		"/usr/bin/zsh",
	}
end

function M.setup(config)
	M.setFonts(config)
	M.setColorScheme(config)
	M.setShell(config)
end

return M
