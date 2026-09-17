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


