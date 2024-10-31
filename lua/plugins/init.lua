return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "gbprod/yanky.nvim",
    lazy = false,
    config = function()
        require("yanky").setup({
            ring = {
                history_length = 100,
                storage = "shada",
                sync_with_numbered_registers = true,
            },
            system_clipboard = {
                sync_with_ring = true,
            },
            highlight = {
                on_put = true,
                on_yank = true,
                timer = 200,
            },
        })

        -- Set Yanky highlight colors to orange-yellow
        vim.api.nvim_set_hl(0, "YankyYanked", { fg = "black", bg = "#FFA500", bold = true })
        vim.api.nvim_set_hl(0, "YankyPut", { fg = "black", bg = "#FFA500", bold = true })

        -- Keybindings
        vim.api.nvim_set_keymap("n", "p", "<Plug>(YankyPutAfter)", {})
        vim.api.nvim_set_keymap("n", "P", "<Plug>(YankyPutBefore)", {})
        vim.api.nvim_set_keymap("n", "<c-n>", "<Plug>(YankyCycleForward)", {})
        vim.api.nvim_set_keymap("n", "<c-p>", "<Plug>(YankyCycleBackward)", {})
    end,
  }
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
