--[[
    LZ HUB - MAIN LOADER
    Version: 1.0.0
]]

local LZHub = {}

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

-- Variables
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Deteksi game
local GameID = game.PlaceId
local SupportedGames = {
    [2753915549] = "BloxFruits", -- Old World
    [4442272183] = "BloxFruits", -- New World
    [7449423635] = "BloxFruits", -- Third World
}

LZHub.CurrentGame = SupportedGames[GameID] or "Unknown"

if LZHub.CurrentGame ~= "BloxFruits" then
    warn("LZ Hub: Game tidak terdeteksi sebagai Blox Fruits!")
    return
end

print("✅ LZ Hub: Blox Fruits terdeteksi!")

-- Load semua module
local function LoadModules()
    print("📦 LZ Hub: Loading modules...")
    
    -- Load Library
    local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Library/UI.luau"))()
    
    -- Load Utils
    local Utility = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Utils/Utility.luau"))()
    local Settings = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Utils/Settings.luau"))()
    
    -- Load Modules
    local Modules = {
        AntiAFK = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/AntiAFK.luau"))(),
        Aimbot = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/Aimbot.luau"))(),
        ESP = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/ESP.luau"))(),
        Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/Teleport.luau"))(),
        AutoFarmLevel = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/AutoFarmLevel.luau"))(),
        AutoFarmChest = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/AutoFarmChest.luau"))(),
        AutoFarmBoss = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/AutoFarmBoss.luau"))(),
        AutoRaid = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/AutoRaid.luau"))(),
        FruitSniper = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/FruitSniper.luau"))(),
        FastMode = loadstring(game:HttpGet("https://raw.githubusercontent.com/lizarus666/LZHub/main/Modules/FastMode.luau"))(),
    }
    
    -- Initialize modules dengan dependency
    for name, module in pairs(Modules) do
        if module.Initialize then
            module:Initialize({
                Utility = Utility,
                Settings = Settings,
                LocalPlayer = LocalPlayer,
                Mouse = Mouse,
            })
        end
    end
    
    return UI, Modules, Utility, Settings
end

-- Main execution
local function Main()
    print("🔥 LZ Hub - Starting...")
    
    local success, err = pcall(function()
        local UI, Modules, Utility, Settings = LoadModules()
        
        -- Create GUI
        local GUI = UI:Create({
            Modules = Modules,
            Utility = Utility,
            Settings = Settings,
            LocalPlayer = LocalPlayer,
        })
        
        Utility:Notify("LZ Hub", "Loaded successfully!\nFitur lengkap siap digunakan", 3)
    end)
    
    if not success then
        warn("❌ LZ Hub Error: ", err)
    end
end

-- Run
Main()
