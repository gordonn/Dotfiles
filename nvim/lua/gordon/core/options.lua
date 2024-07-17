vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true

opt.number = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard = "unnamedplus"

opt.splitright = true
opt.splitbelow = true

opt.virtualedit = "block"
