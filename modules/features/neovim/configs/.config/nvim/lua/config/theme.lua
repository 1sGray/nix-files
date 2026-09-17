-- Themes ================================================================================
-- vim.cmd("colorscheme gruvbox")

-- Theme Plugins =========================================================================
-- Noctalia Matugen Theming --
-- local noctalia_theme_path = vim.fn.expand("~/.config/nvim/lua/matugen.lua")
--
-- local function apply_noctalia_theme()
--   local ok, theme = pcall(dofile, noctalia_theme_path)
--   if ok and theme and theme.setup then
--     theme.setup()
--   end
-- end
--
-- apply_noctalia_theme()
--
-- local sigusr1 = vim.uv.new_signal()
-- sigusr1:start("sigusr1", vim.schedule_wrap(apply_noctalia_theme))

-- lua/config/theme.lua
local M = {}

local function apply_noctalia_theme()
  local noctalia_theme_path = vim.fn.expand("~/.config/nvim/lua/matugen.lua")
  local ok, theme = pcall(dofile, noctalia_theme_path)
  if ok and theme and theme.setup then
    theme.setup()
  end
end

function M.setup()
  apply_noctalia_theme()
  local sigusr1 = vim.uv.new_signal()
  sigusr1:start("sigusr1", vim.schedule_wrap(apply_noctalia_theme))
end

return M
