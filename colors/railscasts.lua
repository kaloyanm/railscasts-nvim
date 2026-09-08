if vim.g.colors_name then
  vim.cmd("highlight clear")
end

vim.g.colors_name = "railscasts"
vim.o.background = "dark"

require("railscasts").load(vim.g.railscasts or {})
