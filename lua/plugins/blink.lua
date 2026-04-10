return {
  "saghen/blink.cmp",
  -- 使用 function 形式强制覆盖 LazyVim 的默认设置
  opts = function(_, opts)
    -- 1. 强制重定义 sources 结构，彻底抹除 buffer
    opts.sources = {
      -- 只保留你想要的源
      default = { "lsp", "path", "snippets" },
      -- 显式禁用 buffer 模块
      providers = {
        buffer = { enabled = false },
      },
    }

    -- 2. 核心按键映射
    opts.keymap = {
      preset = "none",
      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<CR>"] = { "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
    }

    -- 3. 补全行为定制 (注意这里是 = 而不是 :)
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

    -- 4. 开启签名帮助
    opts.signature = { enabled = true }

    return opts
  end,
}
