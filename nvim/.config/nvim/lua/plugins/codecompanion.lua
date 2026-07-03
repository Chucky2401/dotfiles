-- return {
--   "olimorris/codecompanion.nvim",
--   version = "^19.0.0",
--   opts = {},
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-treesitter/nvim-treesitter",
--   },
-- }

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "Actions", mode = { "n", "v" } },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", desc = "Inline", mode = { "n", "v" } },
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          ollama_coder = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "ollama_coder",
              env = { url = "http://10.167.250.14:11434" },
              schema = {
                model = { default = "qwen3-coder-next" },
                temperature = { default = 0.0 },
              },
            })
          end,

          ollama_chat = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "ollama_chat",
              env = { url = "http://10.167.250.14:11434" },
              schema = {
                model = { default = "qwen3-coder-next" },
                temperature = { default = 0.2 },
              },
            })
          end,
        },
      },

      strategies = {
        chat = { adapter = "ollama_chat" },
        inline = { adapter = "ollama_coder" },
        agent = { adapter = "ollama_coder" },
      },
    })
  end,
}
