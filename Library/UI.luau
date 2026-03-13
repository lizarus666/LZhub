--[[
    LZ HUB - UI LIBRARY
]]

local UI = {}

function UI:Create(config)
    local Modules = config.Modules
    local Utility = config.Utility
    local Settings = config.Settings
    local LocalPlayer = config.LocalPlayer
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LZHub"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.IgnoreGuiInset = true
    
    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 700, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🔥 LZ HUB - BLOX FRUITS"
    Title.TextColor3 = Color3.fromRGB(0, 255, 255)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.Parent = TitleBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 35, 1, 0)
    CloseButton.Position = UDim2.new(1, -35, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 18
    CloseButton.Parent = TitleBar
    
    CloseButton.MouseButton1Click:Connect(function()
        -- Matikan semua fitur sebelum close
        for name, module in pairs(Modules) do
            if module.Enabled then
                module:Toggle()
            end
        end
        ScreenGui:Destroy()
    end)
    
    -- Tab Buttons
    local Tabs = {
        "🌾 AUTO FARM",
        "⚔ COMBAT",
        "🗺 TELEPORT",
        "👁 ESP",
        "⚡ UTILITY",
        "⚙ SETTINGS"
    }
    
    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, 0, 0, 40)
    TabFrame.Position = UDim2.new(0, 0, 0, 35)
    TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabFrame.BorderSizePixel = 0
    TabFrame.Parent = MainFrame
    
    local TabButtons = {}
    for i, tabName in ipairs(Tabs) do
        local btn = Instance.new("TextButton")
        btn.Name = tabName .. "Btn"
        btn.Size = UDim2.new(0, 115, 1, 0)
        btn.Position = UDim2.new(0, (i-1) * 115, 0, 0)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.Parent = TabFrame
        TabButtons[tabName] = btn
    end
    
    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Size = UDim2.new(1, -20, 1, -95)
    ContentFrame.Position = UDim2.new(0, 10, 0, 85)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.Parent = MainFrame
    
    -- Create Pages
    local Pages = {}
    for i, tabName in ipairs(Tabs) do
        local page = Instance.new("ScrollingFrame")
        page.Name = tabName .. "Page"
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 5
        page.CanvasSize = UDim2.new(0, 0, 0, 600)
        page.Parent = ContentFrame
        page.Visible = (i == 1)
        Pages[tabName] = page
    end
    
    -- Tab Switching
    for tabName, btn in pairs(TabButtons) do
        btn.MouseButton1Click:Connect(function()
            for _, page in pairs(Pages) do
                page.Visible = false
            end
            Pages[tabName].Visible = true
            
            for _, otherBtn in pairs(TabButtons) do
                otherBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
    end
    
    -- Helper function to create buttons
    local function CreateButton(parent, text, pos, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 160, 0, 30)
        btn.Position = UDim2.new(0, pos.X, 0, pos.Y)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 13
        btn.Parent = parent
        
        btn.MouseButton1Click:Connect(callback)
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)
        
        return btn
    end
    
    local function CreateToggle(parent, text, pos, module)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 160, 0, 30)
        frame.Position = UDim2.new(0, pos.X, 0, pos.Y)
        frame.BackgroundTransparency = 1
        frame.Parent = parent
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 120, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 13
        label.Parent = frame
        
        local toggle = Instance.new("TextButton")
        toggle.Size = UDim2.new(0, 30, 0, 30)
        toggle.Position = UDim2.new(1, -30, 0, 0)
        toggle.BackgroundColor3 = module.Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        toggle.Text = ""
        toggle.Parent = frame
        
        toggle.MouseButton1Click:Connect(function()
            module:Toggle()
            toggle.BackgroundColor3 = module.Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        end)
        
        return frame
    end
    
    local yPos = 10
    
    -- ===== AUTO FARM PAGE =====
    local farmPage = Pages["🌾 AUTO FARM"]
    
    CreateToggle(farmPage, "Auto Farm Level", Vector2.new(10, yPos), Modules.AutoFarmLevel)
    CreateToggle(farmPage, "Auto Farm Chest", Vector2.new(180, yPos), Modules.AutoFarmChest)
    
    yPos = yPos + 40
    CreateToggle(farmPage, "Auto Farm Boss", Vector2.new(10, yPos), Modules.AutoFarmBoss)
    CreateToggle(farmPage, "Auto Raid", Vector2.new(180, yPos), Modules.AutoRaid)
    
    yPos = yPos + 40
    CreateToggle(farmPage, "Fruit Sniper", Vector2.new(10, yPos), Modules.FruitSniper)
    
    -- ===== COMBAT PAGE =====
    local combatPage = Pages["⚔ COMBAT"]
    yPos = 10
    
    CreateToggle(combatPage, "Aimbot", Vector2.new(10, yPos), Modules.Aimbot)
    CreateToggle(combatPage, "ESP", Vector2.new(180, yPos), Modules.ESP)
    
    yPos = yPos + 40
    CreateToggle(combatPage, "Anti-Cheat Bypass", Vector2.new(10, yPos), {
        Enabled = Settings.Combat.AntiCheatBypass,
        Toggle = function()
            Settings.Combat.AntiCheatBypass = not Settings.Combat.AntiCheatBypass
            Utility:Notify("Anti-Cheat Bypass", Settings.Combat.AntiCheatBypass and "Diaktifkan" or "Dimatikan", 1)
        end
    })
    
    -- ===== TELEPORT PAGE =====
    local teleportPage = Pages["🗺 TELEPORT"]
    yPos = 10
    
    local islands = {
        "Start Island", "Jungle", "Pirate Village", "Desert", "Frozen Village",
        "Marine Fortress", "Sky Island", "Prison", "Colosseum", "Magma Village",
        "Underwater City", "Fountain Town", "Mansion", "Port Town", "Castle on the Sea",
        "Green Zone", "Cafe", "Factroy", "Hot and Cold", "Ice Castle",
        "Forgotten Island", "Usoapp Island", "Minion Island", "Haunted Castle",
        "Ice Cream Island", "Cake Island", "Chocolate Island", "Candy Island",
        "Peanut Island", "Tiki Outpost", "Hydra Island", "Floating Turtle",
        "Treehouse Island"
    }
    
    for i = 1, #islands, 2 do
        if i <= #islands then
            CreateButton(teleportPage, islands[i], Vector2.new(10, yPos), function()
                Modules.Teleport:ToIsland(islands[i])
            end)
        end
        
        if i+1 <= #islands then
            CreateButton(teleportPage, islands[i+1], Vector2.new(180, yPos), function()
                Modules.Teleport:ToIsland(islands[i+1])
            end)
        end
        
        yPos = yPos + 40
    end
    
    -- ===== ESP PAGE =====
    local espPage = Pages["👁 ESP"]
    yPos = 10
    
    CreateToggle(espPage, "ESP Enabled", Vector2.new(10, yPos), Modules.ESP)
    
    local espInfo = Instance.new("TextLabel")
    espInfo.Size = UDim2.new(1, -20, 0, 100)
    espInfo.Position = UDim2.new(0, 10, 0, 50)
    espInfo.BackgroundTransparency = 1
    espInfo.Text = "ESP akan menampilkan:\n- Players (Merah)\n- Mobs (Kuning)\n- Fruits (Hijau)\n- Chests (Ungu)"
    espInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    espInfo.TextWrapped = true
    espInfo.TextXAlignment = Enum.TextXAlignment.Left
    espInfo.TextYAlignment = Enum.TextYAlignment.Top
    espInfo.Font = Enum.Font.Gotham
    espInfo.TextSize = 13
    espInfo.Parent = espPage
    
    -- ===== UTILITY PAGE =====
    local utilityPage = Pages["⚡ UTILITY"]
    yPos = 10
    
    CreateToggle(utilityPage, "Anti AFK", Vector2.new(10, yPos), Modules.AntiAFK)
    CreateToggle(utilityPage, "Fast Mode", Vector2.new(180, yPos), Modules.FastMode)
    
    -- Server Hop Button
    yPos = yPos + 40
    CreateButton(utilityPage, "🔄 Server Hop", Vector2.new(10, yPos), function()
        local servers = {}
        local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100")
        local data = game:GetService("HttpService"):JSONDecode(req)
        for _, v in pairs(data.data) do
            if v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, v.id)
            end
        end
        if #servers > 0 then
            Utility:Notify("Server Hop", "Mencari server baru...", 1)
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
        end
    end)
    
    CreateButton(utilityPage, "🔄 Rejoin Server", Vector2.new(180, yPos), function()
        Utility:Notify("Rejoin", "Rejoin server...", 1)
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end)
    
    -- ===== SETTINGS PAGE =====
    local settingsPage = Pages["⚙ SETTINGS"]
    yPos = 10
    
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -20, 0, 200)
    infoLabel.Position = UDim2.new(0, 10, 0, yPos)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = "🔥 LZ HUB - BLOX FRUITS\n\n" ..
                    "Version: 1.0.0\n" ..
                    "Author: LZ\n" ..
                    "Player: " .. LocalPlayer.Name .. "\n" ..
                    "Level: " .. (LocalPlayer.Data and LocalPlayer.Data.Level.Value or 0) .. "\n" ..
                    "Server: " .. game.JobId .. "\n\n" ..
                    "Fitur Lengkap:\n" ..
                    "✅ Auto Farm Level\n" ..
                    "✅ Auto Farm Chest\n" ..
                    "✅ Auto Farm Boss\n" ..
                    "✅ Auto Raid\n" ..
                    "✅ Fruit Sniper\n" ..
                    "✅ Aimbot\n" ..
                    "✅ ESP\n" ..
                    "✅ Anti AFK\n" ..
                    "✅ Fast Mode\n" ..
                    "✅ Teleport Semua Island\n" ..
                    "✅ Server Hop"
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.TextXAlignment = Enum.TextXAlignment.Left
    infoLabel.TextYAlignment = Enum.TextYAlignment.Top
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextSize = 13
    infoLabel.Parent = settingsPage
    
    yPos = yPos + 210
    CreateButton(settingsPage, "📋 Copy Server ID", Vector2.new(10, yPos), function()
        setclipboard(game.JobId)
        Utility:Notify("Copied", "Server ID copied to clipboard", 1)
    end)
    
    CreateButton(settingsPage, "❌ Close GUI", Vector2.new(180, yPos), function()
        ScreenGui:Destroy()
    end)
    
    return ScreenGui
end

return UI
