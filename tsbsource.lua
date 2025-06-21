local a = game:GetService("MarketplaceService")
local b = require(game.ReplicatedStorage.Info)
local c = '{"items":['
local d = {}

for e, f in pairs(b.Limited) do
    d[f.Name] = f.ID
end

local g = 1
local h, i = pcall(function()
    return a:GetDeveloperProductsAsync():GetCurrentPage()
end)

if h then
    for e, j in ipairs(i) do
        if d[j.Name] then
            c = c .. string.format(
                '{"Number":%d,"Image":%d,"Name":"%s","Price":%d,"ID":%d},',
                g,
                j.IconImageAssetId or 0,
                j.Name,
                j.PriceInRobux or 0,
                j.ProductId
            )
            g = g + 1
        end
    end
    if c:sub(-1) == "," then
        c = c:sub(1, -2)
    end
    c = c .. '],"info":{"secondsInWeek":604800,"startOfYear":1735732800,"currentWeek":23}}'
end

workspace:SetAttribute("Limited", c)

local k = game.Players.LocalPlayer

local l = k.PlayerGui.Emotes.ImageLabel.Limited.List

local layout = l:FindFirstChildOfClass("UIListLayout")
if not layout then
    layout = Instance.new("UIListLayout")
    layout.Parent = l
end

layout.FillDirection = Enum.FillDirection.Horizontal 
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center -
layout.VerticalAlignment = Enum.VerticalAlignment.Center 
layout.Padding = UDim.new(0, 10) 


local padding = l:FindFirstChildOfClass("UIPadding")
if not padding then
    padding = Instance.new("UIPadding")
    padding.Parent = l
end

padding.PaddingLeft = UDim.new(0, 20) 
padding.PaddingTop = UDim.new(0, -720) 


for e, m in ipairs(l:GetChildren()) do
    if m:IsA("ImageButton") then
        m.MouseButton1Click:Connect(function()
            local n = m:GetAttribute("ID")
            if n then
                local o = {
                    {
                        Goal="Gift Gamepass",
                        GiftData={
                            Receiver=game.Players.LocalPlayer.UserId,
                            Gamepass=n
                        }
                    }
                }
                k.Character:WaitForChild("Communicate"):FireServer(unpack(o))
            end
        end)
    end
end
