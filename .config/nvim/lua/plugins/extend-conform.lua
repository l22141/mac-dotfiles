return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black" }
          end
        end,
        json = { "jq" },
      },
      formatters = {
        injected = {
          options = {
            ignore_errors = false,
            lang_to_ft = {
              json = "json",
            },
          },
        },
      },
    },
  },
}
