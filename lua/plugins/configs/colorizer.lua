local loader = require('utils.loader')

local colorizer_config = {
  filetypes = {
    '*',
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
    mode = 'virtualtext', -- Set the display mode.
    virtualtext = '■',
  },
}

if loader.safe_setup('colorizer', colorizer_config) then
  local colorizer = loader.safe_require('colorizer', true) -- silent
  if colorizer then
    vim.defer_fn(function()
      colorizer.attach_to_buffer(0)
    end, 0)
  end
end
