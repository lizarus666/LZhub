--[[
    LZ HUB - AUTO FARM BOSS MODULE
]]

local AutoFarmBoss = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
    Settings = nil,
    CurrentBoss = nil,
}

function AutoFarmBoss:Initialize(config)
    self.Utility = config.Utility
    self.Settings = config.Settings
    self.LocalPlayer = config.LocalPlayer
end

function AutoFarmBoss:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Auto Farm Boss", "Auto Farm Boss diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Auto Farm Boss", "Auto Farm Boss dimatikan", 1)
    end
end

function AutoFarmBoss:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:FarmBoss()
    end)
end

function AutoFarmBoss:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function AutoFarmBoss:FarmBoss()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    if not hrp then return end
    
    local level = self.LocalPlayer.Data.Level.Value
    
    for i = 1, #self.Settings.Bosses do
        local bossName = self.Settings.Bosses[i][1]
        local bossPos = self.Settings.Bosses[i][2]
        
        -- Cek apakah level cukup
        local levelReq = 20 + (i * 20)
        if level >= levelReq then
            -- Teleport ke boss
            self.Utility:TweenTeleport(bossPos + Vector3.new(0, 50, 0))
            task.wait(3)
            
            -- Cari boss di Enemies
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then
                for _, enemy in pairs(enemies:GetChildren()) do
                    if enemy.Name == bossName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        -- Attack boss
                        while self.Enabled and enemy and enemy.Parent and enemy.Humanoid.Health > 0 do
                            task.wait(0.1)
                            
                            local enemyHrp = enemy:FindFirstChild("HumanoidRootPart")
                            if enemyHrp then
                                hrp.CFrame = enemyHrp.CFrame * CFrame.new(0, 0, 15)
                                
                                local args = {
                                    [1] = "Attack",
                                    [2] = enemy
                                }
                                pcall(function()
                                    self.Utility:InvokeServer(unpack(args))
                                end)
                            end
                        end
                    end
                end
            end
            
            break
        end
    end
end

return AutoFarmBoss