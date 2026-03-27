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
			-- DENOLS
			--------------------------------------------------------------------
			vim.lsp.config("denols", {
				capabilities = capabilities,
				root_dir = vim.fs.dirname(
					vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1] or vim.loop.cwd()
				),
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
			-- TS_LS (Moderno, rimpiazza tsserver)
			--------------------------------------------------------------------
			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				root_dir = function(fname)
					local util = require("lspconfig.util")
					return not util.root_pattern("deno.json", "deno.jsonc")(fname)
						and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
				end,
				single_file_support = false,
				init_options = {
					preferences = {
						includeCompletionsWithSnippetText = true,
						includeCompletionsForImportStatements = true,
					},
				},
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
			-- ENABLE ALL SERVERS
			--------------------------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"emmet_language_server",
				"denols",
				"asm_lsp",
				"ts_ls",
				"sqlls",
				"basedpyright",
				"clangd",
				"omnisharp",
        "intelephense"
			})
		end,
	},
}
