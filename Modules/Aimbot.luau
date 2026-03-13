--[[
    LZ HUB - AIMBOT MODULE
]]

local Aimbot = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
    Settings = nil,
}

function Aimbot:Initialize(config)
    self.Utility = config.Utility
    self.Settings = config.Settings
end

function Aimbot:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Aimbot", "Aimbot diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Aimbot", "Aimbot dimatikan", 1)
    end
end

function Aimbot:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = game:GetService("RunService").RenderStepped:Connect(function()
        self:Update()
    end)
end

function Aimbot:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

function Aimbot:Update()
    if not self.Enabled then return end
    if not self.Utility:IsAlive() then return end
    
    local target = self.Utility:GetClosestEnemy()
    if not target then return end
    
    local targetHrp = target:FindFirstChild("HumanoidRootPart")
    if not targetHrp then return end
    
    local camera = workspace.CurrentCamera
    local targetPos = targetHrp.Position
    
    -- Smooth aim
    local currentCF = camera.CFrame
    local targetCF = CFrame.new(currentCF.Position, targetPos)
    camera.CFrame = currentCF:Lerp(targetCF, self.Settings.Combat.Smoothness)
end

return Aimbot