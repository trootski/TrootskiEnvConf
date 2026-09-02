-- mapleader is set once, in vimrc, before plugins load
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Close every buffer except the current one. Deletes only other listed
-- buffers directly via the API, so (unlike the classic `%bd|e#` trick)
-- it never has to spawn a throwaway buffer to hold the window mid-command.
-- With a bang (:BufCloseOthers!), unsaved buffers are force-closed too,
-- discarding their changes -- same as native :bdelete!.
local function buf_close_others(cmd_opts)
  cmd_opts = cmd_opts or {}
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buflisted then
      -- pcall so one buffer with unsaved changes doesn't abort the rest
      -- (only relevant without the bang; force = true never errors here)
      pcall(vim.api.nvim_buf_delete, buf, { force = cmd_opts.bang })
    end
  end
end

vim.api.nvim_create_user_command('BufCloseOthers', buf_close_others, { bang = true })
vim.keymap.set('n', '<leader>bo', buf_close_others, {})
