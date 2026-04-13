return {
  -- 配置 LuaSnip 插件
  {
    "L3MON4D3/LuaSnip",
    -- 必须覆盖掉 LazyVim 默认的按键设置，否则可能冲突
    keys = function()
      return {}
    end,
    opts = function()
      -- 加载我们自定义的 VSCode 风格代码块
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/lua/snippets" },
      })
    end,
  },
}
