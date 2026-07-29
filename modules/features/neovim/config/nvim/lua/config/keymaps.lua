vim.g.mapleader = " "

vim.keymap.set("n", '<leader>to', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end, { desc = "A toggle that sets scroll offset super high which keeps your cursor at the middle of the screen and scrolls the content around it" })
vim.keymap.set("n", "<leader>cu", ":update<CR> :source<CR>", { desc = "Updates current file and sources it, mainly nvim config files." })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Writes buffer to file." })
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exits to normal mode in the terminal" })

-- Telescope Keymaps
-- local builtin = require('telescope.builtin')
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
