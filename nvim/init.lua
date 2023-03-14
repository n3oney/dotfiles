return {
	-- Configure AstroNvim updates
	updater = {
		remote = "origin", -- remote to use
		channel = "stable", -- "stable" or "nightly"
		version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
		branch = "nightly", -- branch name (NIGHTLY ONLY)
		commit = nil, -- commit hash (NIGHTLY ONLY)
		pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
		skip_prompts = false, -- skip prompts about breaking changes
		show_changelog = true, -- show the changelog after performing an update
		auto_quit = false, -- automatically quit the current session after a successful update
	},

	colorscheme = "tokyonight-storm",

	-- Diagnostics configuration (for vim.diagnostics.config({...}))
	diagnostics = {
		virtual_text = true,
		underline = true,
	},

	-- Extend LSP configuration
	lsp = {
		setup_handlers = {
			rust_analyzer = function(_, opts)
				require("rust-tools").setup({
					server = opts,
					tools = {
						inlay_hints = {
							parameter_hinds_prefis = "  ",
							other_hints_preifx = "  ",
						},
					},
				})
			end,
		},

		formatting = {
			filter = function(client)
				if client.name == "tsserver" then
					return false
				end

				return true
			end,
			format_on_save = true,
		},

		-- Add overrides for LSP server settings, the keys are the name of the server
		["config"] = {
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

	polish = function() end,
}
