local others = require("custom.configs.others")

lvim.plugins = {
    -- 快捷jj
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    },

    --置灰未使用变量
    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup {
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
            }
        end,
    },

    --窗口预览goto
    {
        "rmagatti/goto-preview",
        dependencies = "neovim/nvim-lspconfig",
        config = function()
            require("goto-preview").setup {
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
            }
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
            require("nvim-lastplace").setup {
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
                lastplace_open_folds = true,
            }
        end,
    },

    --nvimapi补全
    { "folke/neodev.nvim" },

    -- 翻译
    {
        "voldikss/vim-translator",
        cmd = "TranslateW",
        keys = {
            { "<leader>Tw", "<cmd>TranslateW<cr>",                  desc = "window",   mode = { "n", "v" } },
            { "<leader>Te", "<cmd>Translate --target_lang=en <cr>", desc = "to en",    "v" },
            { "<leader>Tr", "<cmd>TranslateR<cr>",                  desc = "replace",  mode = { "n", "v" } },
            { "<leader>Tx", "<cmd>TranslateX<cr>",                  desc = "clipboard" },
            { "<leader>Th", "<cmd>TranslateH<cr>",                  desc = "history" },
            { "<leader>Tl", "<cmd>TranslateL<cr>",                  desc = "log" },
        },
    },

    -- 代码片段运行
    {
        "michaelb/sniprun",
        build = "bash ./install.sh",
        cmd = "SnipRun",
        keys = {
            { "<leader>rf", "<cmd>%SnipRun<cr>", "file" },
            { "<leader>rs", "<Plug>SnipRun",     "snip" },
            { "<leader>rc", "<Plug>SnipClose",   "close" },
            { "<leader>rr", "<Plug>SnipReset",   "reset" },
        }
    },
    -- 跳转
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").setup({
                highlight_unlabeled_phase_one_targets = true,
                require('leap').add_default_mappings()
            })
        end
    },
    -- f 增强
    {
        "ggandor/flit.nvim",
        event = "VeryLazy",
        keys = { "f", "F", "t", "T" },
        dependencies = { "ggandor/leap.nvim" },
        opts = others.flit,
    },
    -- 加("")
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "ian-ie/LeetCode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("leetcode").setup {}
        end,
        keys = {
            { "<leader>Lcg", "<cmd>LCLogin<cr>",  desc = "login" },
            { "<leader>Lcl", "<cmd>LCList<cr>",   desc = "list" },
            { "<leader>Lci", "<cmd>LCInfo<cr>",   desc = "info" },
            { "<leader>Lco", "<cmd>LCOpen<cr>",   desc = "open" },
            { "<leader>Lcd", "<cmd>LCToday<cr>",  desc = "day" },
            { "<leader>Lcr", "<cmd>LCReset<cr>",  desc = "reset" },
            { "<leader>Lcc", "<cmd>LCClose<cr>",  desc = "close" },
            { "<leader>Lct", "<cmd>LCTest<cr>",   desc = "test" },
            { "<leader>Lcs", "<cmd>LCSubmit<cr>", desc = "submit" },
        },
    },
    -- 跳出tab
    {
        "abecodes/tabout.nvim",
        event = "InsertEnter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "L3MON4D3/LuaSnip",
            "hrsh7th/nvim-cmp",
        },
        opts = others.tabout,

    },
    --符号信息
    {
        "simrat39/symbols-outline.nvim",
        event = "InsertEnter",
        dependencies = "neovim/nvim-lspconfig",
        opts = others.symbols_outline,
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
        opts = others.noice,
        keys = {
            { "<leader>ns", "<cmd>Notifications<cr>",   desc = "show notifications" },
            { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "show notice in telescope" },
            { "<leader>nm", "<cmd>messages<cr>",        desc = "show message" },
            { "<leader>nd", "<cmd>NoiceDisable<cr>",    desc = "NoiceDisable" },
            { "<leader>ne", "<cmd>NoiceEnable<cr>",     desc = "NoiceEnable" },
        },
    }
}
