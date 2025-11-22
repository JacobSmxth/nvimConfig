-- Appearance configuration: Theme settings

local M = {}

-- Available themes
M.themes = {
  "gruvbox-material",  -- Default
  "gruvbox",
  "catppuccin",
  "nightfox",
  "kanagawa",
  "tokyonight",
}

-- Selected theme (default)
M.selected_theme = "gruvbox-material"

-- Apply the selected theme
function M.apply_theme()
  local theme = M.selected_theme

  -- Set colorscheme based on selected theme
  if theme == "gruvbox-material" then
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_better_performance = 1
    vim.cmd.colorscheme("gruvbox-material")
  elseif theme == "gruvbox" then
    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  elseif theme == "catppuccin" then
    vim.cmd.colorscheme("catppuccin-mocha")
  elseif theme == "nightfox" then
    vim.cmd.colorscheme("nightfox")
  elseif theme == "kanagawa" then
    vim.cmd.colorscheme("kanagawa-wave")
  elseif theme == "tokyonight" then
    vim.cmd.colorscheme("tokyonight-night")
  end
end

-- Initialize appearance
function M.setup()
  M.apply_theme()

  -- Create user command for switching themes
  vim.api.nvim_create_user_command("Theme", function(opts)
    local theme = opts.args
    if theme == "" then
      print("Available themes: " .. table.concat(M.themes, ", "))
      print("Current theme: " .. M.selected_theme)
      return
    end

    local found = false
    for _, t in ipairs(M.themes) do
      if t == theme then
        found = true
        break
      end
    end

    if found then
      M.selected_theme = theme
      M.apply_theme()
      print("Theme changed to: " .. theme)
    else
      print("Invalid theme. Available themes: " .. table.concat(M.themes, ", "))
    end
  end, {
    nargs = "?",
    complete = function()
      return M.themes
    end,
    desc = "Change or display the current theme",
  })
end

return M
