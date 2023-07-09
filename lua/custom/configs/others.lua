local M = {}

M.noice = {
	lsp = {
		progress = {
			enabled = true,
		},
		signature = {
			enabled = false,
		},
	},
	presets = {
		bottom_search = false,
		-- command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "virtualtext",
	},
	health = {
		checker = false,
	},
}

M.signature = {
	floating_window = false,
}

M.saga = {}

M.flash = {
	highlight = {
		backdrop = false,
	},

	modes = {
		search = {
			enabled = false,
		},
		char = {
			highlight = { backdrop = false },
		},
	},
}

M.tabout = {
	tabkey = "<Tab>", -- key to trigger tabout, set to an empty string to disable
	backwards_tabkey = "<S-Tab>", -- key to trigger backwards tabout, set to an empty string to disable
	act_as_tab = true, -- shift content if tab out is not possible
	act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
	enable_backwards = true,
	completion = true, -- if the tabkey is used in a completion pum
	tabouts = {
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = "`", close = "`" },
		{ open = "(", close = ")" },
		{ open = "[", close = "]" },
		{ open = "{", close = "}" },
	},
	ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
	exclude = {
		"qf",
		"NvimTree",
		"toggleterm",
		"TelescopePrompt",
		"alpha",
		"netrw",
	}, -- tabout will ignore these filetypes
}

M.ufo = {
	-- Fold options
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = (" ↙ %d "):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0

		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				-- str width returned from truncate() may less than 2nd argument, need padding
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end

		-- Second line
		local lines = vim.api.nvim_buf_get_lines(0, lnum, lnum + 1, false)
		local secondLine = nil
		if #lines == 1 then
			secondLine = lines[1]
		elseif #lines > 1 then
			secondLine = lines[2]
		end
		if secondLine ~= nil then
			table.insert(newVirtText, { secondLine, "AdCustomFold" })
		end

		table.insert(newVirtText, { suffix, "MoreMsg" })

		return newVirtText
	end,
}
return M
