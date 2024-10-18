-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "tokyonight",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

M.ui = {
  theme = "tokyonight", -- Your preferred theme
  -- transparency = true,

  statusline = {
    theme = "vscode_colored", -- Change to any supported theme: 'default', 'vscode', 'vscode_colored', 'minimal'.
    separator_style = "default", -- You can use 'round', 'block', 'arrow', 'default'
  },
}

return M
