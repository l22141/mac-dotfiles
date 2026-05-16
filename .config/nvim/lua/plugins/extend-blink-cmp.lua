return {
  "saghen/blink.cmp",
  opts = {
    -- signature = { enabled = true },
    sources = {
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
        snippets = {
          override = {
            get_trigger_characters = function(_)
              return { "#" }
            end,
          },
          opts = {
            extended_filetypes = {
              python = { "pydoc" },
            },
          },
        },
      },
    },
  },
}
