return {
	opt = {
		-- conceallevel = 1,
		relativenumber = true,
		guifont = {
			"monospace",
			":h10",
		},
	},
	g = {
		mapleader = " ",
		vimtex_view_method = "zathura",
		vimtex_compiler_method = "tectonic",
		tex_conceal = "abdmg",
		copilot_no_tab_map = "v:true",
	},
	o = {
		shell = (vim.fn.has("macunix")) == 1 and "/sbin/fish" or vim.o.shell,
	},
}
