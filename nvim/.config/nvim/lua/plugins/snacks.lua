-- lua/plugins/snacks.lua
---@module 'snacks'
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<c-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<c-l>"] = false,
          },
        },
        list = {
          keys = {
            ["<c-h>"] = false,
            ["<c-j>"] = false,
            ["<c-k>"] = false,
            ["<c-l>"] = false,
          },
        },
      },
      -- si l'explorer surcharge ces mêmes touches à son niveau, les
      -- redésactiver ici aussi (les configs par source priment sur le global)
      sources = {
        explorer = {
          win = {
            list = {
              keys = {
                ["<c-h>"] = false,
                ["<c-j>"] = false,
                ["<c-k>"] = false,
                ["<c-l>"] = false,
              },
            },
          },
        },
      },
    },
  },
}
