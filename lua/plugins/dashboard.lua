local logo = require("ascii").art.text.neovim.default1
-- padding string
for i = 10, 1, -1 do
  if i < 9 then
    table.insert(logo, 1, [[]])
  elseif true then
    table.insert(logo, [[]])
  end
end
return {
  {
    "nvimdev/dashboard-nvim",
    opts = { config = { header = logo } }
  },
}
