return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    version = "v1.*",
    cmd = "LspInfo",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
        "force",
        lspconfig.util.default_config.capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )
      -- Disable snippets
      lspconfig.util.default_config.capabilities.textDocument.completion.completionItem.snippetSupport = false

      -- Executes the callback function every time a
      -- language server is attached to a buffer.
      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP actions",
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
          vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
          vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
          vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
          vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
          vim.keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
          vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
          vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
          vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
          vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

          -- Go to next/prev diagnostic warning/error
          vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
          vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            -- Enable inlay hints by default
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })

            vim.keymap.set("n", "<Leader>H", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle Inlay Hints" })
          end
        end,
      })

      if vim.fn.executable("clangd") == 1 then
        lspconfig.clangd.setup({
          cmd = {
            "clangd",
            "--suggest-missing-includes",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--clang-tidy",
          },
        })
      end

      if vim.fn.executable("lua-language-server") == 1 then
        lspconfig.lua_ls.setup({
          -- https://github.com/neovim/neovim/issues/21686#issuecomment-1522446128
          settings = {
            Lua = {
              runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
              },
              diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  "vim",
                  "require",
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
              },
              -- Do not send telemetry data containing a randomized but unique identifier
              telemetry = {
                enable = false,
              },
            },
          },
        })
      end

      if vim.fn.executable("rust-analyzer") == 1 then
        lspconfig.rust_analyzer.setup({})
      end

      if vim.fn.executable("pyright") == 1 then
        lspconfig.pyright.setup({})
      elseif vim.fn.executable("pylsp") == 1 then
        lspconfig.pylsp.setup({})
      end
    end,
  }
}
