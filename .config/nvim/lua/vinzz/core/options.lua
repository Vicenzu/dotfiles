local opt = vim.opt

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
--opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99

-- Enable folding ( setup in nvim-ufo )
vim.o.foldenable = true     -- Enable folding by default
vim.o.foldmethod = "manual" -- Default fold method (change as needed)
vim.o.foldlevel = 99        -- Open most folds by default
vim.o.foldcolumn = "0"

vim.g.editorconfig = true
