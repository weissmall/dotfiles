local wezterm = require("wezterm")

local M = {}

function M.setColorScheme(config)
	-- config.color_scheme = "tokyonight_night"
	config.color_scheme = "Rosé Pine Moon (base16)"
	-- config.color_scheme = "Catppuccin Mocha"
	config.window_background_opacity = 1.00
end

function M.setFonts(config)
	config.font = wezterm.font("JetBrains Mono", {
		weight = "Medium",
		italic = false,
	})
	config.line_height = 1.2
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
