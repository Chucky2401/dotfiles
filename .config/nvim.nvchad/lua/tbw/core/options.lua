vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Disable wrap
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- Scroll
opt.scrolloff = 8

-- cursorline
opt.cursorline = true
opt.cursorlineopt = "both"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- Fold method
opt.foldmethod = "indent"

