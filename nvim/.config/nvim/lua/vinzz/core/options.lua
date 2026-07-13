local opt = vim.opt

-- Wrapping per righe lunghissime
vim.o.wrap = true       -- Attiva il line wrap visivo
vim.o.linebreak = true  -- Evita di tagliare le parole a metà (spezza solo sullo spazio)
vim.o.breakindent = true -- Mantiene l'indentazione della riga anche quando va a capo
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Tab / Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false

-- Search
opt.incsearch = true
opt.inccommand = "split"
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.number = true
opt.relativenumber = true
opt.cmdheight = 1
opt.scrolloff = 10
opt.completeopt = "menuone,noinsert,noselect"

-- Behaviour
opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.undodir = vim.fn.expand("~/.vim/undodir")
opt.undofile = true
opt.backspace = { "indent,eol,start" }
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.isfname:append("@-@")
opt.updatetime = 50
opt.iskeyword:append("-")
opt.mouse = "a"
opt.clipboard:append("unnamedplus")
opt.modifiable = true
opt.encoding = "UTF-8"
opt.showmode = false

--folds
opt.foldlevel = 99

vim.g.editorconfig = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
})
