-- snacks.nvim: https://github.com/folke/snacks.nvim
-- Installed via vim-plug (see vimrc), so we call setup() ourselves
-- rather than relying on lazy.nvim's opts-merging.

require("snacks").setup({
  bigfile = { enabled = true },      -- disable slow features on huge files
  explorer = { enabled = true },     -- tree-based file explorer (uses the picker UI)
  indent = {
    enabled = true, -- static indent guides, no animated "active scope" highlight
    animate = { enabled = false },
    scope = { enabled = false },
  },
  input = { enabled = true },        -- nicer vim.ui.input()
  notifier = { enabled = true },     -- nicer vim.notify()
  picker = {
    enabled = true, -- required by explorer; not bound over Telescope
    -- subtle blend instead of a flat, mismatched panel color
    win = {
      input = { winblend = 10 },
      list = { winblend = 10 },
      preview = { winblend = 10 },
    },
  },
  quickfile = { enabled = true },    -- render file before plugins fully load
  statuscolumn = { enabled = true }, -- nicer number/sign/fold column
  words = { enabled = true },        -- auto-highlight references under cursor
})

-- vimrc sets `Normal` transparent (ctermbg=NONE guibg=NONE) so the terminal's
-- own background shows through, but gruvbox still gives NormalFloat/FloatBorder
-- (which Snacks' floating windows render against) their own opaque background.
-- Link those to Normal so Snacks' explorer/picker inherit the same colors
-- instead of showing a mismatched panel. Re-applied on every colorscheme
-- change so switching schemes doesn't undo it.
local function sync_float_highlights()
  local hl = vim.api.nvim_set_hl
  hl(0, "NormalFloat", { link = "Normal" })
  hl(0, "FloatBorder", { link = "Normal" })
  hl(0, "SnacksNormal", { link = "Normal" })
  hl(0, "SnacksNormalNC", { link = "Normal" })
  hl(0, "SnacksWinBar", { link = "Normal" })
  hl(0, "SnacksBackdrop", { link = "Normal" })
end

sync_float_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = sync_float_highlights })

-- No Nerd Font in your terminal yet? nvim-web-devicons' icons will render as
-- "?" boxes until the terminal font has those glyphs. Either install a Nerd
-- Font (e.g. `brew install --cask font-jetbrains-mono-nerd-font`) and set it
-- as your terminal's font, or uncomment the line below to fall back to a
-- single plain icon everywhere instead of per-filetype glyphs:
-- require("nvim-web-devicons").setup({ default = true, color_icons = false })

-- File explorer, replacing the netrw-based <leader>pv habit
vim.keymap.set("n", "<leader>e", function()
  Snacks.explorer()
end, { desc = "Toggle file explorer" })

vim.keymap.set("n", "<leader>fe", function()
  Snacks.explorer()
end, { desc = "Toggle file explorer" })
