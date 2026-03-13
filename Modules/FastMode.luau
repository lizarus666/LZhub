--[[
    LZ HUB - FAST MODE (FPS BOOST)
]]

local FastMode = {
    Enabled = false,
    Utility = nil,
    OriginalSettings = {},
}

function FastMode:Initialize(config)
    self.Utility = config.Utility
end

function FastMode:Toggle()
    self.Enabled = not self.Enabled
    
    if self.Enabled then
        self:Enable()
        self.Utility:Notify("Fast Mode", "Fast Mode diaktifkan (FPS Boost)", 1)
    else
        self:Disable()
        self.Utility:Notify("Fast Mode", "Fast Mode dimatikan", 1)
    end
end

function FastMode:Enable()
    -- Simpan pengaturan asli
    self.OriginalSettings = {
        QualityLevel = settings().Rendering.QualityLevel,
        MaterialQuality = settings().Rendering.MaterialQuality,
        MasterTextureQuality = settings().Rendering.MasterTextureQuality,
    }
    
    -- Set ke low quality
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    settings().Rendering.MaterialQuality = Enum.MaterialQuality.Low
    settings().Rendering.MasterTextureQuality = Enum.MasterTextureQuality.Lowest
    
    -- Matikan efek visual
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    lighting.Brightness = 2
    
    workspace.DescendantAdded:Connect(function(child)
        if child:IsA("BasePart") then
            child.Material = Enum.Material.SmoothPlastic
            child.Reflectance = 0
        end
    end)
    
    for _, child in pairs(workspace:GetDescendants()) do
        if child:IsA("BasePart") then
            child.Material = Enum.Material.SmoothPlastic
            child.Reflectance = 0
        elseif child:IsA("Decal") or child:IsA("Texture") then
            child.Transparency = 1
        end
    end
end

function FastMode:Disable()
    -- Kembalikan ke pengaturan asli
    settings().Rendering.QualityLevel = self.OriginalSettings.QualityLevel or Enum.QualityLevel.Level09
    settings().Rendering.MaterialQuality = self.OriginalSettings.MaterialQuality or Enum.MaterialQuality.High
    settings().Rendering.MasterTextureQuality = self.OriginalSettings.MasterTextureQuality or Enum.MasterTextureQuality.High
    
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = true
    lighting.FogEnd = 100000
    lighting.Brightness = 1
end

return FastMode