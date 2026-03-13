--[[
    LZ HUB - TELEPORT MODULE
]]

local Teleport = {
    Utility = nil,
}

function Teleport:Initialize(config)
    self.Utility = config.Utility
end

function Teleport:ToIsland(islandName)
    local island = workspace._WorldOrigin:FindFirstChild(islandName)
    if island then
        self.Utility:TweenTeleport(island.Position + Vector3.new(0, 50, 0))
        self.Utility:Notify("Teleport", "Teleport ke " .. islandName, 1)
    end
end

return Teleport