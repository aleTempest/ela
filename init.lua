-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local theme = {
  dark = "solarized-osaka",
  light = "solarized-osaka-day",
}

local function setTheme(t)
  local colorscheme = t.dark

  if t.light ~= nil then
    local currTime = os.date("*t", os.time()).hour
    if currTime >= 9 and currTime < 18 then
      colorscheme = t.light
    end
  end
  vim.cmd("colorscheme " .. colorscheme)
end

setTheme(theme)
