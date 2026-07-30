-- require("config.options")
-- require("config.keymaps")
-- require("config.autocommands")
-- require("config.personal-plugins.floaterminal")

-- ### Globals ### --
-- Set leader globally and locally Prefered:<Space>
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Set Nerdfonts if installed and enabled in term
vim.g.have_nerd_font = true

-- ### Plugins ### --
vim.pack.add({ -- Plugin Repos
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/Saghen/blink.cmp"},
  -- { src = ""},
  -- { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  -- QOL Plugins
})

--  Treesitter
require("nvim-treesitter.configs").setup({
  enshure_installed = {
    "lua",
    "rust",
  },
})

-- Blink.cmp
require("blink.cmp").setup({
  signature = { enabled = true },
  fuzzy = { implementation = "lua" },
})
-- ### LSPs ### --
vim.lsp.enable({
  "lua_ls",
  "rust_analyzer",
})
-- lua_ls
--require "lspconfig".lua_ls.setup {}
-- rust-analyzer
--require "lspconfig".rust_analyzer.setup({
--  capabilities = capabilities,
--  on_attach = on_attach,
--  cmd = {
--    "rustup", "run", "stable", "rust-analyzer",
--  }
--})

-- ### Options ### --
-- Themes
vim.cmd("colorscheme gruvbox")
-- Theme Plugins
-- Searching and Patterns                                                                                                                    vim.opt.incsearch = true -- highlight all matches while incrementally searching
-- vim.opt.ingnorecase = true -- ignore case in search patterns -- TODO: for some reason error when enabled
vim.opt.smartcase = true      -- override 'ignorecase' when pattern has upper case characters
-- Text Display
vim.opt.scrolloff = 10        -- minimal number of screen lines to keep above and below the cursor, changes scorll offseet to `10`, which gives padding to view previous and upcoming code lines from the cursor position
vim.opt.sidescrolloff = 15    -- minimal number of columns to keep left and right of the cursor
vim.opt.wrap = false          -- Disable line wrapping
vim.opt.cmdheight = 3         -- number of lines used for the command-line
vim.opt.winborder = "rounded"
-- Line Number
vim.opt.number = true         -- Enable Line Numbers
vim.opt.relativenumber = true -- show the relative line number for each line
-- Syntax, Highlighting and Spelling
vim.opt.hlsearch = true       -- highlight all matches for the last used search pattern
vim.opt.termguicolors = true  -- use GUI colors for the terminal
-- Windows
vim.opt.splitbelow = true     -- a new window is put below the current one
vim.opt.splitright = true     -- a new window is put right of the current one
-- Mouse
vim.opt.mouse = "a"           -- list of flags for using the mouse
-- Text Editing
vim.opt.undofile = true       -- automatically save and restore undo history
-- Tabs and Indenting
vim.opt.tabstop = 2           -- number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 2        -- number of spaces used for each step of (auto)indent
vim.opt.expandtab = true      -- expand <Tab> to spaces in Insert mode
-- Folding
vim.opt.foldmethod = "marker"

-- ### Keymaps ### --
vim.keymap.set("n", "<leader>to", function() vim.opt.scrolloff = 999 - vim.o.scrolloff end,
  {
    desc =
    "A toggle that sets scroll offset super high which keeps your cursor at the middle of the screen and scrolls the content around it"
  })
vim.keymap.set("n", "<leader>cu", ":update<CR> :source<CR>",
  { desc = "Updates current file and sources it, mainly nvim config files." })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Writes buffer to file." })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exits to normal mode in the terminal" })
