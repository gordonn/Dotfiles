return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" }, -- Load this plugin when opening or creating a new file
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Plugin for LSP autocompletion
  },
  config = function()
    local lspconfig = require("lspconfig")

    local mason_lspconfig = require("mason-lspconfig")

    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    -- Create an autocmd (automatic command) that triggers when an LSP attaches to a buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      -- Create a new autocmd group named "UserLspConfig" to organize our LSP-related commands
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),

      -- Define the callback function that will run when the autocmd is triggered
      callback = function(ev)
        -- Options for key mappings, including the buffer the LSP is attached to and silencing command output
        local opts = { buffer = ev.buf, silent = true }

        -- Keybinding to show references of the symbol under the cursor using Telescope
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        -- Keybinding to jump to the declaration of the symbol under the cursor
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        -- Keybinding to show definitions of the symbol under the cursor using Telescope
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        -- Keybinding to show implementations of the symbol under the cursor using Telescope
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        -- Keybinding to show type definitions of the symbol under the cursor using Telescope
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        -- Keybinding to see available code actions, in visual mode it applies to the selection
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        -- Keybinding to rename the symbol under the cursor
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        -- Keybinding to show diagnostics for the current buffer using Telescope
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        -- Keybinding to show diagnostics for the current line
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        -- Keybinding to jump to the previous diagnostic in the buffer
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        -- Keybinding to jump to the next diagnostic in the buffer
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        -- Keybinding to show documentation for the symbol under the cursor
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Keybinding to restart the LSP server
        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    -- Enable autocompletion capabilities for every LSP server
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change diagnostic symbols in the sign column (gutter) to custom icons
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type -- Create highlight group names
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" }) -- Define the sign
    end

    -- Setup handlers for LSP servers, including specific configurations for some servers
    mason_lspconfig.setup_handlers({
      -- Default handler for all installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,

      -- Specific configuration for the Emmet server
      ["emmet_ls"] = function()
        lspconfig["emmet_ls"].setup({
          capabilities = capabilities,
          filetypes = { "html", "typescriptreact", "javascriptreact", "css" }, -- Supported file types
        })
      end,

      -- Specific configuration for the Lua server with special settings
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Recognize 'vim' as a global variable
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
