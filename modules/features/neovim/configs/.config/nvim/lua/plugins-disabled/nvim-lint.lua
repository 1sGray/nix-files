return {
  "mfussenegger/nvim-lint",
  -- This lazy-loads linters only when opening an existing or new file in a buffer
  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = {"luacheck"},
    }

    -- A autocmd group where pre-existing auto-commands gets cleared
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    -- Will excute following command when entering a buffer and writing to the buffer
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").try_lint()
      end,
    })
  end
}
