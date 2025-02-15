local M = {}
local api = vim.api

function M.get_cursor_pos(height)
  local editor_height = api.nvim_win_get_height(0)
  local cur_line = vim.fn.winline()
  local line_str = "cursor+2"
  local col_str = "cursor+0"
  if cur_line + height > editor_height - 2 then
    line_str = string.format("cursor-%d", height + 1)
  end
  return line_str, col_str
end

function M.check_lsp_active()
  local active_clients = vim.lsp.get_active_clients()
  if next(active_clients) == nil then
    return false, "No lsp client available"
  end
  return true, nil
end

function M.max(a, b)
  if a > b then
    return a
  else
    return b
  end
end

function M.jump(result)
  vim.lsp.util.jump_to_location(result)
  vim.cmd ":normal! zz"
end

return M
