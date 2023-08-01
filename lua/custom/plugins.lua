local others = require("custom.configs.others")

lvim.plugins = {
	{ "spin6lock/vim_sproto", ft = "sproto" },
	{ "chrisbra/csv.vim", ft = "csv" },
	-- 快捷jj
	{
		"max397574/better-escape.nvim",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
							},
						},
					},
				},
			})
		end,
	},
	{ "metakirby5/codi.vim", cmd = { "Codi", "CodiNew" } },

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

	--quickfix增强
	{
		"kevinhwang91/nvim-bqf",
		ft = "qf",
		config = function()
			require("bqf").setup()
		end,
	},
	{ "romainl/vim-cool" },
	-- 搜索替换
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
		keys = {
			{ "<leader>so", "<cmd>lua require('spectre').open()<CR>", desc = "Open Spectre" },
			{
				"<leader>sw",
				"<Esc><cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				desc = "Search Current Word",
			},
			{
				"<leader>sp",
				"<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
				desc = "Search On Current File",
			},
			{
				"<leader>sw",
				"<cmd>lua require('spectre').open_visual()<CR>",
				desc = "Search Current Word",
				mode = "v",
			},
		},
	},
	-- 参数提示
	{
		"ray-x/lsp_signature.nvim",
		event = { "BufRead", "BufNew" },
		config = function()
			require("lsp_signature").setup(others.signature)
		end,
	},
	-- 符号信息
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		config = function()
			require("symbols-outline").setup(others.outline)
		end,
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
	-- 行跳转
	{
		"nacro90/numb.nvim",
		config = function()
			require("numb").setup()
		end,
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
			{ "<leader>r", "<Plug>SnipRun", desc = "run", mode = "v" },
		},
	},
	-- 多光标
	{
		"mg979/vim-visual-multi",
		event = "VeryLazy",
		branch = "master",
		enable = false,
		init = function()
			vim.g.VM_maps = {
				["Find Under"] = "<C-d>",
				-- ["Find Subword Under"] = "<C-u>",
				["Select All"] = "<C-a>",
				-- ["Select h"] = "<C-h>",
				-- ["Select l"] = "<C-l>",
				["Add Cursor Up"] = "<C-q>",
				["Add Cursor Down"] = "<C-e>",
				["Add Cursor At Pos"] = "<C-x>",
				-- ["Add Cursor At Word"] = "<C-w>",
				["Remove Region"] = "q",
			}
		end,
	},

	-- 快速移动
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
	{ "HiPhish/nvim-ts-rainbow2" },
	-- %增强
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
	-- 智能v
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
	-- ts对象增强
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
	-- v增强
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
	-- 平滑滚动
	{
		"karb94/neoscroll.nvim",
		event = "BufRead",
		config = function()
			require("neoscroll").setup(others.scroll)
		end,
	},
	-- 更好的ui
	{
		"stevearc/dressing.nvim",
		lazy = true,
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	-- 缩进线
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			symbol = "▏",
			-- symbol = "│",
			options = { try_as_border = false },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy", "mason" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
				no_italic = true,
			})
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		name = "onedarkpro",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				plugins = {
					nvim_tree = false,
				},
				options = {
					cursorline = true, -- Use cursorline highlighting?
					transparency = true, -- Use a transparent background?
				},
			})
		end,
	},
}
