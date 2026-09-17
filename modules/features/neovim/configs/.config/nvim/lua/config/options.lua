-- =======================================================================================
-- Options
-- =======================================================================================

-- Fonts ================================================================================
vim.g.have_nerd_font = true -- Set Nerdfonts if installed and enabled in term

-- Themes ================================================================================
-- vim.cmd("colorscheme gruvbox")

-- Theme Plugins =========================================================================
-- Noctalia Matugen Theming --
local noctalia_theme_path = vim.fn.expand("~/.config/nvim/lua/matugen.lua")

local function apply_noctalia_theme()
  local ok, theme = pcall(dofile, noctalia_theme_path)
  if ok and theme and theme.setup then
    theme.setup()
  end
end

apply_noctalia_theme()

local sigusr1 = vim.uv.new_signal()
sigusr1:start("sigusr1", vim.schedule_wrap(apply_noctalia_theme))

-- Searching and Patterns ================================================================
-- vim.opt.incsearch = true -- highlight all matches while incrementally searching
-- vim.opt.ingnorecase = true -- ignore case in search patterns -- TODO: for some reason error when enabled
vim.opt.smartcase = true      -- override 'ignorecase' when pattern has upper case characters

-- Text Display ==========================================================================
vim.opt.scrolloff = 10        -- minimal number of screen lines to keep above and below the cursor, changes scorll offseet to `10`, which gives padding to view previous and upcoming code lines from the cursor position
vim.opt.sidescrolloff = 15    -- minimal number of columns to keep left and right of the cursor
vim.opt.wrap = false          -- Disable line wrapping
vim.opt.cmdheight = 2         -- number of lines used for the command-line
vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.conceallevel = 1
-- List Mode
vim.opt.list = true           -- Enable list mode globally
vim.opt.listchars = {
    nbsp = "␣",  -- Non-breaking space
    -- eol = "↲",   -- End of line
    tab = "»\\ ", -- Tab character
    trail = "•", -- Trailing spaces
    -- extends = "›", -- Overflow to right
    -- precedes = "‹", -- Overflow to left
}

-- Line Number ===========================================================================
vim.opt.number = true         -- Enable Line Numbers
vim.opt.relativenumber = true -- show the relative line number for each line

-- Syntax, Highlighting and Spelling =====================================================
vim.opt.hlsearch = true       -- highlight all matches for the last used search pattern
vim.opt.termguicolors = true  -- use GUI colors for the terminal

-- Windows ===============================================================================
vim.opt.splitbelow = true     -- a new window is put below the current one
vim.opt.splitright = true     -- a new window is put right of the current one

-- Mouse =================================================================================
vim.opt.mouse = "a"           -- list of flags for using the mouse

-- Text Editing ==========================================================================
vim.opt.undofile = true       -- automatically save and restore undo history
vim.opt.autoread = true       -- automatically show live updates to file after outside changes

-- Tabs and Indenting ====================================================================
vim.opt.tabstop = 4           -- number of spaces a <Tab> in the text stands for
vim.opt.shiftwidth = 4        -- number of spaces used for each step of (auto)indent
vim.opt.softtabstop = 4
vim.opt.expandtab = true      -- expand <Tab> to spaces in Insert modes
vim.opt.smartindent = true    -- do clever indenting

-- Folding ===============================================================================
vim.opt.foldmethod = "marker"


