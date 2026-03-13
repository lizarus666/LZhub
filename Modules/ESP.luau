--[[
    LZ HUB - ESP MODULE
]]

local ESP = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
    Players = {},
    Mobs = {},
    Fruits = {},
    Chests = {},
}

function ESP:Initialize(config)
    self.Utility = config.Utility
    self.LocalPlayer = config.LocalPlayer
end

function ESP:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("ESP", "ESP diaktifkan", 1)
    else
        self:Clear()
        self.Utility:Notify("ESP", "ESP dimatikan", 1)
    end
end

function ESP:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:Update()
    end)
end

function ESP:Clear()
    for _, v in pairs(self.Players) do
        if v then v:Destroy() end
    end
    for _, v in pairs(self.Mobs) do
        if v then v:Destroy() end
    end
    for _, v in pairs(self.Fruits) do
        if v then v:Destroy() end
    end
    for _, v in pairs(self.Chests) do
        if v then v:Destroy() end
    end
    
    self.Players = {}
    self.Mobs = {}
    self.Fruits = {}
    self.Chests = {}
end

function ESP:Update()
    if not self.Enabled then return end
    
    self:Clear()
    
    -- Player ESP
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= self.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local highlight = Instance.new("Highlight")
            highlight.Name = "LZ_ESP_Player"
            highlight.Adornee = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.Parent = player.Character
            table.insert(self.Players, highlight)
            
            local billboard = Instance.new("BillboardGui")
            local label = Instance.new("TextLabel")
            
            billboard.Name = "LZ_ESP_Label"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.Adornee = player.Character.HumanoidRootPart
            billboard.Parent = player.Character
            
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = player.Name .. "\n" .. math.floor(player.Character.Humanoid.Health) .. "/" .. player.Character.Humanoid.MaxHealth
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.TextScaled = true
            label.Font = Enum.Font.GothamBold
            label.Parent = billboard
        end
    end
    
    -- Mob ESP
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, mob in pairs(enemies:GetChildren()) do
            if mob:FindFirstChild("Humanoid") and mob:FindFirstChild("HumanoidRootPart") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "LZ_ESP_Mob"
                highlight.Adornee = mob
                highlight.FillColor = Color3.fromRGB(255, 255, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = mob
                table.insert(self.Mobs, highlight)
                
                local billboard = Instance.new("BillboardGui")
                local label = Instance.new("TextLabel")
                
                billboard.Name = "LZ_ESP_Label"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.Adornee = mob.HumanoidRootPart
                billboard.Parent = mob
                
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = mob.Name .. "\n" .. math.floor(mob.Humanoid.Health) .. "/" .. mob.Humanoid.MaxHealth
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard
            end
        end
    end
    
    -- Fruit ESP
    local fruits = workspace:FindFirstChild("Fruits") or workspace:FindFirstChild("Fruit")
    if fruits then
        for _, fruit in pairs(fruits:GetChildren()) do
            if fruit:IsA("Tool") or fruit:IsA("Part") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "LZ_ESP_Fruit"
                highlight.Adornee = fruit
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = fruit
                table.insert(self.Fruits, highlight)
                
                local billboard = Instance.new("BillboardGui")
                local label = Instance.new("TextLabel")
                
                billboard.Name = "LZ_ESP_Label"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.Adornee = fruit
                billboard.Parent = fruit
                
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = fruit.Name
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard
            end
        end
    end
    
    -- Chest ESP
    local chestModels = workspace:FindFirstChild("ChestModels")
    if chestModels then
        for _, chest in pairs(chestModels:GetChildren()) do
            if chest:IsA("Model") and chest:FindFirstChild("Chest") then
                local chestPart = chest.Chest
                local highlight = Instance.new("Highlight")
                highlight.Name = "LZ_ESP_Chest"
                highlight.Adornee = chest
                highlight.FillColor = Color3.fromRGB(255, 0, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.Parent = chest
                table.insert(self.Chests, highlight)
                
                local billboard = Instance.new("BillboardGui")
                local label = Instance.new("TextLabel")
                
                billboard.Name = "LZ_ESP_Label"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.Adornee = chestPart
                billboard.Parent = chest
                
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = "Chest"
                label.TextColor3 = Color3.fromRGB(255, 0, 255)
                label.TextScaled = true
                label.Font = Enum.Font.GothamBold
                label.Parent = billboard
            end
        end
    end
end

return ESP