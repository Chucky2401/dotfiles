return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = 18080
    end,
  },
}
