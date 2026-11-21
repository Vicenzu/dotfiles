-- Markdown To Pdf (Latex format)
vim.api.nvim_create_user_command("MakePDF", function()
	-- 1. Definiamo il preambolo LaTeX evitando conflitti con il template di Pandoc
	local latex_preamble = [[
% ── Pacchetti aggiuntivi (Pandoc carica già amsmath, amssymb, graphicx, xcolor, hyperref, booktabs) ──
\usepackage{listings}
\usepackage{mathrsfs}
\usepackage{float}
\usepackage{cancel}
\usepackage[figurename=Figura]{caption}
\usepackage{microtype}
\usepackage{titlesec}
\usepackage{fancyhdr}
\usepackage{array}
\usepackage{enumitem}
\usepackage{mdframed}

% ── Colori tema ─────────────────────────────────────────────────────────
\definecolor{accent}{HTML}{2563EB}
\definecolor{accentdark}{HTML}{1E3A8A}
\definecolor{codegreen}{HTML}{15803D}
\definecolor{codegray}{HTML}{6B7280}
\definecolor{codepurple}{HTML}{7C3AED}
\definecolor{codeorange}{HTML}{C2410C}
\definecolor{backcolour}{HTML}{F1F5F9}
\definecolor{framerule}{HTML}{CBD5E1}
\definecolor{quotebar}{HTML}{3B82F6}
\definecolor{quotebg}{HTML}{EFF6FF}

% ── Titoli sezioni ───────────────────────────────────────────────────────
\titleformat{\section}
  {\Large\bfseries\color{accentdark}}
  {\thesection}{0.8em}{}[\vspace{2pt}\color{accent}\titlerule\vspace{4pt}]
\titleformat{\subsection}
  {\large\bfseries\color{accent}}
  {\thesubsection}{0.8em}{}
\titleformat{\subsubsection}
  {\normalsize\bfseries\color{accent!75!black}}
  {\thesubsubsection}{0.8em}{}
\titlespacing{\section}{0pt}{18pt}{8pt}
\titlespacing{\subsection}{0pt}{14pt}{4pt}
\titlespacing{\subsubsection}{0pt}{10pt}{2pt}

% ── Header / Footer ──────────────────────────────────────────────────────
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\color{codegray}\slshape\leftmark}
\fancyhead[R]{\small\color{codegray}\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\headrule}{{\color{framerule}\hrule width\headwidth height\headrulewidth}}
\setlength{\headheight}{14pt}

% ── Tabelle & Liste ─────────────────────────────────────────────────────
\renewcommand{\arraystretch}{1.35}
\setlist[itemize]{leftmargin=1.5em,itemsep=2pt,topsep=4pt,parsep=0pt}
\setlist[enumerate]{leftmargin=1.5em,itemsep=2pt,topsep=4pt,parsep=0pt}

% ── Blockquote stilizzato ────────────────────────────────────────────────
\mdfdefinestyle{quotestyle}{
  leftline=true, rightline=false, topline=false, bottomline=false,
  linewidth=3pt, linecolor=quotebar,
  backgroundcolor=quotebg,
  innerleftmargin=12pt, innerrightmargin=8pt,
  innertopmargin=6pt, innerbottommargin=6pt,
  skipabove=8pt, skipbelow=8pt,
}
\renewenvironment{quote}
  {\begin{mdframed}[style=quotestyle]\itshape\color{accentdark}}
  {\end{mdframed}}

% ── Immagini: forza posizionamento [H] ───────────────────────────────────
\let\origfigure\figure
\let\endorigfigure\endfigure
\renewenvironment{figure}[1][]{%
  \origfigure[H]%
}{%
  \endorigfigure
}

% ── Definizione manuale VHDL ─────────────────────────────────────────────
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

% ── Stile codice ─────────────────────────────────────────────────────────
\lstset{
  backgroundcolor=\color{backcolour},
  commentstyle=\color{codegreen}\itshape,
  keywordstyle=\color{accentdark}\bfseries,
  numberstyle=\tiny\color{codegray},
  stringstyle=\color{codeorange},
  identifierstyle=\color{black},
  basicstyle=\ttfamily\footnotesize,
  breakatwhitespace=false,
  breaklines=true,
  captionpos=b,
  keepspaces=true,
  numbers=left,
  numbersep=8pt,
  showspaces=false,
  showstringspaces=false,
  showtabs=false,
  stepnumber=1,
  tabsize=2,
  frame=single,
  rulecolor=\color{framerule},
  xleftmargin=14pt,
  framexleftmargin=14pt,
}
]]

	-- 2. Scriviamo il preambolo nella cache di Neovim
	local preamble_path = vim.fn.stdpath("cache") .. "/custom_preamble.tex"
	local file = io.open(preamble_path, "w")
	if file then
		file:write(latex_preamble)
		file:close()
	else
		vim.notify("Errore: Impossibile creare il file di preambolo", vim.log.levels.ERROR)
		return
	end

	-- 3. Configurazione Pandoc
	local current_file_dir = vim.fn.expand("%:p:h")
	local input = vim.fn.expand("%:t")
	local output = vim.fn.expand("%:t:r") .. ".pdf"

	-- Aggiunge il path di MacTeX se Neovim è stato aperto da GUI e non da terminale
	local env_path = vim.env.PATH or ""
	if not string.find(env_path, "/Library/TeX/texbin") then
		env_path = "/Library/TeX/texbin:" .. env_path
	end

	local cmd = {
		"pandoc",
		input,
		"-o",
		output,
		"--pdf-engine=xelatex", -- <-- CORRETTO (non "mactex")
		"--listings",
		"-H",
		preamble_path,
		"--resource-path=.",
		"-V",
		"geometry:margin=2.5cm",
		"-V",
		"papersize=a4",
		"-V",
		"lang=it",
		"-V",
		"colorlinks=true", -- <-- Gestito da Pandoc per evitare option clash con hyperref
		"-V",
		"linkcolor=accentdark",
		"-V",
		"urlcolor=accent",
		"-V",
		"citecolor=accent",
	}

	local stderr_lines = {}

	-- 4. Esecuzione del comando con cattura errori
	vim.notify("Generazione PDF in corso...", vim.log.levels.INFO)
	vim.fn.jobstart(cmd, {
		cwd = current_file_dir,
		env = { PATH = env_path },
		on_stderr = function(_, data)
			for _, line in ipairs(data) do
				if line ~= "" then
					table.insert(stderr_lines, line)
				end
			end
		end,
		on_exit = function(_, code)
			if code == 0 then
				vim.notify("✅ PDF generato con successo: " .. output, vim.log.levels.INFO)
			else
				local err_msg = table.concat(stderr_lines, "\n")
				vim.notify("❌ Errore nella conversione:\n" .. err_msg, vim.log.levels.ERROR)
			end
		end,
	})
end, {})
