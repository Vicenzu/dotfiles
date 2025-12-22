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
-- vim.api.nvim_create_user_command("MakePDF", function()
-- 	local input = vim.fn.expand("%:p") -- percorso assoluto del file corrente
-- 	local output = vim.fn.expand("%:r") .. ".pdf"
-- 	local cmd = {
-- 		"pandoc",
-- 		input,
-- 		"-o",
-- 		output,
-- 		"--pdf-engine=xelatex",
--     "-V",
--     "geometry:margin=2.5cm",
--   }
--
-- 	vim.fn.jobstart(cmd, {
-- 		on_exit = function(_, code)
-- 			if code == 0 then
-- 				print("PDF generato: " .. output)
-- 			else
-- 				print("Errore: conversione fallita")
-- 			end
-- 		end,
-- 	})
-- end, {})
--
-- vim.keymap.set("n", "<leader>cl", ":MakePDF<CR>", {
-- 	desc = "Convert Markdown to PDF (Pandoc XeLaTeX)",
-- })
vim.api.nvim_create_user_command("MakePDF", function()
	-- 1. Definiamo il preambolo LaTeX (i tuoi pacchetti e stili)
	local latex_preamble = [[
% Pacchetti essenziali
\usepackage{xcolor}
\usepackage{listings}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{mathrsfs}
\usepackage{float}
\usepackage{cancel}
\usepackage[figurename=Figura]{caption}

% Definizione colori personalizzati (Abbellimento)
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{backcolour}{rgb}{0.96,0.96,0.96} % Grigio molto chiaro per lo sfondo

% Definizione manuale VHDL (La tua configurazione originale)
\lstdefinelanguage{VHDL}{
  morekeywords={
    architecture,begin,case,component,configuration,
    constant,else,elsif,end,entity,file,for,function,
    generate,if,in,inout,is,label,library,linkage,
    loop,map,new,of,on,open,others,out,package,
    port,process,range,record,report,return,select,
    signal,severity,subtype,then,to,type,use,variable,
    wait,when,while,with,downto
  },
  sensitive=false,
  morecomment=[l]--,
  morecomment=[s]{/*}{*/},
  morestring=[b]",
}

% Stile globale per TUTTI i linguaggi
\lstset{
  backgroundcolor=\color{backcolour},   % Sfondo colorato
  commentstyle=\color{codegreen},       % Commenti verdi
  keywordstyle=\color{blue}\bfseries,   % Keyword blu grassetto
  numberstyle=\tiny\color{codegray},    % Numeri di riga grigi piccoli
  stringstyle=\color{orange!60!black},  % Stringhe arancioni scure
  basicstyle=\ttfamily\footnotesize,    % Font monospaziato
  breakatwhitespace=false,
  breaklines=true,                 % A capo automatico
  captionpos=b,                    % Caption sotto il codice
  keepspaces=true,
  numbers=left,                    % Numeri a sinistra
  numbersep=5pt,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  stepnumber=1,
  tabsize=2,
  frame=lines,                     % Linea sopra e sotto (elegante)
  rulecolor=\color{black!30},      % Colore delle linee del frame
}
]]

	-- 2. Scriviamo questo preambolo in un file temporaneo nella cache di Neovim
	local preamble_path = vim.fn.stdpath("cache") .. "/custom_preamble.tex"
	local file = io.open(preamble_path, "w")
	if file then
		file:write(latex_preamble)
		file:close()
	else
		print("Errore: Impossibile creare il file di preambolo")
		return
	end

	-- 3. Configurazione Pandoc
  local current_file_dir = vim.fn.expand("%:p:h") -- La cartella dove si trova il file .md
	local input = vim.fn.expand("%:t")
	local output = vim.fn.expand("%:t:r") .. ".pdf"
	
	local cmd = {
		"pandoc",
		input,
		"-o", output,
		"--pdf-engine=xelatex",
		"--listings",                -- FONDAMENTALE: Dice a Pandoc di usare il pacchetto listings
		"-H", preamble_path,         -- Include il nostro file di stile nell'header
    "--resource-path=.",     -- Dice a pandoc di cercare le immagini nella cartella corrente
		"-V", "geometry:margin=2.5cm",
		"-V", "papersize=a4",
        "-V", "lang=it",             -- Imposta la lingua del documento (opzionale)
	}

	-- 4. Esecuzione del comando
	print("Generazione PDF in corso...")
	vim.fn.jobstart(cmd, {
    cwd = current_file_dir,
		on_exit = function(_, code)
			if code == 0 then
				print("✅ PDF generato con successo: " .. output)
			else
				print("❌ Errore nella conversione. Controlla la sintassi LaTeX.")
			end
		end,
	})
end, {})

-- Keymap
vim.keymap.set("n", "<leader>cl", ":MakePDF<CR>", {
	desc = "Convert Markdown to PDF (Custom LaTeX Style)",
})
