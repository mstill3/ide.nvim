vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

-- make NvimTree open automatically at startup and switch to a given directory if one is passed as an argument
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local args = vim.fn.argv() -- Get command-line arguments

    -- Check if a directory is provided
    if #args > 0 and vim.fn.isdirectory(args[1]) == 1 then
      -- Switch to the provided directory and open NvimTree there
      vim.opt.laststatus = 0
      vim.cmd("cd " .. args[1])
      require("nvim-tree.api").tree.open()
    elseif #args == 0 then
      -- No arguments: Open NvimTree at the current working directory
      vim.opt.laststatus = 0
      require("nvim-tree.api").tree.open()
    end
  end,
})

-- Function to toggle statusline based on buffer type
local function toggle_statusline()
  if vim.bo.filetype == "NvimTree" then
    vim.opt.laststatus = 0 -- Hide statusline when NvimTree is active
  else
    vim.opt.laststatus = 3 -- Global statusline for all other buffers
  end
end

-- Autocmds to apply statusline changes dynamically
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = toggle_statusline,
})

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function()
    -- Ensure statusline is restored if NvimTree is closed
    if #vim.api.nvim_list_wins() == 1 then
      vim.opt.laststatus = 3
    end
  end,
})