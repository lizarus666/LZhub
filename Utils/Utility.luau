--[[
    LZ HUB - UTILITY FUNCTIONS
]]

local Utility = {}

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- Variables (akan di-set saat initialize)
Utility.LocalPlayer = nil

function Utility:Initialize(config)
    self.LocalPlayer = config.LocalPlayer
    self.Mouse = config.Mouse
end

function Utility:GetCharacter()
    return self.LocalPlayer.Character
end

function Utility:GetHumanoid()
    local char = self:GetCharacter()
    return char and char:FindFirstChild("Humanoid")
end

function Utility:GetHumanoidRootPart()
    local char = self:GetCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

function Utility:IsAlive()
    local char = self:GetCharacter()
    local humanoid = self:GetHumanoid()
    return char and humanoid and humanoid.Health > 0
end

function Utility:GetRemote()
    return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
end

function Utility:InvokeServer(...)
    local remote = self:GetRemote()
    return remote:InvokeServer(...)
end

function Utility:TweenTeleport(position)
    local hrp = self:GetHumanoidRootPart()
    if hrp then
        local distance = (hrp.Position - position).Magnitude
        local tweenTime = math.min(distance / 250, 5)
        
        local tweenInfo = TweenInfo.new(
            tweenTime,
            Enum.EasingStyle.Linear
        )
        
        local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFrame.new(position)})
        tween:Play()
        return tween
    end
end

function Utility:Notify(title, text, duration)
    local notification = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local textLabel = Instance.new("TextLabel")
    
    notification.Name = "LZNotification"
    notification.Parent = CoreGui
    notification.IgnoreGuiInset = true
    
    frame.Size = UDim2.new(0, 300, 0, 100)
    frame.Position = UDim2.new(0.5, -150, 0, 20)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 0
    frame.Parent = notification
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    titleLabel.Size = UDim2.new(1, -20, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame
    
    textLabel.Size = UDim2.new(1, -20, 0, 50)
    textLabel.Position = UDim2.new(0, 10, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextWrapped = true
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = frame
    
    task.wait(duration or 3)
    notification:Destroy()
end

function Utility:GetClosestEnemy()
    local hrp = self:GetHumanoidRootPart()
    if not hrp then return nil end
    
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    
    local closest = nil
    local closestDistance = math.huge
    
    for _, enemy in pairs(enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
            local enemyHrp = enemy.HumanoidRootPart
            local distance = (hrp.Position - enemyHrp.Position).Magnitude
            
            if distance < closestDistance then
                closestDistance = distance
                closest = enemy
            end
        end
    end
    
    return closest
end

return Utility