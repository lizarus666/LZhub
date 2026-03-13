--[[
    LZ HUB - AUTO RAID MODULE
]]

local AutoRaid = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
}

function AutoRaid:Initialize(config)
    self.Utility = config.Utility
end

function AutoRaid:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Auto Raid", "Auto Raid diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Auto Raid", "Auto Raid dimatikan", 1)
    end
end

function AutoRaid:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:DoRaid()
    end)
end

function AutoRaid:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function AutoRaid:DoRaid()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    if not hrp then return end
    
    -- Cek apakah sudah di island raid
    local raidIsland = nil
    for i = 1, 5 do
        local island = workspace._WorldOrigin:FindFirstChild("Island " .. i)
        if island and (hrp.Position - island.Position).Magnitude < 1000 then
            raidIsland = island
            break
        end
    end
    
    if not raidIsland then
        -- Join raid
        pcall(function()
            self.Utility:InvokeServer("Raids", "Start")
        end)
        task.wait(3)
    else
        -- Farm di dalam raid
        local enemies = workspace:FindFirstChild("Enemies")
        if enemies then
            for _, enemy in pairs(enemies:GetChildren()) do
                if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                    local enemyHrp = enemy:FindFirstChild("HumanoidRootPart")
                    if enemyHrp then
                        hrp.CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 10)
                        
                        local args = {
                            [1] = "Attack",
                            [2] = enemy
                        }
                        pcall(function()
                            self.Utility:InvokeServer(unpack(args))
                        end)
                        
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end

return AutoRaid