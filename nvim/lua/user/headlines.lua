local headlines_ok, headlines = pcall(require, "headlines")
if not headlines_ok then
  print('headlines not avaible')
  return
end
headlines.setup()
