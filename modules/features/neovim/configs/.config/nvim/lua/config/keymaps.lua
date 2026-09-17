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

-- Telescope ===========================================================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', "<leader>ff", builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', "<leader>fg", builtin.live_grep,  { desc = 'Telescope live grep'  })
vim.keymap.set('n', "<leader>fb", builtin.buffers,    { desc = 'Telescope buffers'    })
vim.keymap.set('n', "<leader>fh", builtin.help_tags,  { desc = 'Telescope help tags'  })
vim.keymap.set('n', "<leader>fc", builtin.command_history,    { desc = 'Telescope help tags'  })

-- Obsidian.nvim ===========================================================================
-- The following allows the default`gf`(got to file) to work with obsidians
vim.keymap.set("n", "gf", function()
    if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
    else
        return "gf"
    end
end, { noremap = false, expr = true })

-- Keymaps.nvim ===========================================================================
vim.keymap.set('n', "<leader>?", "<cmd>Keymaps<cr>", { desc = "Show Keymaps" })


