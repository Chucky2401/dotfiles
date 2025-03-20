require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
-- local default_opts = {noremap = true}

map("i", "jk", "<ESC>")

-- Telescope files
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", { desc = "Find all files" })
map('n', '<leader>fr', "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<cr>", { desc = "Show all buffers" })
map('n', '<leader>fg', "<cmd>lua require'telescope.builtin'.git_status()<cr>", { desc = "Show Git status" })
map('n', '<leader>f?', ":TodoTelescope<cr>", { desc = "Show telescope todo" })

-- Markdown Preview
map('n', '<leader>mp', "<cmd>MarkdownPreview<cr>", { desc = "Start Markdown preview" })
map('n', '<leader>ms', "<cmd>MarkdownPreviewStop<cr>", { desc = "Stop Markdown preview" })
map('n', '<leader>mt', "<cmd>MarkdownPreivewToggle<cr>", { desc = "Toggle Markdown preview" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
