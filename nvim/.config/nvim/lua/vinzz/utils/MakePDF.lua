-- Markdown To Pdf (Latex format)
vim.api.nvim_create_user_command("MakePDF", function()
	-- 1. Definiamo il preambolo LaTeX (i tuoi pacchetti e stili)
	local latex_preamble = [[
% ── Pacchetti base ─────────────────────────────────────────────────────
\usepackage{xcolor}
\usepackage{listings}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{mathrsfs}
\usepackage{float}
\usepackage{cancel}
\usepackage[figurename=Figura]{caption}
\usepackage{microtype}

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

% ── Hyperref ────────────────────────────────────────────────────────────
\usepackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=accentdark,
  urlcolor=accent,
  citecolor=accent,
}

% ── Titoli sezioni ───────────────────────────────────────────────────────
\usepackage{titlesec}
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
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\small\color{codegray}\slshape\leftmark}
\fancyhead[R]{\small\color{codegray}\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\headrule}{{\color{framerule}\hrule width\headwidth height\headrulewidth}}
\setlength{\headheight}{14pt}

% ── Tabelle ─────────────────────────────────────────────────────────────
\usepackage{booktabs}
\usepackage{array}
\renewcommand{\arraystretch}{1.35}

% ── Liste ───────────────────────────────────────────────────────────────
\usepackage{enumitem}
\setlist[itemize]{leftmargin=1.5em,itemsep=2pt,topsep=4pt,parsep=0pt}
\setlist[enumerate]{leftmargin=1.5em,itemsep=2pt,topsep=4pt,parsep=0pt}

% ── Blockquote stilizzato ────────────────────────────────────────────────
\usepackage{mdframed}
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

% ── Immagini: dimensione + posto esatto ──────────────────────────────────
\makeatletter
\def\maxwidth{\ifdim\Gin@nat@width>\linewidth\linewidth\else\Gin@nat@width\fi}
\def\maxheight{\ifdim\Gin@nat@height>0.85\textheight 0.85\textheight\else\Gin@nat@height\fi}
\makeatother
\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}

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
		"-o",
		output,
		"--pdf-engine=xelatex",
		"--listings", -- FONDAMENTALE: Dice a Pandoc di usare il pacchetto listings
		"-H",
		preamble_path, -- Include il nostro file di stile nell'header
		"--resource-path=.", -- Dice a pandoc di cercare le immagini nella cartella corrente
		"-V",
		"geometry:margin=2.5cm",
		"-V",
		"papersize=a4",
		"-V",
		"lang=it", -- Imposta la lingua del documento (opzionale)
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
