local others = require("custom.configs.others")

lvim.plugins = {
	-- 快捷jj
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	--显示颜色
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufRead", "BufNew" },
		config = function()
			require("lsp_signature").setup(others.signature)
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup(others.saga)
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	--置灰未使用变量
	{
		"zbirenbaum/neodim",
		event = "LspAttach",
		config = function()
			require("neodim").setup({
				alpha = 0.75,
				blend_color = "#000000",
				update_in_insert = {
					enable = true,
					delay = 100,
				},
				hide = {
					virtual_text = true,
					signs = false,
					underline = false,
				},
			})
		end,
	},
	-- 移动缩进
	{
		"booperlv/nvim-gomove",
		event = "VeryLazy",
		config = function()
			require("gomove").setup({
				-- whether or not to map default key bindings, (true/false)
				map_defaults = true,
				-- whether or not to reindent lines moved vertically (true/false)
				reindent = true,
				-- whether or not to undojoin same direction moves (true/false)
				undojoin = true,
				-- whether to not to move past end column when moving blocks horizontally, (true/false)
				move_past_end_col = false,
			})
		end,
	},
	--窗口预览goto
	{
		"rmagatti/goto-preview",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("goto-preview").setup({
				default_mappings = true,
				post_open_hook = function(_, win)
					-- Close the current preview window with <Esc>
					vim.keymap.set("n", "<Esc>", function()
						vim.api.nvim_win_close(win, true)
					end, { buffer = true })
					vim.keymap.set("n", "q", function()
						vim.api.nvim_win_close(win, true)
					end, { buffer = true })
				end,
			})
		end,
	},

	{
		"numtostr/BufOnly.nvim",
		cmd = "BufOnly",
	},

	--恢复上次浏览
	{
		"ethanholz/nvim-lastplace",
		event = "VeryLazy",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},

	--nvimapi补全
	{ "folke/neodev.nvim" },

	-- 会话
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "folds" } },
	},
	-- 翻译
	{
		"voldikss/vim-translator",
		cmd = "TranslateW",
		keys = {
			{ "<leader>Tw", "<cmd>TranslateW<cr>", desc = "window", mode = { "n", "v" } },
			{ "<leader>Te", "<cmd>Translate --target_lang=en <cr>", desc = "to en", "v" },
			{ "<leader>Tr", "<cmd>TranslateR<cr>", desc = "replace", mode = { "n", "v" } },
			{ "<leader>Tx", "<cmd>TranslateX<cr>", desc = "clipboard" },
			{ "<leader>Th", "<cmd>TranslateH<cr>", desc = "history" },
			{ "<leader>Tl", "<cmd>TranslateL<cr>", desc = "log" },
		},
	},

	-- 代码片段运行
	{
		"michaelb/sniprun",
		build = "bash ./install.sh",
		cmd = "SnipRun",
		keys = {
			{ "<leader>rf", "<cmd>%SnipRun<cr>", desc = "file" },
			{ "<leader>rs", "<Plug>SnipRun", desc = "snip" },
			{ "<leader>rc", "<Plug>SnipClose", desc = "close" },
			{ "<leader>rr", "<Plug>SnipReset", desc = "reset" },
		},
	},
    -- 多光标
    {
        "mg979/vim-visual-multi",
        event = "VeryLazy",
        branch = "master",
        init = function ()
            vim.g.VM_maps = {

            }
        end
    },

	-- 跳转
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = others.flash,
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Flash Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- 加("")
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	--myleetcode
	{
		"ian-ie/LeetCode.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("leetcode").setup({})
		end,
		keys = {
			{ "<leader>Lcg", "<cmd>LCLogin<cr>", desc = "login" },
			{ "<leader>Lcl", "<cmd>LCList<cr>", desc = "list" },
			{ "<leader>Lci", "<cmd>LCInfo<cr>", desc = "info" },
			{ "<leader>Lco", "<cmd>LCOpen<cr>", desc = "open" },
			{ "<leader>Lcd", "<cmd>LCToday<cr>", desc = "day" },
			{ "<leader>Lcr", "<cmd>LCReset<cr>", desc = "reset" },
			{ "<leader>Lcc", "<cmd>LCClose<cr>", desc = "close" },
			{ "<leader>Lct", "<cmd>LCTest<cr>", desc = "test" },
			{ "<leader>Lcs", "<cmd>LCSubmit<cr>", desc = "submit" },
		},
	},
	{ "p00f/nvim-ts-rainbow" },
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				textsubjects = {
					enable = true,
					prev_selection = ",",
					keymaps = {
						["."] = "textsubjects-smart",
						[";"] = "textsubjects-container-outer",
						["i;"] = "textsubjects-container-inner",
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = { useDefaultKeymaps = true },
	},
	-- 跳出tab
	{
		"abecodes/tabout.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"hrsh7th/nvim-cmp",
		},
		opts = others.tabout,
	},

	--折叠
	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = {
			{ "kevinhwang91/promise-async" },
			{
				"luukvbaal/statuscol.nvim",
				config = function()
					local builtin = require("statuscol.builtin")
					require("statuscol").setup({
						-- foldfunc = "builtin",
						-- setopt = true,
						relculright = true,
						segments = {
							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
							{ text = { "%s" }, click = "v:lua.ScSa" },
							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
						},
					})
				end,
			},
		},

		config = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.api.nvim_command("highlight AdCustomFold guifg=#6699CC")
			require("ufo").setup(others.ufo)
		end,
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "open all folds",
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "colse all folds",
			},
			{
				"Z",
				function()
					local winid = require("ufo").peekFoldedLinesUnderCursor()
					if not winid then
						vim.lsp.buf.hover()
					end
				end,
				desc = "preview fold",
			},
			{
				"zr",
				function()
					require("ufo").openFoldsExceptKinds()
				end,
				desc = "open same level fold",
			},
			{
				"zm",
				function()
					require("ufo").closeFoldsWith()
				end,
				desc = "close same level fold",
			},
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						background_colour = "#000000",
					})
				end,
			},
			{ "MunifTanjim/nui.nvim" },
		},

		opts = others.noice,
		keys = {
			{ "<leader>ns", "<cmd>Notifications<cr>", desc = "show notifications" },
			{ "<leader>nt", "<cmd>Noice telescope<cr>", desc = "show notice in telescope" },
			{ "<leader>nm", "<cmd>messages<cr>", desc = "show message" },
			{ "<leader>nd", "<cmd>NoiceDisable<cr>", desc = "NoiceDisable" },
			{ "<leader>ne", "<cmd>NoiceEnable<cr>", desc = "NoiceEnable" },
		},
	},
}
