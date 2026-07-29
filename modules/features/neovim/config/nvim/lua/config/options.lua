-- Themes
-- vim.cmd("colorscheme gruvbox")
-- Searching and Patterns
vim.opt.incsearch = true -- highlight all matches while incrementally searching
-- vim.opt.ingnorecase = true -- ignore case in search patterns -- TODO: for some reason error when enabled
vim.opt.smartcase = true -- override 'ignorecase' when pattern has upper case characters

-- Text Display
vim.opt.scrolloff = 10 -- minimal number of screen lines to keep above and below the cursor, changes scorll offseet to `10`, which gives padding to view previous and upcoming code lines from the cursor position
vim.opt.sidescrolloff = 15 -- minimal number of columns to keep left and right of the cursor
vim.opt.wrap = false -- Disable line wrapping
vim.opt.cmdheight = 3 -- number of lines used for the command-line
  -- Line Number
vim.opt.number = true -- Enable Line Numbers
vim.opt.relativenumber = true -- show the relative line number for each line

-- Syntax, Highlighting and Spelling
vim.opt.hlsearch = true -- highlight all matches for the last used search pattern
vim.opt.termguicolors = true -- use GUI colors for the terminal

-- Windows
vim.opt.splitbelow = true -- a new window is put below the current one
vim.opt.splitright = true -- a new window is put right of the current one

-- Mouse
vim.opt.mouse = "a" -- list of flags for using the mouse

-- Text Editing
vim.opt.undofile = true -- automatically save and restore undo history

-- Tabs and Indenting
vim.opt.tabstop = 2 -- number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 2 -- number of spaces used for each step of (auto)indent
vim.opt.expandtab = true -- expand <Tab> to spaces in Insert mode
vim.opt.smartindent = true -- do clever autoindenting

-- Folding
vim.opt.foldmethod = "marker"
