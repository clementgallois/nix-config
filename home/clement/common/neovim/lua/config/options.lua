-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.snacks_animate = false

vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

-- set 7 lines to the cursor - when moving vertically using j/k
opt.so = 7

-- Always show current position
opt.ruler = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
