return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',

    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
      }

    },

    config = function ()
      require("telescope").setup{
        extensions = {
          fzf = { }
        }
      }
      require("telescope").load_extension("fzf")
      -- Keymaps
      vim.keymap.set("n", "<space>ff", require("telescope.builtin").find_files, { desc = "finding files in telescope" })
      -- vim.keymap.set("n", "<space>en", -- depricated:replacing with a saved session
      --   function()
      --     require("telescope.builtin").find_files {
      --       cwd = vim.fn.stdpath("config")
      --     }
      --   end, {desc= "open the neovim config directory"}
      -- )
    end
  },
}
