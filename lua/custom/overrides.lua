-- lvim.builtin.lualine.style = "default"

lvim.lsp.on_attach_callback = function(client, bufnr)
	require("lsp_signature").on_attach()
end

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
		enable = true,
		hlgroups = {
			"DevIconCss",
			"DevIconPyo",
			"DevIconTxt",
			"DevIconFsi",
			"DevIconMl",
			"DevIconSln",
			"DevIconPpt",
		},
	},
}
