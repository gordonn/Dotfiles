return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  config = function()
    local bufferline = require("bufferline")
    bufferline.setup({
      options = {
        mode = "tabs",
        style_preset = {
          bufferline.style_preset.no_italic,
          bufferline.style_preset.no_bold,
          bufferline.style_preset.minimal,
        },
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            text_align = "left",
          },
        },
      },
    })
    vim.cmd([[
      autocmd ColorScheme * highlight BufferLineFill guibg=#181825
    ]])
  end,
}
