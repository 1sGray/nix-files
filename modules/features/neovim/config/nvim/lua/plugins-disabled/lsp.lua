return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {"Saghen/blink.cmp"},
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },

    config = function()

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      local lspconfig = require("lspconfig")

      -- LSPs --
      -- Lua Language Server
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      lspconfig.rust_analyzer.setup({
        settings = {
          ['rust-analyzer'] = {
            diagnostics = {
              enable = false;
            }
          }
        },
        capabilities = capabilities
      })

      -- KEYMAPPS --
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Display info about hovered symbol" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, {})

    end,
  },

}
