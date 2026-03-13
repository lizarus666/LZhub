--[[
    LZ HUB - FRUIT SNIPER MODULE
]]

local FruitSniper = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
}

function FruitSniper:Initialize(config)
    self.Utility = config.Utility
end

function FruitSniper:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Fruit Sniper", "Fruit Sniper diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Fruit Sniper", "Fruit Sniper dimatikan", 1)
    end
end

function FruitSniper:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:FindFruits()
    end)
end

function FruitSniper:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function FruitSniper:FindFruits()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    if not hrp then return end
    
    local fruits = workspace:FindFirstChild("Fruits") or workspace:FindFirstChild("Fruit")
    if not fruits then return end
    
    for _, fruit in pairs(fruits:GetChildren()) do
        if fruit:IsA("Tool") or fruit:IsA("Part") then
            local fruitPos = fruit:IsA("Tool") and fruit.Handle.Position or fruit.Position
            local distance = (hrp.Position - fruitPos).Magnitude
            
            if distance < 200 then
                -- Teleport ke fruit
                self.Utility:TweenTeleport(fruitPos + Vector3.new(0, 10, 0))
                task.wait(0.5)
                
                -- Collect
                if fruit:IsA("Tool") and fruit.Handle then
                    firetouchinterest(hrp, fruit.Handle, 0)
                    task.wait(0.1)
                    firetouchinterest(hrp, fruit.Handle, 1)
                else
                    firetouchinterest(hrp, fruit, 0)
                    task.wait(0.1)
                    firetouchinterest(hrp, fruit, 1)
                end
                
                task.wait(1)
            end
        end
    end
end

return FruitSniper