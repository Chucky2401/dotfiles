return {
  {
    "christoomey/vim-tmux-navigator",
    -- event = "VeryLazy",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    config = function()
      dofile(vim.fn.expand("~/.config/herdr/plugins/github/vim-herdr-navigation-a8bf42123d81/editor/nvim.lua"))
    end,
    -- cmd = {
    --   "TmuxNavigateLeft",
    --   "TmuxNavigateDown",
    --   "TmuxNavigateUp",
    --   "TmuxNavigateRight",
    --   "TmuxNavigatePrevious",
    -- },
    -- keys = {
    --   { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    --   { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    --   { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    --   { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    --   { "<c-/>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    -- },
  },
}
