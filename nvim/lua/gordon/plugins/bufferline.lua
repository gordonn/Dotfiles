return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      vim.cmd([[
        autocmd ColorScheme * highlight BufferLineFill guibg=#181825
      ]]),
    },
  },
}
