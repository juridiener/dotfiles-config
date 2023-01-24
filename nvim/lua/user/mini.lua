local ai_ok, ai = pcall(require, "mini.ai")
if not ai_ok then
  print('mini ai not avaible')
  return
end

ai.setup()

local surround_ok, surround = pcall(require, "mini.surround")
if not surround_ok then
  print('mini surround not avaible')
  return
end

surround.setup()

--[[ local animate_ok, animate = pcall(require, "mini.animate") ]]
--[[ if not animate_ok then ]]
--[[   print('mini animate not avaible') ]]
--[[   return ]]
--[[ end ]]
--[[ animate.setup() ]]
