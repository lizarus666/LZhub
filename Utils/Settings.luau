--[[
    LZ HUB - GLOBAL SETTINGS
]]

local Settings = {
    -- Auto Farm Settings
    AutoFarm = {
        Enabled = false,
        Method = "Quest",
        BringMobs = true,
        BringDistance = 25,
    },
    
    -- Combat Settings
    Combat = {
        Aimbot = false,
        ESP = false,
        AntiCheatBypass = false,
        Smoothness = 0.5,
    },
    
    -- Utility Settings
    Utility = {
        AntiAFK = false,
        FastMode = false,
    },
    
    -- Database
    Quests = {
        [0] = {"Bandit", "BanditQuest1"},
        [10] = {"Monkey", "JungleQuest"},
        [30] = {"Pirate", "BuggyQuest1"},
        [60] = {"Desert Bandit", "DesertQuest"},
        [90] = {"Snow Bandit", "SnowQuest"},
        [120] = {"Chief Petty Officer", "MarineQuest2"},
        [150] = {"Sky Bandit", "SkyQuest"},
        [190] = {"Prisoner", "PrisonerQuest"},
        [220] = {"Warden", "ImpelQuest"},
        [250] = {"Toga Warrior", "ColosseumQuest"},
        [300] = {"Military Soldier", "MagmaQuest"},
        [375] = {"Fishman Warrior", "FishmanQuest"},
        [450] = {"God's Guard", "SkyExp1Quest"},
        [525] = {"Royal Squad", "SkyExp2Quest"},
        [625] = {"Galley Pirate", "FountainQuest"},
        [700] = {"Raider", "Area1Quest"},
        [775] = {"Swan Pirate", "Area2Quest"},
        [875] = {"Marine Lieutenant", "MarineQuest3"},
        [950] = {"Zombie", "ZombieQuest"},
        [1000] = {"Snow Trooper", "SnowMountainQuest"},
        [1100] = {"Lab Subordinate", "IceSideQuest"},
        [1175] = {"Magma Ninja", "FireSideQuest"},
        [1250] = {"Ship Deckhand", "ShipQuest1"},
        [1300] = {"Ship Steward", "ShipQuest2"},
        [1350] = {"Arctic Warrior", "FrostQuest"},
        [1425] = {"Sea Soldier", "ForgottenQuest"},
        [1500] = {"Pirate Millionaire", "PiratePortQuest"},
        [1575] = {"Dragon Crew Warrior", "DragonCrewQuest"},
        [1625] = {"Hydra Enforcer", "VenomCrewQuest"},
        [1700] = {"Marine Commodore", "MarineTreeIsland"},
        [1775] = {"Fishman Raider", "DeepForestIsland3"},
        [1825] = {"Forest Pirate", "DeepForestIsland"},
        [1900] = {"Jungle Pirate", "DeepForestIsland2"},
        [1975] = {"Reborn Skeleton", "HauntedQuest1"},
        [2025] = {"Demonic Soul", "HauntedQuest2"},
        [2075] = {"Peanut Scout", "NutsIslandQuest"},
        [2125] = {"Ice Cream Chef", "IceCreamIslandQuest"},
        [2200] = {"Cookie Crafter", "CakeQuest1"},
        [2250] = {"Baking Staff", "CakeQuest2"},
        [2300] = {"Cocoa Warrior", "ChocQuest1"},
        [2350] = {"Sweet Thief", "ChocQuest2"},
        [2400] = {"Candy Pirate", "CandyQuest1"},
        [2450] = {"Isle Outlaw", "TikiQuest1"},
        [2500] = {"Sun-kissed Warrior", "TikiQuest2"},
        [2550] = {"Serpent Hunter", "TikiQuest3"},
    },
    
    Bosses = {
        {"The Gorilla King", Vector3.new(-1128, 6, -451)},
        {"Bobby", Vector3.new(-1131, 14, 4080)},
        {"Yeti", Vector3.new(1185, 106, -1518)},
        {"Vice Admiral", Vector3.new(-4807, 21, 4360)},
        {"Warden", Vector3.new(5230, 4, 749)},
        {"Chief Warden", Vector3.new(5230, 4, 749)},
        {"Swan", Vector3.new(5230, 4, 749)},
        {"Magma Admiral", Vector3.new(-5694, 18, 8735)},
        {"Fishman Lord", Vector3.new(61350, 31, 1095)},
        {"Wysper", Vector3.new(-7927, 5551, -637)},
        {"Thunder God", Vector3.new(-7751, 5607, -2315)},
        {"Cyborg", Vector3.new(6138, 10, 3939)},
        {"Diamond", Vector3.new(-1569, 199, -31)},
        {"Jeremy", Vector3.new(2316, 449, 787)},
        {"Fajita", Vector3.new(-2086, 73, -4208)},
        {"Smoke Admiral", Vector3.new(-5078, 24, -5352)},
        {"Awakened Ice Admiral", Vector3.new(6473, 297, -6944)},
        {"Tide Keeper", Vector3.new(-3711, 77, -11469)},
        {"Stone", Vector3.new(-1049, 40, 6791)},
        {"Hydra Leader", Vector3.new(5836, 1019, -83)},
        {"Kilo Admiral", Vector3.new(2904, 509, -7349)},
        {"Captain Elephant", Vector3.new(-13393, 319, -8423)},
        {"Beautiful Pirate", Vector3.new(5370, 22, -89)},
        {"Cake Queen", Vector3.new(-710, 382, -11150)},
    },
    
    Islands = {
        "Start Island", "Jungle", "Pirate Village", "Desert", "Frozen Village",
        "Marine Fortress", "Sky Island", "Prison", "Colosseum", "Magma Village",
        "Underwater City", "Fountain Town", "Mansion", "Port Town", "Castle on the Sea",
        "Green Zone", "Cafe", "Factroy", "Hot and Cold", "Ice Castle",
        "Forgotten Island", "Usoapp Island", "Minion Island", "Haunted Castle",
        "Ice Cream Island", "Cake Island", "Chocolate Island", "Candy Island",
        "Peanut Island", "Tiki Outpost", "Hydra Island", "Floating Turtle",
        "Treehouse Island"
    },
}

return Settings