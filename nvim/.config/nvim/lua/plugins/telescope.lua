return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", LazyVim.pick("files", { hidden = true, no_ignore = false }), desc = "Find Files (Root Dir)" },
      {
        "<leader>fi",
        LazyVim.pick("files", { hidden = true, no_ignore = true }),
        desc = "Find Files with ignored (Root Dir)",
      },
      {
        "<leader>fF",
        LazyVim.pick("files", { root = false, hidden = true, no_ignore = false }),
        desc = "Find Files (cwd)",
      },
      {
        "<leader>fI",
        LazyVim.pick("files", { root = false, hidden = true, no_ignore = true }),
        desc = "Find Files with ignored (cwd)",
      },
    },
  },
}
