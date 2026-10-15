-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- jj to escape, in insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode" })

-- H / L to cycle buffers
vim.keymap.set("n", "H", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- ; behaves like : (enter command mode)
vim.keymap.set("n", ";", ":", { desc = "Command mode" })
