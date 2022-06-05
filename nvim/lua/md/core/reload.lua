function _G.ReloadConfig()
  for name,_ in pairs(package.loaded) do
    vim.notify(name, vim.log.levels.INFO)
    if name:match('^md') and not name:match('nvim-tree') then
      package.loaded[name] = nil
    end
  end

  dofile(vim.env.MYVIMRC)
  vim.notify("Nvim configuration reloaded!", vim.log.levels.INFO)
end
