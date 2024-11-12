local w = require("wezterm")
local act = w.action
local M = {}

function M.setKeybinds(config)
	config.leader = M.getLeaderKey()
	M.setKeyTables(config)
	config.keys = {
		{
			key = "h",
			mods = "ALT",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "j",
			mods = "ALT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = "k",
			mods = "ALT",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "l",
			mods = "ALT",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "h",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Left",
				size = { Percent = 50 },
			}),
		},
		{
			key = "l",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Right",
				size = { Percent = 50 },
			}),
		},
		{
			key = "j",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Down",
				size = { Percent = 50 },
			}),
		},
		{
			key = "k",
			mods = "LEADER",
			action = w.action.SplitPane({
				direction = "Up",
				size = { Percent = 50 },
			}),
		},

		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "resize_table",
				one_shot = false,
			}),
		},
		{
			key = "m",
			mods = "LEADER",
			action = act.ActivateKeyTable({
				name = "move_table",
				one_shot = false,
			}),
		},
		{
			key = "t",
			mods = "ALT",
			action = act.ActivateKeyTable({
				name = "tab_mode",
				one_shot = false,
			}),
		},
	}
end

function M.getLeaderKey()
	return {
		key = "e",
		mods = "ALT",
		timeout_milliseconds = 2000,
	}
end

function M.unpacked(t)
	return table.unpack(t)
end

function M.getResizeTable()
	return {
		{ key = "LeftArrow",  action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h",          action = act.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l",          action = act.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow",    action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k",          action = act.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow",  action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j",          action = act.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape",     action = "PopKeyTable" },
	}
end

function M.getMoveTable()
	return {
		{ key = "LeftArrow",  action = act.ActivatePaneDirection("Left") },
		{ key = "h",          action = act.ActivatePaneDirection("Left") },

		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "l",          action = act.ActivatePaneDirection("Right") },

		{ key = "UpArrow",    action = act.ActivatePaneDirection("Up") },
		{ key = "k",          action = act.ActivatePaneDirection("Up") },

		{ key = "DownArrow",  action = act.ActivatePaneDirection("Down") },
		{ key = "j",          action = act.ActivatePaneDirection("Down") },

		-- Cancel the mode by pressing escape
		{ key = "Escape",     action = "PopKeyTable" },
	}
end

function M.getTabModeTable()
	return {
		{
			key = "h",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "l",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "c",
			action = act.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "b",
			action = act.ShowTabNavigator,
		},
		{
			key = "n",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "Escape",
			action = "PopKeyTable",
		},
	}
end

function M.setKeyTables(config)
	config.key_tables = {
		resize_table = M.getResizeTable(),
		move_table = M.getMoveTable(),
		tab_mode = M.getTabModeTable(),
	}
end

w.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

return M
