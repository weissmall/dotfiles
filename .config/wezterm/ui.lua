local wezterm = require("wezterm")

local M = {}

function M.setColorScheme(config)
	config.color_scheme = "tokyonight_night"
	config.window_background_opacity = 1
end

function M.setFonts(config)
	config.font = wezterm.font("JetBrains Mono")
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
