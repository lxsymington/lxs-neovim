local opt = vim.opt
local api = vim.api

api.nvim_create_user_command('NumberToggle', function ()
  opt.number = true
  
  local current_value = api.nvim_win_get_option(api.nvim_get_currentwin(), 'relativenumber')
  
  opt.relativenumber = not current_value
end, {})
