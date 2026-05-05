require("vinzz.utils.MakePDF")
local map = vim.keymap.set
local function nmap(key, cmd) vim.keymap.set("n", key, cmd, { noremap = true, silent = true }) end
-- =============================================================================
-- CORE
-- =============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

map("v", "<", "<gv", { silent = true, noremap = true })
map("v", ">", ">gv", { silent = true, noremap = true })

map("n", "<leader>pa",
  function()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("path:", path)
  end,
  { desc = "Copy full file path" })

if vim.env.TMUX ~= nil then
	map("n", "<C-_>", "gtc", { noremap = false, desc = "Comment line (tmux)" })
	map("v", "<C-_>", "goc", { noremap = false, desc = "Comment selection (tmux)" })
else
	map("n", "<C-/>", "gtc", { noremap = false, desc = "Comment line" })
	map("v", "<C-/>", "goc", { noremap = false, desc = "Comment selection" })
end

-- =============================================================================
-- WINDOW / SPLITS
-- =============================================================================

map("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split horizontal" })
map("n", "<leader>sm", "<cmd>MaximizerToggle<CR>", { desc = "Maximize/minimize split" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Resize up" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Resize down" })
map("n", "<C-Left>", "<cmd>vertical resize +2<CR>", { desc = "Resize left" })
map("n", "<C-Right>", "<cmd>vertical resize -2<CR>", { desc = "Resize right" })

-- Pane navigation (tmux-aware, vim-tmux-navigator gestisce i conflitti)
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Navigate left" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Navigate down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Navigate up" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Navigate right" })

map("t", "<C-h>", "<cmd>wincmd h<CR>", { desc = "Navigate left (term)" })
map("t", "<C-j>", "<cmd>wincmd j<CR>", { desc = "Navigate down (term)" })
map("t", "<C-k>", "<cmd>wincmd k<CR>", { desc = "Navigate up (term)" })
map("t", "<C-l>", "<cmd>wincmd l<CR>", { desc = "Navigate right (term)" })

-- =============================================================================
-- SNACKS Terminal
-- =============================================================================

map("n", "<leader>te", function() require("snacks").terminal.toggle() end, { desc = "Terminal: toggle" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Terminal: normal mode" })

-- =============================================================================
-- BUFFER NAVIGATION
-- =============================================================================

map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Alternate buffer" })
map("n", "<leader>`", "<cmd>e #<CR>", { desc = "Alternate buffer" })

-- -- =============================================================================
-- BUFFERLINE
-- =============================================================================

map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>",        { desc = "Buffer: prev" })
map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>",        { desc = "Buffer: next" })
map("n", "<A-<>", "<cmd>BufferLineMovePrev<CR>",         { desc = "Buffer: move prev" })
map("n", "<A->>", "<cmd>BufferLineMoveNext<CR>",         { desc = "Buffer: move next" })
map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>",     { desc = "Buffer: goto 1" })
map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>",     { desc = "Buffer: goto 2" })
map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>",     { desc = "Buffer: goto 3" })
map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>",     { desc = "Buffer: goto 4" })
map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>",     { desc = "Buffer: goto 5" })
map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>",     { desc = "Buffer: goto 6" })
map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>",     { desc = "Buffer: goto 7" })
map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>",     { desc = "Buffer: goto 8" })
map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>",     { desc = "Buffer: goto 9" })
map("n", "<A-0>", "<cmd>BufferLineGoToBuffer -1<CR>",    { desc = "Buffer: last" })
map("n", "<A-p>", "<cmd>BufferLineTogglePin<CR>",        { desc = "Buffer: pin/unpin" })
map("n", "<A-c>", function() require("snacks").bufdelete() end, { desc = "Buffer: close" })
map("n", "<C-p>", "<cmd>BufferLinePick<CR>",             { desc = "Buffer: pick (lettera)" })
map("n", "<A-s>", "<cmd>BufferLinePickClose<CR>",        { desc = "Buffer: pick e chiudi" })
map("n", "<leader>bco","<cmd>BufferLineCloseOthers<CR>", { desc = "Buffer: chiudi altri" })
map("n", "<leader>bcl","<cmd>BufferLineCloseLeft<CR>",   { desc = "Buffer: chiudi a sinistra" })
map("n", "<leader>bcr","<cmd>BufferLineCloseRight<CR>",  { desc = "Buffer: chiudi a destra" })
map("n", "<Space>bb", "<cmd>BufferLineSortByTabs<CR>",   { desc = "Buffer: sort by tab" })
map("n", "<Space>bn", "<cmd>BufferLineSortByRelativeDirectory<CR>", { desc = "Buffer: sort by dir" })

-- =============================================================================
-- FILE TREE
-- =============================================================================

map("n", "<leader><Tab>", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Neotree toggle" })

-- =============================================================================
-- TELESCOPE
-- =============================================================================

map("n", "<leader>fa", "<cmd>Telescope<CR>", { desc = "Telescope: all" })
map("n", "<leader>tth", "<cmd>Telescope themes<CR>", { desc = "Telescope: themes" })

-- =============================================================================
-- MINI SURROUND (non funzionano in questo file)
-- =============================================================================
-- map ({"n", "v"}, "sa", function() require("mini.surround").add() end, {desc = "Add surrounding"})
-- map("n", "ds", function() require("mini.surround").delete() end, {desc = "Delete surrounding"})
-- map("n", "sf", function() require("mini.surround").find() end, {desc = "Find surrounding (to the right)"})
-- map("n", "sF", function() require("mini.surround").find_left() end, {desc = "Find surrounding (to the left)"})
-- map("n", "sh", function() require("mini.surround").highlight() end, {desc = "Highlight surrounding"}) map("n", "sr", function() require("mini.surround").replace() end, {desc = "Replace surrounding"})
-- map("n", "sn", function() require("mini.surround").update_n_lines() end, {desc = "Update n lines"})
-- map("n", "l", function() require("mini.surround").suffix_last() end, {desc = "Suffix to search with 'prev' method"})
-- map("n", "n", function() require("mini.surround").suffix_next() end, {desc = "Suffix to search with 'next' method"})

-- =============================================================================
-- SNACKS PICKER
-- =============================================================================

map("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Picker: files" })
map("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Picker: grep" })
map("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Picker: buffers" })
map("n", "<leader>fk", function() require("snacks").picker.keymaps() end, { desc = "Picker: keymaps" })
map("n", "<leader>fh", function() require("snacks").picker.help() end, { desc = "Picker: help" })
map("n", "<leader>fx", function() require("snacks").picker.diagnostics_buffer() end, { desc = "Picker: doc diagnostics" })
map("n", "<leader>fX", function() require("snacks").picker.diagnostics() end, { desc = "Picker: ws diagnostics" })
map("n", "<leader>fl", function() require("snacks").picker.lsp_references() end, { desc = "Picker: LSP refs" })
map("n", "<leader>fc", function() require("snacks").picker.git_log_file() end, { desc = "Picker: git log file" })
map("n", "<leader>pr", function() require("snacks").picker.recent() end, { desc = "Picker: recent files" })
map("n", "<leader>ths", function() require("snacks").picker.colorschemes() end, { desc = "Picker: colorschemes" })
map("n", "<leader>pWs", function() require("snacks").picker.grep_word() end, { desc = "Picker: grep WORD" })
map({ "n", "x" }, "<leader>pws", function() require("snacks").picker.grep_word() end, { desc = "Picker: grep word" })
map("n", "<leader>gbr", function() require("snacks").picker.git_branches({ layout = "select" }) end, { desc = "Snacks: git branches" })
map("n", "<leader>th", function() require("snacks").picker.colorschemes({ layout = "ivy" }) end, { desc = "Snacks: colorschemes" })
map("n", "<leader>vh", function() require("snacks").picker.help() end, { desc = "Snacks: help" })
map("n", "<leader>pt", function() require("snacks").picker.todo_comments() end, { desc = "Snacks: todos" })

-- =============================================================================
-- SNACKS WORKFLOW
-- =============================================================================

map("n", "<leader>lg", function()local current_dir = vim.fn.expand("%:p:h") require("snacks").lazygit({cwd = current_dir}) end, { desc = "Lazygit" })
map("n", "<leader>gl", function() require("snacks").lazygit.log() end, { desc = "Lazygit log" })
map("n", "<leader>rN", function() require("snacks").rename.rename_file() end, { desc = "Rename file" })
map("n", "<leader>dB", function() require("snacks").bufdelete() end, { desc = "Delete buffer" })

-- =============================================================================
-- Keymaps che richiedono plugin (caricati dopo lazy.nvim)
-- =============================================================================

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- HARPOON
		local harpoon = require("harpoon")
		map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: add" })
		map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
		map("n", "<C-y>", function() harpoon:list():select(1) end, { desc = "Harpoon: file 1" })
		map("n", "<C-i>", function() harpoon:list():select(2) end, { desc = "Harpoon: file 2" })
		map("n", "<C-n>", function() harpoon:list():select(3) end, { desc = "Harpoon: file 3" })
		map("n", "<C-s>", function() harpoon:list():select(4) end, { desc = "Harpoon: file 4" })
		map("n", "<C-S-P>", function() harpoon:list():prev() end, { desc = "Harpoon: prev" })
		map("n", "<C-S-N>", function() harpoon:list():next() end, { desc = "Harpoon: next" })

		-- GIT SIGNS
		map("n", "]h", function() require("gitsigns").next_hunk() end, { desc = "Gitsigns: next hunk" })
		map("n", "[h", function() require("gitsigns").prev_hunk() end, { desc = "Gitsigns: previous hunk" })
		map("n", "<leader>hs", function() require("gitsigns").stage_hunk() end, { desc = "Gitsigns: stage hunk" })
		map("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, { desc = "Gitsigns: reset hunk" })
		map("n", "<leader>hb", function() require("gitsigns").blame_line() end, { desc = "Gitsigns: blame line" })
		map("n", "<leader>hbi", function() require("gitsigns").toggle_current_line_blame() end, { desc = "Gitsigns: inline blame line (toggle)" })
		map("n", "<leader>hd", function() require("gitsigns").diffthis() end, { desc = "Gitsigns: diff" })
		map("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, { desc = "Gitsigns: preview hunk" })

    -- Snacks next word occurrence
    map("n", "]w", function() require("snacks").words.jump(1) end, { desc = "Snacks: next word occurrence" })
    map("n", "[w", function() require("snacks").words.jump(-1) end, { desc = "Snacks: prev word occurrence" })

		-- TODO COMMENTS
		map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Todo: next" })
		map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Todo: prev" })

		-- MINI
		map("n", "<leader>cw", function() require("mini.trailspace").trim() end, { desc = "Trim whitespace" })

		-- UFO FOLDING
		map("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
		map("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })

		require("which-key").add({
			{ "<leader>f", group = "find (telescope)" },
			{ "<leader>g", group = "git" },
			{ "<leader>h", group = "git hunks" },
			{ "<leader>j", group = "java" },
			{ "<leader>r", group = "run / rename" },
			{ "<leader>s", group = "sniprun / surround" },
			{ "<leader>t", group = "test / terminal" },
			{ "<leader>x", group = "trouble" },
			{ "<leader>d", group = "debug (dap)" },
		})
	end,
})

-- =============================================================================
-- NOICE
-- =============================================================================

map("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Noice: dismiss" })
map("n", "<leader>nh", "<cmd>Noice history<CR>", { desc = "Noice: history" })

-- =============================================================================
-- LSP
-- =============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),
	callback = function(ev)
		local function lmap(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
		end

		lmap("n", "gd", vim.lsp.buf.definition, "LSP: definition")
		lmap("n", "gD", vim.lsp.buf.declaration, "LSP: declaration")
		lmap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "LSP: implementations")
		lmap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "LSP: type definitions")
		lmap("n", "gR", "<cmd>Telescope lsp_references<CR>", "LSP: references")
		lmap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: code action")
		lmap("n", "<leader>rn", vim.lsp.buf.rename, "LSP: rename")
		lmap("n", "<leader>d", vim.diagnostic.open_float, "LSP: inline diagnostic")
		lmap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "LSP: buffer diagnostics")
		lmap("n", "<leader>rs", "<cmd>LspRestart<CR>", "LSP: restart")
	end,
})
-- DIAGNOSTICS
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Prev diagnostic" })
-- Opzionale: salta solo agli errori (severity = ERROR)
map("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Next error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, { desc = "Prev error" })

-- =============================================================================
-- FORMATTING & LINTING
-- =============================================================================

map({ "n", "v" }, "<leader>gf", function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000 }) end, { desc = "Format" })
map("n", "<leader>li", function() require("lint").try_lint() end, { desc = "Run linter" })

-- =============================================================================
-- TROUBLE
-- =============================================================================

map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble: workspace" })
map("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Trouble: document" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<CR>", { desc = "Trouble: quickfix" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<CR>", { desc = "Trouble: loclist" })
map("n", "<leader>xt", "<cmd>Trouble todo toggle<CR>", { desc = "Trouble: todos" })

-- =============================================================================
-- CODE RUNNING
-- =============================================================================

map("n", "<leader>rr", "<cmd>RunCode<CR>", { desc = "Run: code" })
map("n", "<leader>rf", "<cmd>RunFile<CR>", { desc = "Run: file" })
map("n", "<leader>rft", "<cmd>RunFile tab<CR>", { desc = "Run: file in tab" })
map("n", "<leader>rp", "<cmd>RunProject<CR>", { desc = "Run: project" })
map("n", "<leader>rc", "<cmd>RunClose<CR>", { desc = "Run: close" })
map("n", "<leader>crf", "<cmd>CRFiletype<CR>", { desc = "Run: set filetype" })
map("n", "<leader>crp", "<cmd>CRProjects<CR>", { desc = "Run: projects" })

-- =============================================================================
-- SNIPRUN
-- =============================================================================

map({ "n", "v" }, "<leader>sr", "<cmd>SnipRun<CR>", { desc = "SnipRun: run" })
map("n", "<leader>sc", "<cmd>SnipClose<CR>", { desc = "SnipRun: close" })
map("n", "<leader>sx", "<cmd>SnipReset<CR>", { desc = "SnipRun: reset" })

-- =============================================================================
-- TESTING (vim-test)
-- =============================================================================

map("n", "<leader>tt", "<cmd>TestNearest<CR>", { desc = "Test: nearest" })
map("n", "<leader>tT", "<cmd>TestFile<CR>", { desc = "Test: file" })
map("n", "<leader>ts", "<cmd>TestSuite<CR>", { desc = "Test: suite" })
map("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "Test: last" })
map("n", "<leader>tv", "<cmd>TestVisit<CR>", { desc = "Test: visit" })

-- =============================================================================
-- DAP
-- =============================================================================
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP: breakpoint" })
map("n", "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, { desc = "DAP: conditional bp" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP: continue" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP: step into" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "DAP: step over" })
map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "DAP: step out" })
map("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "DAP: repl" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "DAP: run last" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP: toggle UI" })
map("n", "<leader>dx", function() require("dap").terminate() end, { desc = "DAP: terminate" })

-- =============================================================================
-- JAVA (nvim-java)
-- =============================================================================

map("n", "<leader>jr", "<cmd>JavaRunnerRunMain<CR>", { desc = "Java: run main" })
map("n", "<leader>js", "<cmd>JavaRunnerStopMain<CR>", { desc = "Java: stop" })
map("n", "<leader>jtl", "<cmd>JavaRunnerToggleLogs<CR>", { desc = "Java: toggle logs" })
map("n", "<leader>jb", "<cmd>JavaBuildBuildWorkspace<CR>", { desc = "Java: build" })

-- =============================================================================
-- EDITING UTILITIES
-- =============================================================================

-- Undotree
map("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { desc = "Undotree toggle" })
-- img-clip
map("n", "<leader>pi", "<cmd>PasteImage<CR>", { desc = "Paste image" })

-- =============================================================================
-- SESSIONS
-- =============================================================================

map("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Session: restore" })
map("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Session: save" })

-- =============================================================================
-- MARKDOWN → PDF
-- =============================================================================

map("n", "<leader>cl", "<cmd>MakePDF<CR>", { desc = "Markdown → PDF" })

-- =============================================================================
-- MERGE CONFLICTS
-- =============================================================================
-- Merge conflicts con diffview.nvim
map("n", "<leader>gdo", "<cmd>DiffviewOpen<cr>", { desc = "Diffview: apri" })
map("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview: history file" })
map("n", "<leader>gdc", "<cmd>DiffviewClose<cr>", { desc = "Diffview: chiudi" })
-- <leader>co   → accetta OURS (blocco sinistro)
-- <leader>ct   → accetta THEIRS (blocco destro)
-- <leader>cb   → accetta BASE
-- <leader>ca   → accetta tutti e tre insieme (per conflitti complessi)
-- dx           → elimina il conflitto senza scegliere nessuno
-- ]x / [x      → naviga tra i conflitti

-- ============================================================================
-- SPECTRE
-- ============================================================================
map("n", "<leader>so", function() require("spectre").open() end, { desc = "Spectre: open" })
map("n", "<leader>sw", function() require("spectre").open_visual({ select_word = true }) end, { desc = "Spectre: search word" })
map("n", "<leader>sf", function() require("spectre").open_file_search() end, { desc = "Spectre: search in file" })

-- ============================================================================
-- MARKDOWN-PREVIEW
-- ============================================================================
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown: preview browser" })

-- ==========================================
-- TREESJ (Split/Join)
-- ==========================================
map("n", "<leader>m", function() require('treesj').toggle() end, { desc = "Toggle Split/Join" })

map({ "x", "o" }, "am", function() require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects") end)
map({ "x", "o" }, "im", function() require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects") end)
map({ "x", "o" }, "ac", function() require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects") end)
map({ "x", "o" }, "ic", function() require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects") end)
