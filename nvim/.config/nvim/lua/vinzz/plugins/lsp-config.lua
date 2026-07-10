return {
  -- ==========================
  -- NVIM-LSPCONFIG
  -- ==========================
	{
		"neovim/nvim-lspconfig",
		lazy = false,

		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Diagnostic signs
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = "󰠠 ",
				Info = " ",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = true,
				underline = true,
				update_in_insert = false,
				signs = true,
			})

			--------------------------------------------------------------------
			-- PYTHON LS
			--------------------------------------------------------------------
			vim.lsp.config("basedpyright", {
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- PHP
			--------------------------------------------------------------------
			vim.lsp.config("intelephense", {
				capabilities = capabilities,
				settings = {
					intelephense = {
						-- Aumenta la memoria per file grandi
						files = { maxSize = 5000000 },
						-- Questo dice all'LSP quali funzioni esistono (es. WordPress, MySQL, ecc.)
						stubs = {
							"bcmath",
							"date",
							"filter",
							"hash",
							"iconv",
							"json",
							"mbstring",
							"mysqli",
							"mysql",
							"openssl",
							"pcre",
							"PDO",
							"pdo_mysql",
							"readline",
							"session",
							"standard",
							"superglobals",
							"tokenizer",
							"xml",
							"zip",
							"zlib",
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- CLANGD (C/C++/Objective-C)
			--------------------------------------------------------------------
			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=never",
					"--offset-encoding=utf-16",
				},
			})

			--------------------------------------------------------------------
			-- OMNISHARP (C#)
			--------------------------------------------------------------------
			vim.lsp.config("omnisharp", {
				capabilities = capabilities,
				cmd = { "omnisharp" }, -- oppure il path completo se serve
				enable_editorconfig_support = true,
				enable_ms_build_load_projects_on_demand = true,
				enable_roslyn_analyzers = true,
				organize_imports_on_format = true,
				enable_import_completion = true,
			})

			--------------------------------------------------------------------
			-- LUA LS
			--------------------------------------------------------------------
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- EMMET LANGUAGE SERVER
			--------------------------------------------------------------------
			vim.lsp.config("emmet_language_server", {
				capabilities = capabilities,
				filetypes = {
					"css",
					"eruby",
					"html",
					"javascript",
					"javascriptreact",
					"less",
					"sass",
					"scss",
					"pug",
					"typescriptreact",
				},
				init_options = {
					showExpandedAbbreviation = "always",
					showAbbreviationSuggestions = true,
				},
			})

			--------------------------------------------------------------------
			-- DENOLS (manual autocmd — prevents lspconfig default from overriding root_dir)
			--------------------------------------------------------------------
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
				callback = function(args)
					local fname = vim.api.nvim_buf_get_name(args.buf)
					if fname == "" then return end
					local root_found = vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true, path = fname })[1]
					if not root_found then return end
					local root = vim.fs.dirname(root_found)
					vim.lsp.start({
						name = "denols",
						cmd = { vim.fn.stdpath("data") .. "/mason/packages/deno/deno", "lsp" },
						root_dir = root,
						capabilities = capabilities,
					})
				end,
			})

			--------------------------------------------------------------------
			-- ASM LSP
			--------------------------------------------------------------------
			vim.lsp.config("asm_lsp", {
				cmd = { "asm-lsp" },
				filetypes = { "s", "as", "asm", "vmasm", "nasm" },
				root_dir = vim.fs.dirname(
					vim.fs.find({ ".git", "*.asm", "*.s" }, { upward = true })[1] or vim.loop.cwd()
				),
				capabilities = capabilities,
			})

			--------------------------------------------------------------------
			-- ANGULAR LS (dynamic probe locations per project)
			--------------------------------------------------------------------
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "typescript", "html", "typescriptreact" },
				callback = function(args)
					local fname = vim.api.nvim_buf_get_name(args.buf)
					if fname == "" then return end
					local root_found = vim.fs.find({ "angular.json" }, { upward = true, path = fname })[1]
					if not root_found then return end
					local root = vim.fs.dirname(root_found)
					vim.lsp.start({
						name = "angularls",
						cmd = {
							"ngserver", "--stdio",
							"--tsProbeLocations", root .. "/node_modules",
							"--ngProbeLocations", root .. "/node_modules",
						},
						root_dir = root,
						capabilities = capabilities,
					})
				end,
			})

			--------------------------------------------------------------------
			-- TS_LS (Moderno, rimpiazza tsserver)
			--------------------------------------------------------------------
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				root_dir = function(bufnr, cb)
					local fname = vim.api.nvim_buf_get_name(bufnr)
					local util = require("lspconfig.util")
					if util.root_pattern("deno.json", "deno.jsonc")(fname) then
						cb(nil)
						return
					end
					cb(util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname))
				end,
				single_file_support = false,
				init_options = {
					preferences = {
						includeCompletionsWithSnippetText = true,
						includeCompletionsForImportStatements = true,
						importModuleSpecifierEnding = "minimal",
					},
				},
			})

			--------------------------------------------------------------------
			-- LEMMINX (XML)
			--------------------------------------------------------------------
			vim.lsp.config("lemminx", {
				capabilities = capabilities,
			})

			--  ------------------------------------------------------------------
			--                          SQL LS
			--  ------------------------------------------------------------------
			vim.lsp.config("sqlls", {
				cmd = { "sql-language-server", "up", "--method", "stdio" },
				capabilities = capabilities,
				settings = {
					sqls = {
						connections = {
							{
								driver = "mysql",
								dataSourceName = "SQLi_user:password_segreta@tcp(127.0.0.1:3306)/SQLi_db",
							},
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- MARKSMAN (Markdown)
			--------------------------------------------------------------------
			vim.lsp.config("marksman", {
				capabilities = capabilities,
			})

			--------------------------------------------------------------------
			-- TEXLAB (LaTeX) — binario di sistema (pacman), non gestito da mason
			--------------------------------------------------------------------
			vim.lsp.config("texlab", {
				capabilities = capabilities,
				settings = {
					texlab = {
						build = {
							-- la build vera la fa vimtex (latexmk in watch mode);
							-- texlab qui serve solo per diagnostica/completamento
							onSave = false,
						},
						chktex = {
							onOpenAndSave = true,
							onEdit = false,
						},
						forwardSearch = {
							executable = "zathura",
							args = { "--synctex-forward", "%l:1:%f", "%p" },
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- LTEX-LS-PLUS (grammatica/stile italiano — tex, bib, markdown)
			--------------------------------------------------------------------
			vim.lsp.config("ltex_plus", {
				capabilities = capabilities,
				settings = {
					ltex = {
						language = "it",
						-- spellcheck disattivato: la tesi è piena di termini tecnici
						-- inglesi (exploit, malware, worm, host, backdoor...) che
						-- verrebbero segnalati come "parola sconosciuta" all'infinito.
						-- Restano attive grammatica, punteggiatura, concordanze.
						disabledRules = {
							it = { "MORFOLOGIK_RULE_IT_IT" },
						},
					},
				},
			})

			--------------------------------------------------------------------
			-- ENABLE ALL SERVERS
			--------------------------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"emmet_language_server",
				"asm_lsp",
				"ts_ls",
				"sqlls",
				"basedpyright",
				"clangd",
				"omnisharp",
				"intelephense",
				"lemminx",
				"marksman",
				"texlab",
				"ltex_plus",
			})
		end,
	},
}
