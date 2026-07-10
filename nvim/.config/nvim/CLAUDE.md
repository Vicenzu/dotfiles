# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture

This is a Neovim configuration built on [lazy.nvim](https://github.com/folke/lazy.nvim). The entry point is `init.lua`, which loads two modules:

- `lua/vinzz/core/` — vim options (`options.lua`) and all keymaps (`keymaps.lua`)
- `lua/vinzz/lazy.lua` — bootstraps lazy.nvim and auto-imports every file under `lua/vinzz/plugins/`

Each file in `lua/vinzz/plugins/` returns a lazy.nvim plugin spec (table or list of tables). Adding a new file there is sufficient to register a new plugin — no manual registration needed.

Utilities live in `lua/vinzz/utils/`. Currently only `MakePDF.lua` exists, which defines the `:MakePDF` user command (converts the current Markdown file to PDF via `pandoc` + `xelatex`).

## Key Plugin Layers

| Layer | Plugin(s) |
|---|---|
| LSP | `nvim-lspconfig` + `mason.nvim` + `mason-lspconfig.nvim` |
| Completion | `nvim-cmp` + `LuaSnip` + `cmp-nvim-lsp` |
| Formatting | `conform.nvim` — `<leader>gf` to format |
| Linting | `nvim-lint` + `mason-nvim-lint` — `<leader>li` to lint |
| Picker/search | `snacks.nvim` (primary: `<leader>ff/fg/fb`) + Telescope (fallback) |
| File tree | `neo-tree` — `<leader><Tab>` |
| Buffer tabs | `bufferline.nvim` — `Alt-,/.` to cycle |
| Quick-jump | `harpoon` — `<leader>ha` add, `<C-e>` menu |
| Terminal | `snacks.nvim` floating terminal — `<leader>te` |
| Git | `gitsigns`, `diffview.nvim`, `snacks.lazygit` (`<leader>lg`) |
| Debugging | `nvim-dap` + `nvim-dapui` — `<leader>d*` prefix |
| Testing | `vim-test` — `<leader>tt/tT/ts` |
| Code run | `code-runner.nvim` — `<leader>rr/rf` |
| Session | `auto-sessions` — `<leader>wr/ws` |
| Folding | `nvim-ufo` — `zR`/`zM` open/close all folds |
| LaTeX | `vimtex` (latexmk + zathura) — buffer-local `<leader>l*` on `filetype=tex` |

## LSP Servers

Managed by Mason. Configured in `lsp-config.lua`:
`lua_ls`, `ts_ls`, `denols` (Deno projects only), `basedpyright`, `clangd`, `omnisharp`, `intelephense`, `emmet_language_server`, `sqlls`, `asm_lsp`, `lemminx` (XML), `marksman` (Markdown), `texlab` (LaTeX, system binary), `ltex_plus` (grammar, Italian), `angularls` (Angular projects only).

`ts_ls` and `denols` are mutually exclusive — `ts_ls` is disabled when `deno.json`/`deno.jsonc` is present. `denols` and `angularls` start via `FileType` autocmds (probing `deno.json` / `angular.json` upward); the rest go through `vim.lsp.enable`.

## Formatters & Linters

**Formatters** (conform.nvim):
- JS/TS/JSX/TSX/CSS/HTML → `biome-check`
- Lua → `stylua`
- Python → `isort` then `black`
- Java → `google-java-format`
- C/C++ → `clang-format`
- Ruby → `rubocop`
- PHP/Svelte/JSON/YAML/Markdown/GraphQL/Liquid → `prettier`
- LaTeX → `latexindent`

Format-on-save is commented out; trigger manually with `<leader>gf`.

**Linters** (nvim-lint, auto-runs on `BufWritePost`/`InsertLeave`/`LspAttach`):
- JS/TS/JSX/TSX/Svelte → `biomejs`
- Java → `checkstyle` (requires `~/.local/share/nvim/checkstyle/google_checks.xml`)
- Ruby → `rubocop`
- PHP → `phpcs`

## Keymaps — Leader Reference

`<Space>` is the leader. Plugin-dependent maps that require lazy-loading run inside a `VeryLazy` autocmd at the bottom of `keymaps.lua`.

Notable groups (via which-key): `<leader>f` find, `<leader>g` git, `<leader>h` hunks, `<leader>d` DAP, `<leader>t` test/terminal, `<leader>x` Trouble, `<leader>r` run/rename, `<leader>j` Java.

## Adding a Plugin

1. Create `lua/vinzz/plugins/<name>.lua` returning a valid lazy.nvim spec.
2. Add any keymaps to `lua/vinzz/core/keymaps.lua` (or inside the plugin's `keys` table).
3. Reload lazy with `:Lazy sync`.
