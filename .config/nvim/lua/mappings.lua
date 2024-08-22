require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
-- local default_opts = {noremap = true}

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
-- map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)
-- map('n', '<leader>fr', "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<cr>", default_opts)
-- map('n', '<leader>fg', "<cmd>lua require'telescope.builtin'.git_status()<cr>", default_opts)
-- map('n', '<leader>f?', ":TodoTelescope<cr>", default_opts)
map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", { desc = "Find all files" })
map('n', '<leader>fr', "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<cr>", { desc = "Show all buffers" })
map('n', '<leader>fg', "<cmd>lua require'telescope.builtin'.git_status()<cr>", { desc = "Show Git status" })
map('n', '<leader>f?', ":TodoTelescope<cr>", { desc = "Show telescope todo" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
