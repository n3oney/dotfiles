--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key

local util = require("lspconfig.util")

local config = {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "nightly", -- branch name (NIGHTLY ONLY)
		-- commit = "556666a", -- commit hash (NIGHTLY ONLY)
		pin_plugins = true, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_reload = false, -- automatically reload and sync packer after a successful update
		auto_quit = false, -- automatically quit the current session after a successful update
	},

	-- Set colorscheme to use
	colorscheme = "tokyonight-storm",

	-- Override highlight groups in any theme
	highlights = {
		-- duskfox = { -- a table of overrides/changes to the default
		--   Normal = { bg = "#000000" },
		-- },
		default_theme = function(highlights) -- or a function that returns a new table of colors to set
			local C = require("default_theme.colors")

			highlights.Normal = { fg = C.fg, bg = C.bg }
			return highlights
		end,
	},

	-- set vim options here (vim.<first_key>.<second_key> =  value)
	options = {
		opt = {
			-- conceallevel = 1,
			relativenumber = true, -- sets vim.opt.relativenumber
			guifont = {
				"monospace",
				":h10",
			},
		},
		g = {
			mapleader = " ", -- sets vim.g.mapleader
			vimtex_view_method = "zathura",
			vimtex_compiler_method = "tectonic",
			tex_conceal = "abdmg",
			copilot_no_tab_map = "v:true",
		},
		o = {
			shell = (vim.fn.has("macunix")) == 1 and "/sbin/fish" or vim.o.shell,
		},
	},

	header = {
		" █████  ███████ ████████ ██████   ██████",
		"██   ██ ██         ██    ██   ██ ██    ██",
		"███████ ███████    ██    ██████  ██    ██",
		"██   ██      ██    ██    ██   ██ ██    ██",
		"██   ██ ███████    ██    ██   ██  ██████",
		" ",
		"    ███    ██ ██    ██ ██ ███    ███",
		"    ████   ██ ██    ██ ██ ████  ████",
		"    ██ ██  ██ ██    ██ ██ ██ ████ ██",
		"    ██  ██ ██  ██  ██  ██ ██  ██  ██",
		"    ██   ████   ████   ██ ██      ██",
	},

	-- Diagnostics configuration (for vim.diagnostics.config({...}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Extend LSP configuration
	lsp = {
		-- Skip rust_analyzer setup because we have an additional plugin
		skip_setup = {
			"rust_analyzer",
		},

		formatting = {
			filter = function(client)
				if client.name == "tsserver" then
					return false
				end

				if client.name == "sumneko_lua" then
					return false
				end

				return true
			end,
		},

		servers = {
			-- "unocss",
		},

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			-- example for addings schemas to yamlls
			-- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
			--   settings = {
			--     yaml = {
			--       schemas = {
			--         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
			--         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
			--         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
			--       },
			--     },
			--   },
			-- },

			unocss = {
				cmd = { "unocss-language-server", "--stdio" },
				filetypes = {
					"html",
					"javascriptreact",
					"rescript",
					"typescriptreact",
					"vue",
					"svelte",
				},
				on_new_config = function(new_config) end,
				root_dir = function(fname)
					return util.root_pattern("unocss.config.js", "unocss.config.ts")(fname)
						or util.find_package_json_ancestor(fname)
						or util.find_node_modules_ancestor(fname)
						or util.find_git_ancestor(fname)
				end,
			},

			-- Enable auto-save in rust_analyzer
			rust_analyzer = {
				on_attach = function(client, buf)
					local fmt_group = vim.api.nvim_create_augroup("FORMATTING", { clear = true })

					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = buf })

						vim.api.nvim_create_autocmd("BufWritePre", {
							group = fmt_group,
							buffer = buf,
							callback = function()
								vim.lsp.buf.formatting_sync({
									timeout_ms = 3000,
								})
							end,
						})
					end
				end,
			},
		},
	},

	-- Mapping data with "desc" stored directly by vim.keymap.set().
	--
	-- Please use this mappings table to set keyboard mapping since this is the
	-- lower level configuration and more robust one. (which-key will
	-- automatically pick-up stored data by this setting.)
	--      local map = vim.api.nvim_set_keymap
	mappings = {
		-- first key is the mode
		n = {
			-- second key is the lefthand side of the map
			["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
			["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
			["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
			["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
		},
		i = {
			["<C-J>"] = { "copilot#Accept()", silent = true, expr = true },
		},
	},

	-- Configure plugins
	plugins = {
		init = {
			-- You can disable default plugins as follows:
			-- ["goolord/alpha-nvim"] = { disable = true },
			{
				"elkowar/yuck.vim",
			},
			{
				"ggandor/leap.nvim",
				config = function()
					require("leap").add_default_mappings()
				end,
			},
			{
				"github/copilot.vim",
			},
			{
				"lervag/vimtex",
			},
			{
				"xiyaowong/telescope-emoji.nvim",
			},
			{
				"nvim-treesitter/nvim-treesitter-context",
				after = { "nvim-treesitter" },
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
			{ "folke/tokyonight.nvim" },
			{ "tpope/vim-sleuth" },
			{ "wakatime/vim-wakatime" },
			{ "rakr/vim-one" },
			{
				"simrat39/rust-tools.nvim",
				after = { "mason-lspconfig.nvim" },
				config = function()
					require("rust-tools").setup({
						server = astronvim.lsp.server_settings("rust_analyzer"),
						tools = {
							inlay_hints = {
								parameter_hinds_prefis = "  ",
								other_hints_preifx = "  ",
							},
						},
					})
				end,
			},
			{
				"Saecki/crates.nvim",
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
					map(
						"v",
						"<leader>CU",
						":lua require('crates').upgrade_crates()<cr>",
						{ desc = "Upgrade selected crates" }
					)
					map(
						"n",
						"<leader>CA",
						":lua require('crates').upgrade_all_crates()<cr>",
						{ desc = "Upgrade all crates" }
					)
				end,
			},
		},

		["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
			-- config variable is the default configuration table for the setup function call
			local null_ls = require("null-ls")

			local fmt = null_ls.builtins.formatting
			-- Check supported formatters and linters
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
			config.sources = {
				fmt.prettierd,
				fmt.eslint_d,
				fmt.stylua,
				fmt.rustywind,
			}

			return config
		end,
		["neo-tree"] = {
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = false,
			default_component_configs = {
				indent = {
					indent_size = 2,
					padding = 0,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = false,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
				},
				git_status = {
					symbols = {
						added = "",
						deleted = "",
						modified = "",
						renamed = "➜",
						untracked = "★",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 25,
				mappings = {
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["o"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["C"] = "close_node",
					["<bs>"] = "navigate_up",
					["."] = "toggle_hidden",
					["R"] = "refresh",
					["/"] = "fuzzy_finder",
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
				},
			},
			nesting_rules = {},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = true,
					hide_gitignored = false,
					hide_by_name = {
						".DS_Store",
						"thumbs.db",
						"node_modules",
						"__pycache__",
					},
				},
				follow_current_file = true,
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
			},
			buffers = {
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
					},
				},
			},
			event_handlers = {
				{
					event = "vim_buffer_enter",
					handler = function(_)
						if vim.bo.filetype == "neo-tree" then
							vim.wo.signcolumn = "auto"
						end
					end,
				},
			},
		},
		treesitter = { -- overrides `require("treesitter").setup(...)`
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
		telescope = {
			extensions = { "emoji" },
		},
		-- use mason-lspconfig to configure LSP installations
		["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
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
		-- use mason-tool-installer to configure DAP/Formatters/Linter installation
		["mason-tool-installer"] = { -- overrides `require("mason-tool-installer").setup(...)`
			ensure_installed = { "prettierd", "stylua", "eslint_d" },
		},
		packer = { -- overrides `require("packer").setup(...)`
			compile_path = vim.fn.stdpath("data") .. "/packer_compiled.lua",
		},
	},

	-- LuaSnip Options
	luasnip = {
		-- Add paths for including more VS Code style snippets in luasnip
		vscode_snippet_paths = {},
		-- Extend filetypes
		filetype_extend = {
			javascript = { "javascriptreact" },
		},
	},

	-- CMP Source Priorities
	-- modify here the priorities of default cmp sources
	-- higher value == higher priority
	-- The value can also be set to a boolean for disabling default sources:
	-- false == disabled
	-- true == 1000
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 750,
			buffer = 500,
			path = 250,
		},
	},

	-- Modify which-key registration (Use this with mappings table in the above.)
	["which-key"] = {
		-- Add bindings which show up as group name
		register_mappings = {
			-- first key is the mode, n == normal mode
			n = {
				-- second key is the prefix, <leader> prefixes
				["<leader>"] = {
					-- third key is the key to bring up next level and its displayed
					-- group name in which-key top level menu
					["b"] = { name = "Buffer" },
				},
			},
		},
	},

	-- This function is run last and is a good place to configuring
	-- augroups/autocommands and custom filetypes also this just pure lua so
	-- anything that doesn't fit in the normal config locations above can go here
	polish = function()
		-- Set key binding
		-- Set autocommands
		vim.api.nvim_create_augroup("packer_conf", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			desc = "Sync packer after modifying plugins.lua",
			group = "packer_conf",
			pattern = "plugins.lua",
			command = "source <afile> | PackerSync",
		})

		-- Set up custom filetypes
		-- vim.filetype.add {
		--   extension = {
		--     foo = "fooscript",
		--   },
		--   filename = {
		--     ["Foofile"] = "fooscript",
		--   },
		--   pattern = {
		--     ["~/%.config/foo/.*"] = "fooscript",
		--   },
		-- }
	end,
}

return config
