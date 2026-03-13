--[[
    LZ HUB - AUTO FARM LEVEL MODULE
]]

local AutoFarmLevel = {
    Enabled = false,
    Connection = nil,
    CurrentQuest = nil,
    Utility = nil,
    Settings = nil,
}

function AutoFarmLevel:Initialize(config)
    self.Utility = config.Utility
    self.Settings = config.Settings
    self.LocalPlayer = config.LocalPlayer
end

function AutoFarmLevel:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Auto Farm Level", "Auto Farm Level diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Auto Farm Level", "Auto Farm Level dimatikan", 1)
    end
end

function AutoFarmLevel:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").Heartbeat:Connect(function()
        self:Farm()
    end)
end

function AutoFarmLevel:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
    self.CurrentQuest = nil
end

function AutoFarmLevel:GetQuest()
    local level = self.LocalPlayer.Data.Level.Value
    
    for reqLevel, questData in pairs(self.Settings.Quests) do
        if level >= reqLevel then
            local enemyName = questData[1]
            local questName = questData[2]
            
            -- Ambil quest
            local success = pcall(function()
                self.Utility:InvokeServer("StartQuest", questName, 1)
            end)
            
            if success then
                self.CurrentQuest = {
                    Name = enemyName,
                    Quest = questName
                }
                task.wait(1)
            end
            break
        end
    end
end

function AutoFarmLevel:Farm()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    if not hrp then return end
    
    -- Auto ambil quest
    if not self.CurrentQuest then
        self:GetQuest()
        return
    end
    
    -- Cari musuh
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return end
    
    local target = nil
    local targetDistance = math.huge
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            -- Filter musuh sesuai quest
            if self.CurrentQuest then
                local questName = self.CurrentQuest.Name or ""
                if enemy.Name:find(questName) then
                    local distance = (hrp.Position - enemy.HumanoidRootPart.Position).Magnitude
                    if distance < targetDistance then
                        targetDistance = distance
                        target = enemy
                    end
                end
            end
        end
    end
    
    if target then
        self:AttackEnemy(target)
    end
end

function AutoFarmLevel:AttackEnemy(enemy)
    if not enemy then return end
    
    local hrp = self.Utility:GetHumanoidRootPart()
    local enemyHrp = enemy:FindFirstChild("HumanoidRootPart")
    
    if not hrp or not enemyHrp then return end
    
    -- Bring mob (tarik musuh)
    if self.Settings.AutoFarm.BringMobs then
        local distance = (hrp.Position - enemyHrp.Position).Magnitude
        if distance > self.Settings.AutoFarm.BringDistance then
            enemyHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 10)
        end
    end
    
    -- Attack
    local distance = (hrp.Position - enemyHrp.Position).Magnitude
    if distance < 50 then
        local args = {
            [1] = "Attack",
            [2] = enemy
        }
        
        pcall(function()
            self.Utility:InvokeServer(unpack(args))
        end)
    end
end

return AutoFarmLevel