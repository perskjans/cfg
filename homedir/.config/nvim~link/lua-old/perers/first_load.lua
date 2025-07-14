local download_packer = function()
  if vim.fn.input("Download Packer? (y for yes): ") ~= "y" then
    return
  end

  vim.fn.mkdir(PERERS_PLUGIN_DIRECTORY, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    PERERS_PLUGIN_DIRECTORY .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")
  print("( You'll need to restart now )")
end

return function()
  if not pcall(require, 'packer') then
    download_packer()

    return true
  end

  return false
end


