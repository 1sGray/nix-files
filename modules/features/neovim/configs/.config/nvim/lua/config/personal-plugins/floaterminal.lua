local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}
local function create_floating_window(opts)
    -- Default options
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate window position to center the window
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    -- Create the floating window
    local win_opts = {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = opts.border or 'rounded',
    }

    -- Create buffer and window
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
      buf = opts.buf
    else
      buf = vim.api.nvim_create_buf(false, true)
    end
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    -- Optional: set window-local options
    vim.wo[win].winblend = opts.winblend or 10  -- slight transparency
    vim.wo[win].number = opts.number or false
    vim.wo[win].relativenumber = opts.relativenumber or false

    return { buf = buf , win = win }
end

-- Example usage in your Neovim config:
-- Create a command to open a floating window
vim.api.nvim_create_user_command('FloatingWindow', function(args)
    -- Parse optional width and height from command arguments
    local opts = {}
    if #args.fargs >= 1 then
        opts.width = tonumber(args.fargs[1])
    end
    if #args.fargs >= 2 then
        opts.height = tonumber(args.fargs[2])
    end

    create_floating_window(opts)
end, { nargs = '*' })

-- Optionally, add a keybinding
vim.keymap.set('n', '<leader>fw', function()
    create_floating_window()
end, { desc = 'Open Floating Window' })

-- return create_floating_window

  -- A function that creates a floating terminal that can be toggled
local togglable_floating_term = function ()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end
-- A command that creates a floating terminal
vim.api.nvim_create_user_command("Floaterminal", togglable_floating_term, { desc = "Opens and toggles a floating terminal" })
vim.keymap.set({"n", "t"}, "<space>tt", togglable_floating_term, { desc = "Opens and toggles a floating terminal" })

