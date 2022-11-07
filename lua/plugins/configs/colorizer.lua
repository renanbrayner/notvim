local status_ok, colorizer = pcall(require, 'colorizer')
if not status_ok then
  vim.notify("Error requiring colorizer", error)
  return
end

colorizer.setup({
  filetypes = {
    "*",
  },
  user_default_options = {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    tailwind = true,
    mode = "virtualtext", -- Set the display mode.
    virtualtext = "■",
  },
})

-- execute colorizer as soon as possible
vim.defer_fn(function()
  require("colorizer").attach_to_buffer(0)
end, 0)
