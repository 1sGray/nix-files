-- =======================================================================================
-- Plugins
-- =======================================================================================

vim.pack.add({ -- Plugin Repos
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/Saghen/blink.cmp"},
    { src = "https://github.com/Saghen/blink.lib" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
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
    { src = "https://github.com/abdul-hamid-achik/keymaps.nvim" },
    { src = "https://github.com/abecodes/tabout.nvim" },
    { src = "https://github.com/DrKJeff16/boolean-toggle.nvim" },
})

-- Treesitter ============================================================================
require("nvim-treesitter").setup({

    ensure_installed = {
        "lua",
        "rust",
        "markdown",
        "markdown_inline",
    },
    highlight = {
        enable = true,
    },

})

-- Treesitter Textobjects ============================================================================
require("nvim-treesitter-textobjects").setup()

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

-- mini.nvim =============================================================================
require("mini.indentscope").setup()
require("mini.align").setup()
-- require("mini.animate").setup()
require("mini.splitjoin").setup()
require("mini.icons").setup()
require("mini.surround").setup()
require("mini.pairs").setup({
})

local miniclue = require('mini.clue')
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = { 'n', 'x' }, keys = '<Leader>' },

        -- `[` and `]` keys
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = { 'n', 'x' }, keys = 'g' },

        -- Marks
        { mode = { 'n', 'x' }, keys = "'" },
        { mode = { 'n', 'x' }, keys = '`' },

        -- Registers
        { mode = { 'n', 'x' }, keys = '"' },
        { mode = { 'i', 'c' }, keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = { 'n', 'x' }, keys = 'z' },
    },

    clues = {
        -- Enhance this by adding descriptions for <Leader> mapping groups
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
    },
})

-- Obsidian.nvim =============================================================================
require("obsidian").setup({
    legacy_commands = false, -- this will be removed in 4.0.0
    workspaces = {
        {
            name = "A's brain",
            path = "~/Documents/Obsidian/Amins Second Brain/As Brain",
        },
    },

    templates = {
        folder = "06 - Obsidian/02 - Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
    },
})

-- tabout =============================================================================
require("tabout").setup()

-- Treesitter ============================================================================
require("boolean-toggle").setup()
-- Keymaps.nvim =============================================================================
require("keymaps").setup()

