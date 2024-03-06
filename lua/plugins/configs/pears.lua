local status_ok, pears = pcall(require, 'pears')
if not status_ok then
  vim.notify('Error requiring pears', error)
  return
end

pears.setup(function(conf)
  conf.on_enter(function(pears_handle)
    if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
      vim.cmd[[:startinsert | call feedkeys("\<c-y>")]]
    else
      pears_handle()
    end
  end)
end)
