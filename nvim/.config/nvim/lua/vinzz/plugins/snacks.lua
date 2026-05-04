return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			-- ==========================================
			-- 1. UI & STYLING CORE
			-- ==========================================
			styles = {
				input = {
					keys = {
						n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
						i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					},
				},
			},

			input = { enabled = true },

			words = { enabled = true, debounce = 200, notify_jump = false }, -- Sostituisce hlslens

			-- ==========================================
			-- 2. FILE MANAGEMENT & NAVIGATION
			-- ==========================================
			quickfile = { enabled = true, exclude = { "latex" } },

      picker = {
				enabled = true,
				matchers = { frecency = true, cwd_bonus = false },
				formatters = { file = { filename_first = false, filename_only = false, icon_width = 2 } },
				layout = { preset = "telescope", cycle = false },
				layouts = {
					select = {
						preview = false,
						layout = {
							backdrop = false,
							width = 0.6,
							min_width = 80,
							height = 0.4,
							min_height = 10,
							box = "vertical",
							border = "rounded",
							title = "{title}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
						},
					},
					telescope = {
						reverse = true,
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.8,
							height = 0.9,
							border = "none",
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.50,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							width = 0,
							height = 0.4,
							position = "bottom",
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "bottom" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
							},
						},
					},
				},
			},

			-- ==========================================
			-- 3. TERMINAL & EXTERNAL TOOLS
			-- ==========================================
			terminal = {
				enabled = true,
				win = { style = "terminal", position = "float", height = 0.8, width = 0.8, border = "rounded" },
			},

			lazygit = { enabled = true }, -- NUOVO: Integrazione per Lazygit

			-- ==========================================
			-- 4. VISUALS & DASHBOARD
			-- ==========================================
			image = {
				enabled = true,
				doc = { float = false, inline = true, max_width = 50, max_height = 30, wo = { wrap = true } },
				convert = { notify = true, command = "magick" },
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments",
					"~/Scrivania",
					"~/Documenti",
					"~/Immagini",
					"~/Scaricati",
				},
			},

			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
					{
						section = "terminal",
						cmd = "ascii-image-converter ~/Immagini/undertaker.png -f -C -c",
						random = 10,
						pane = 2,
						pane_gap = 5,
						padding = 1,
						indent = 4,
						height = 30,
					},
				},
			},
		},
	},
}
