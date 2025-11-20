return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "→",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"emmet_ls",
					"emmet_language_server",
					"denols",
					"asm_lsp",
					"ts_ls",
					"sqlls",
					"omnisharp",
					"basedpyright",
					"jdtls",
					"clangd",
				},
			})
		end,
	},
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
			-- ON_ATTACH (keymaps quando un LSP si attacca al buffer)
			--------------------------------------------------------------------
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspKeymaps", {}),
				callback = function(ev)

          -- map func for keymaps
					local function map(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, {
							buffer = ev.buf,
							silent = true,
							desc = desc,
						})
					end

					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "gd", vim.lsp.buf.definition, "Go to definition")
					map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")

					map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Implementations")
					map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Type Definitions")
					map("n", "gR", "<cmd>Telescope lsp_references<CR>", "References")

					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("n", "<leader>rn", vim.lsp.buf.rename, "Rename under Cursor")

					map("n", "<leader>d", vim.diagnostic.open_float, "Inline Diagnostic")
					map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer Diagnostic")

					map("n", "<leader>rs", "<cmd>LspRestart<CR>", "Riavvia LSP")
				end,
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
			-- EMMET LS
			--------------------------------------------------------------------
			vim.lsp.config("emmet_ls", {
				capabilities = capabilities,
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
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
								dataSourceName = "giuseppec:NuovaPasswordSicura!@tcp(127.0.0.1:3306)/prova",
							},
							{
								driver = "sqlite3",
								filename = "/home/giuseppec/databases/provas.db",
							},
						},
					},
				},
			})

			-- ------------------------------------------------------------------
			--                          JDTLS (Java)
			-- ------------------------------------------------------------------
			local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
			local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
			local config_dir = jdtls_path .. "/config_linux"
			local workspace = vim.fn.stdpath("data")
				.. "/jdtls-workspace/"
				.. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

			vim.lsp.config("jdtls", {
				capabilities = capabilities,
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"-Xmx2G",
					"-jar",
					launcher_jar,
					"-configuration",
					config_dir,
					"-data",
					workspace,
				},
				root_dir = vim.fs.dirname(vim.fs.find({
					".git",
					"mvnw",
					"gradlew",
					"pom.xml",
					"build.gradle",
				}, { upward = true })[1] or vim.loop.cwd()),
			})

			--------------------------------------------------------------------
			-- ENABLE ALL SERVERS
			--------------------------------------------------------------------
			vim.lsp.enable({
				"lua_ls",
				"emmet_ls",
				"emmet_language_server",
				"denols",
				"asm_lsp",
				"ts_ls",
				"jdtls",
				"sqlls",
				"basedpyright",
				"clangd",
				"omnisharp",
			})
		end,
	},
}
