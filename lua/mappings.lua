require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Harpoon
local mark = require('harpoon.mark')
local ui = require('harpoon.ui')

map("n","<leader>a",mark.add_file)
map("n","<C-e>",ui.toggle_quick_menu)

map("n","<M-1>",function() ui.nav_file(1) end)
map("n","<M-2>",function() ui.nav_file(2) end)
map("n","<M-3>",function() ui.nav_file(3) end)
map("n","<M-4>",function() ui.nav_file(4) end)

-- LSP
vim.keymap.set("n", "<leader>lr", ":LspRestart gopls<CR>", { desc = "Restart LSP" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
