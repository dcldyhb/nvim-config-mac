return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    opts = function(_, opts)
      opts = opts or {}

      local ls = require("luasnip")
      local ftf = require("luasnip.extras.filetype_functions")

      -- 让 autosnippet 真正生效
      opts.enable_autosnippets = true

      -- markdown 打开时，也把 tex 片段一起 lazy-load 进来
      opts.load_ft_func = ftf.extend_load_ft({
        markdown = { "tex" },
      })

      -- 让 markdown buffer 也能查到 tex 片段
      ls.filetype_extend("markdown", { "tex" })

      -- 你的 json / lua 片段其实都在 ~/config/nvim/snippets
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      return opts
    end,
  },
}
