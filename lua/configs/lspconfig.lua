require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "gopls", "ts_ls", "tailwindcss", "clangd", "cmake" }
vim.lsp.enable(servers)

local lspconfig = require "lspconfig"
local nvlsp = vim.lsp
local util = require "lspconfig.util"

local ooo = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Code action
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

  -- Rename
  vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)

  -- Go to definition
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  -- Hover documentation
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

  -- Add more keybindings as needed
end

local caps = require("blink.cmp").get_lsp_capabilities()

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = ooo,
    on_init = nvlsp.on_init,
    capabilities = caps,
  }
end

lspconfig.gopls.setup {
  on_attach = ooo,
  capabilities = caps,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
      buildFlags = { "-tags=wireinject" },
    },
  },
}

lspconfig.html.setup {
  on_attach = ooo,
  capabilities = caps,
  filetypes = { "html", "vue" },
}

lspconfig.tailwindcss.setup {
  filetypes = { "html", "javascriptreact", "typescriptreact", "vue" },
}

-- lspconfig.emmet_ls.setup {
--   on_attach = ooo,
--   capabilities = caps,
--   filetypes = { "javascriptreact", "typescriptreact", "vue" },
-- }

local vue_language_server = "/usr/lib/node_modules/@vue/language-server"
local vue_tsplugin = vue_language_server .. "/node_modules/@vue/typescript-plugin"

-- lspconfig.ts_ls.setup {
--   on_attach = ooo,
--   capabilities = caps,
--   init_options = {
--     plugins = { -- I think this was my breakthrough that made it work
--       {
--         name = "@vue/typescript-plugin",
--         location = vue_tsplugin,
--         languages = { "vue" },
--       },
--     },
--   },
--   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
-- }

lspconfig.ts_ls.setup {
  on_attach = ooo,
  capabilities = caps,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = vue_tsplugin,
        languages = { "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
  cmd = { "typescript-language-server", "--stdio" },
}

--
-- lspconfig.volar.setup {
--   on_attach = ooo,
--   capabilities = caps,
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--   },
--   filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" },
-- }
-- -- read :h vim.lsp.config for changing options of lsp servers
