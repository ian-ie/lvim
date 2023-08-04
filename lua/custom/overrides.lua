lvim.transparent_window = true
-- lvim.colorscheme = "onedark"

lvim.lsp.on_attach_callback = function()
	require("lsp_signature").on_attach()
end

lvim.builtin.indentlines.options.show_current_context = false
lvim.builtin.project.patterns= {".git", ".svn", ".luarc.json", "package.json"}

lvim.builtin.alpha.dashboard.section.buttons.entries[5] =
	{ "s", lvim.icons.ui.Fire .. "  Recent Seesion", "<cmd>lua require('persistence').load({ last = true })<cr>" }

lvim.builtin.treesitter = {
	match = { enable = true },
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["id"] = "@conditional.inner",
				["ad"] = "@conditional.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]["] = "@function.outer",
				["]m"] = "@class.outer",
				["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
			},
			goto_next_end = {
				["]]"] = "@function.outer",
				["]M"] = "@class.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
				["[m"] = "@class.outer",
			},
			goto_previous_end = {
				["[]"] = "@function.outer",
				["[M"] = "@class.outer",
			},
			goto_next = {
				["]d"] = "@conditional.outer",
			},
			goto_previous = {
				["[d"] = "@conditional.outer",
			},
		},
	},
	rainbow = {
		enable = false,
	},
}

lvim.builtin.which_key.setup.plugins = {
	marks = true, -- shows a list of your marks on ' and `
	registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
	-- the presets plugin, adds help for a bunch of default keybindings in Neovim
	-- No actual key bindings are created
	spelling = {
		enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
		suggestions = 20, -- how many suggestions should be shown in the list?
	},
	presets = {
		operators = true, -- adds help for operators like d, y, ...
		motions = true, -- adds help for motions
		text_objects = true, -- help for text objects triggered after entering an operator
		windows = true, -- default bindings on <c-w>
		nav = true, -- misc bindings to work with windows
		z = true, -- bindings for folds, spelling and others prefixed with z
		g = true, -- bindings for prefixed with g
	},
}
