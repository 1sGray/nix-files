-- require("config.options")
-- require("config.keymaps")
-- require("config.autocommands")
-- require("config.personal-plugins.floaterminal")

-- =======================================================================================
-- Globals
-- =======================================================================================

-- =======================================================================================
-- Plugins
-- =======================================================================================
vim.pack.add({ -- Plugin Repos
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/Saghen/blink.cmp"},
  { src = "https://github.com/Saghen/blink.lib" }, 
  { src = "https://github.com/neovim/nvim-lspconfig" },
  -- { src = "https://github.com/ellisonleao/gruvbox.nvim" },
  { src = "https://github.com/tris203/precognition.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/RRethy/base16-nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range "*", -- use latest release, remove to use latest commit
  },
})

-- Treesitter ============================================================================
require("nvim-treesitter").setup({

  ensure_installed = {
    "lua",
    "rust",
  },

})

-- Blink.cmp =============================================================================
-- requires rustup and gcc
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup({
  signature = { enabled = true },
  fuzzy = { implementation = "lua" },
})

-- require("blink.cmp").setup({
--   signature = { enabled = true },
--   fuzzy = { implementation = "lua" },
-- })
--
-- precognition ==========================================================================
-- require("precognition").setup({})

-- Telescope ==========================================================================
-- Compile native extensions when the pack changes
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'telescope-fzf-native.nvim' then
      local res = vim.system({ 'make' }, { cwd = ev.data.path })
      if vim.v.shell_error ~= 0 then
        vim.notify('Failed to compile telescope-fzf-native.nvim', vim.log.levels.ERROR)
      else
        vim.notify('Successfully compiled telescope-fzf-native.nvim', vim.log.levels.INFO)
      end
    end
  end,
})

-- Configure Telescope
local ts = require('telescope')
ts.setup({

  defaults = {
      -- layout_strategy = "center",
      border = true,
      borderchars = {
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "│", "│", "│", "│" },
          preview = { "─", "│", "─", "│", "╭", "╮", "│", "│" }
      },
  },

})

-- Keymaps
config = function ()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope help tags' })
end

-- mini.nvim =============================================================================
require("mini.indentscope").setup()
require("mini.align").setup()
-- require("mini.animate").setup()
require("mini.splitjoin").setup()
require("mini.icons").setup()

-- Obsidian.nvim =============================================================================
require("obsidian").setup {
  legacy_commands = false, -- this will be removed in 4.0.0
  workspaces = {
    {
      name = "A's brain",
      path = "~/Documents/Obsidian/Amins Second Brain/As Brain",
    },
  },

-- =======================================================================================
-- LSPs
-- =======================================================================================

-- Native Vim LSP ================================================================================
vim.lsp.enable({"lua_ls", "rust_analyzer", "nixd",})

-- Diagnostics ===========================================================================

vim.diagnostic.config({ virtual_text = true })

-- Completions ===========================================================================

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function (ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
        end
    end,
})

vim.cmd("set completeopt+=noselect") -- Stops inputting the first selected option automatically

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
--
vim.opt.foldmethod = "marker"

-- =======================================================================================
-- Keymaps
-- =======================================================================================

vim.g.mapleader = " " -- Set leader globally, Prefered:<Space>
vim.g.maplocalleader = " "-- Set leader locally, Prefered:<Space>

vim.keymap.set("n", "<leader>to", function() vim.opt.scrolloff = 999 - vim.o.scrolloff end,
  { desc = "A toggle that sets scroll offset super high which keeps your cursor at the middle of the screen and scrolls the content around it" })

vim.keymap.set("n", "<leader>cu", ":update<CR> :source<CR>", { desc = "Updates current file and sources it, mainly nvim config files." })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Writes buffer to file." })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Formats a buffer using the attached LSP" })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exits to normal mode in the terminal" })

-- Diagnostics ===========================================================================
-- Jump between diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Show the diagnostic under the cursor in a floating window
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Send all diagnostics to the location list (quickfix-style)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
