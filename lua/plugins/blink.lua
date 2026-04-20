return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "erooke/blink-cmp-latex",
    },
    opts = function(_, opts)
      opts.snippets = { preset = "luasnip" }

      opts.sources = {
        default = { "lsp", "path", "snippets" },
        per_filetype = {
          tex = { inherit_defaults = true, "omni", "latex" },
          plaintex = { inherit_defaults = true, "omni", "latex" },
          markdown = { inherit_defaults = true, "latex" },
        },
        providers = {
          buffer = { enabled = false },
          latex = {
            name = "Latex",
            module = "blink-cmp-latex",
            min_keyword_length = 2,
            opts = {
              -- 你要的是 \phi，不是 φ
              insert_command = true,
            },
          },
        },
      }

      opts.keymap = {
        preset = "none",
        ["<Tab>"] = { "snippet_forward", "accept", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<ESC>"] = { "hide", "fallback" },
      }

      opts.completion = {
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
        menu = { draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true },
      }

      opts.signature = { enabled = true }

      return opts
    end,
  },
}
