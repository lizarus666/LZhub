--[[
    LZ HUB - ANTI AFK MODULE
]]

local AntiAFK = {
    Enabled = false,
    Connection = nil,
    Utility = nil,
}

function AntiAFK:Initialize(config)
    self.Utility = config.Utility
    self.LocalPlayer = config.LocalPlayer
    self.VirtualUser = game:GetService("VirtualUser")
end

function AntiAFK:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Start()
        self.Utility:Notify("Anti AFK", "Anti AFK diaktifkan", 1)
    else
        self:Stop()
        self.Utility:Notify("Anti AFK", "Anti AFK dimatikan", 1)
    end
end

function AntiAFK:Start()
    if self.Connection then
        self.Connection:Disconnect()
    end
    
    self.Connection = self.LocalPlayer.Idled:Connect(function()
        if self.Enabled then
            self.VirtualUser:CaptureController()
            self.VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end

function AntiAFK:Stop()
    if self.Connection then
        self.Connection:Disconnect()
        self.Connection = nil
    end
end

return AntiAFK