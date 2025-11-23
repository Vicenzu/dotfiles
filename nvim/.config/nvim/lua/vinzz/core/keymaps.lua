local mapkey = require("vinzz.utils.keymapper").mapvimkey

-- Disable arrow keys for moving
vim.keymap.set('', '<Up>', '<Nop>')
vim.keymap.set('', '<Down>', '<Nop>')
vim.keymap.set('', '<Left>', '<Nop>')
vim.keymap.set('', '<Right>', '<Nop>')

vim.keymap.set('i', 'jj', '<Esc>', {desc = "Exit insert mode"})

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Buffer Navigation
mapkey("<leader>bn", "bnext", "n") -- Next buffer
mapkey("<leader>bp", "bprevious", "n") -- Prev buffer
mapkey("<leader>bb", "e #", "n") -- Switch to Other Buffer
mapkey("<leader>`", "e #", "n") -- Switch to Other Buffer

-- Directory Navigation
mapkey("<leader><Tab>", ":Neotree filesystem reveal left<CR>", "n")

-- Fuzzy Finder Navigation
mapkey("<leader>ff", "FzfLua files", "n")
mapkey("<leader>fg", "FzfLua grep_project", "n")
mapkey("<leader>fb", "FzfLua buffers", "n")
mapkey("<leader>fg", "FzfLua grep_project", "n")
mapkey("<leader>fx", "FzfLua diagnostics_document", "n")
mapkey("<leader>fX", "FzfLua diagnostics_workspace", "n")
mapkey("<leader>fc", "FzfLua git_bcommits", "n")
mapkey("<leader>fl", "FzfLua lsp_references", "n")

-- Pane and Window Navigation
mapkey("<C-h>", "<C-w>h", "n") -- Navigate Left
mapkey("<C-j>", "<C-w>j", "n") -- Navigate Down
mapkey("<C-k>", "<C-w>k", "n") -- Navigate Up
mapkey("<C-l>", "<C-w>l", "n") -- Navigate Right
mapkey("<C-h>", "wincmd h", "t") -- Navigate Left
mapkey("<C-j>", "wincmd j", "t") -- Navigate Down
mapkey("<C-k>", "wincmd k", "t") -- Navigate Up
mapkey("<C-l>", "wincmd l", "t") -- Navigate Right
mapkey("<C-h>", "TmuxNavigateLeft", "n") -- Navigate Left
mapkey("<C-j>", "TmuxNavigateDown", "n") -- Navigate Down
mapkey("<C-k>", "TmuxNavigateUp", "n") -- Navigate Up
mapkey("<C-l>", "TmuxNavigateRight", "n") -- Navigate Right

-- Window Management
mapkey("<leader>sv", "vsplit", "n") -- Split Vertically
mapkey("<leader>sh", "split", "n") -- Split Horizontally
mapkey("<C-Up>", "resize +2", "n")
mapkey("<C-Down>", "resize -2", "n")
mapkey("<C-Left>", "vertical resize +2", "n")
mapkey("<C-Right>", "vertical resize -2", "n")

-- Copy Full File-Path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("path:", path)
end, { desc = "Copy Full File-Path" })
-- Indenting
vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true })
vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true })

local api = vim.api

-- Comments
if vim.env.TMUX ~= nil then
	api.nvim_set_keymap("n", "<C-_>", "gtc", { noremap = false })
	api.nvim_set_keymap("v", "<C-_>", "goc", { noremap = false })
else
	api.nvim_set_keymap("n", "<C-/>", "gtc", { noremap = false })
	api.nvim_set_keymap("v", "<C-/>", "goc", { noremap = false })
end

-- Markdown To Pdf (Latex format)
vim.api.nvim_create_user_command("MakePDF", function()
	local input = vim.fn.expand("%:p") -- percorso assoluto del file corrente
	local output = vim.fn.expand("%:r") .. ".pdf"
	local cmd = {
		"pandoc",
		input,
		"-o",
		output,
		"--pdf-engine=xelatex",
    "-V",
    "geometry:margin=2.5cm",
  }

	vim.fn.jobstart(cmd, {
		on_exit = function(_, code)
			if code == 0 then
				print("PDF generato: " .. output)
			else
				print("Errore: conversione fallita")
			end
		end,
	})
end, {})

vim.keymap.set("n", "<leader>cl", ":MakePDF<CR>", {
	desc = "Convert Markdown to PDF (Pandoc XeLaTeX)",
})
