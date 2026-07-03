-- ~/.config/nvim/lua/plugins/quicker.lua

return {
  "stevearc/quicker.nvim",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    -- Options locales appliquées à la fenêtre quickfix
    opts = {
      buflisted = false,
      number = false,
      relativenumber = false,
      signcolumn = "auto",
      winfixheight = true,
      wrap = false,
    },

    -- Edition du quickfix comme un buffer normal (super pour refactor multi-fichiers)
    edit = {
      enabled = true,
      autosave = "unmodified", -- sauvegarde auto les buffers non modifiés après apply
    },

    -- Highlighting : treesitter + LSP, sans charger tous les buffers (trop lent)
    highlight = {
      treesitter = true,
      lsp = true,
      load_buffers = false,
    },

    -- Scroll automatique vers l'item le plus proche du curseur (désactivé par défaut)
    follow = {
      enabled = false,
    },

    -- Icônes pour les types de diagnostic (nécessite une Nerd Font)
    type_icons = {
      E = "󰅚 ",
      W = "󰀪 ",
      I = " ",
      N = " ",
      H = " ",
    },

    -- Keymaps actifs dans le buffer quickfix
    keys = {
      {
        ">",
        function()
          require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = "Expand quickfix context",
      },
      {
        "<",
        function()
          require("quicker").collapse()
        end,
        desc = "Collapse quickfix context",
      },
    },

    -- Contraindre le curseur à rester dans la colonne de texte
    constrain_cursor = true,
    trim_leading_whitespace = "common",
  },

  -- Keymaps globaux (hors buffer qf)
  keys = {
    {
      "<leader>xa",
      function()
        require("quicker").toggle({ focus = true })
      end,
      desc = "Toggle quickfix",
    },
    {
      "<leader>xA",
      function()
        require("quicker").toggle({ loclist = true, focus = true })
      end,
      desc = "Toggle loclist",
    },
  },
}
