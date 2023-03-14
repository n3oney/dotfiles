return {
	{
		"laytan/cloak.nvim",
		event = "BufRead",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				highlight_group = "Comment",
				patterns = {
					{
						file_pattern = ".env*",
						cloak_pattern = "=.+",
					},
				},
			})
		end,
	},
	{
		"elkowar/yuck.vim",
		ft = "yuck",
	},
	{
		"ggandor/leap.nvim",
		event = "BufRead",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"github/copilot.vim",
		event = "BufRead",
	},
	{
		"lervag/vimtex",
		ft = "tex",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = { "nvim-treesitter" },
		event = "BufRead",
		config = function()
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 12, -- How many lines the window should span. Values <= 0 mean no limit.
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
					-- For all filetypes
					-- Note that setting an entry here replaces all other patterns for this entry.
					-- By setting the 'default' entry below, you can control which nodes you want to
					-- appear in the context window.
					default = {
						"class",
						"function",
						"method",
						"for",
						"while",
						"if",
						"else",
						"switch",
						"case",
						"interface",
						"struct",
						"enum",
					},
					-- Patterns for specific filetypes
					-- If a pattern is missing, *open a PR* so everyone can benefit.
					tex = {
						"chapter",
						"section",
						"subsection",
						"subsubsection",
					},
					haskell = {
						"adt",
					},
					rust = {
						"impl_item",
					},
					terraform = {
						"block",
						"object_elem",
						"attribute",
					},
					scala = {
						"object_definition",
					},
					vhdl = {
						"process_statement",
						"architecture_body",
						"entity_declaration",
					},
					markdown = {
						"section",
					},
					elixir = {
						"anonymous_function",
						"arguments",
						"block",
						"do_block",
						"list",
						"map",
						"tuple",
						"quoted_content",
					},
					json = {
						"pair",
					},
					typescript = {
						"export_statement",
					},
					yaml = {
						"block_mapping_pair",
					},
				},
				exact_patterns = {
					-- Example for a specific filetype with Lua patterns
					-- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
					-- exactly match "impl_item" only)
					-- rust = true,
				},
				-- [!] The options below are exposed but shouldn't require your attention,
				--     you can safely ignore them.
				zindex = 20, -- The Z-index of the context window
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
	},
	{
		"tpope/vim-sleuth",
		event = "BufRead",
	},
	{
		"wakatime/vim-wakatime",
		event = "BufRead",
	},
	"simrat39/rust-tools.nvim",
	{
		"Saecki/crates.nvim",
		ft = "toml",
		after = "nvim-cmp",
		config = function()
			require("crates").setup()
			local cmp = require("cmp")
			local config = cmp.get_config()
			table.insert(config.sources, { name = "crates", priority = 1100 })
			cmp.setup(config)
			-- Crates mappings:
			local map = vim.api.nvim_set_keymap
			map(
				"n",
				"<leader>Ct",
				":lua require('crates').toggle()<cr>",
				{ desc = "Toggle extra crates.io information" }
			)
			map(
				"n",
				"<leader>Cr",
				":lua require('crates').reload()<cr>",
				{ desc = "Reload information from crates.io" }
			)
			map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate" })
			map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
			map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"lua",
				"css",
				"bash",
				"fish",
				"gitignore",
				"gitcommit",
				"git_rebase",
				"html",
				"json",
				"jsonc",
				"markdown",
				"markdown_inline",
				"rust",
				"sql",
				"svelte",
				"tsx",
				"typescript",
				"toml",
				"javascript",
				"prisma",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"bashls",
				"clangd",
				"cssls",
				"emmet_ls",
				"eslint",
				"jsonls",
				"rust_analyzer",
				"tsserver",
				"tailwindcss",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- overrides `require("mason-tool-installer").setup(...)`
		opts = {
			ensure_installed = { "prettierd", "stylua", "eslint_d" },
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
			local null_ls = require("null-ls")

			local fmt = null_ls.builtins.formatting

			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			opts.sources = {
				fmt.prettierd,
				fmt.eslint_d,
				fmt.stylua,
				fmt.rustywind,
			}

			return opts
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"xiyaowong/telescope-emoji.nvim",
		},
		config = function(plugin, opts)
			require("plugins.configs.telescope")(plugin, opts)

			local telescope = require("telescope")

			telescope.load_extension("emoji")
		end,
	},
}
