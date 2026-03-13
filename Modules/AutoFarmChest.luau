--[[
    LZ HUB - AUTO FARM CHEST MODULE
]]

local AutoFarmChest = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
}

function AutoFarmChest:Initialize(config)
    self.Utility = config.Utility
end

function AutoFarmChest:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Auto Farm Chest", "Auto Farm Chest diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Auto Farm Chest", "Auto Farm Chest dimatikan", 1)
    end
end

function AutoFarmChest:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:CollectChests()
    end)
end

function AutoFarmChest:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function AutoFarmChest:CollectChests()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    if not hrp then return end
    
    local chestModels = workspace:FindFirstChild("ChestModels")
    if not chestModels then return end
    
    for _, chest in pairs(chestModels:GetChildren()) do
        if chest:IsA("Model") and chest:FindFirstChild("Chest") then
            local chestPart = chest.Chest
            if chestPart then
                local distance = (hrp.Position - chestPart.Position).Magnitude
                
                if distance < 200 then
                    -- Teleport ke chest
                    self.Utility:TweenTeleport(chestPart.Position + Vector3.new(0, 10, 0))
                    task.wait(0.5)
                    
                    -- Collect
                    firetouchinterest(hrp, chestPart, 0)
                    task.wait(0.1)
                    firetouchinterest(hrp, chestPart, 1)
                    
                    task.wait(1)
                end
            end
        end
    end
end

return AutoFarmChest