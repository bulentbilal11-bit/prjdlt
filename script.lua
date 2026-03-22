-- [[ PashaPJD V1 Premium | FULL CONTROL EDITION ]] --
local Redline = loadstring(game:HttpGet("https://raw.githubusercontent.com/oc-u/Redline-UI-Lib/main/Source.lua"))()

local Window = Redline:CreateWindow({
    Title = "PashaPJD V1 Premium | FULL CONTROL",
    DefaultColor = Color3.fromRGB(0, 160, 255),
    TabWidth = 190,
    Size = UDim2.new(0, 620, 0, 750)
})

-- [[ TÜM AYARLAR - HER ŞEY ÖZELLEŞTİRİLEBİLİR ]] --
local settings = {
    -- Combat & FOV
    SilentAim = false, AimPart = "Torso", AimDist = 150,
    Triggerbot = false, TriggerDist = 50,
    ShowFOV = false, FOVSize = 100, FOVColor = Color3.fromRGB(255, 255, 255),
    NoRecoil = false, NoSpread = false,
    -- Player ESP
    PlayerESP = false, PlayerDist = 1500, PlayerColor = Color3.fromRGB(255, 0, 0),
    -- Bot ESP
    BotESP = false, BotDist = 600, BotColor = Color3.fromRGB(0, 255, 100),
    -- Item ESP
    ItemESP = false, ItemDist = 200, ItemColor = Color3.fromRGB(255, 215, 0),
    -- Trap ESP (Mayınlar)
    TrapESP = false, TrapDist = 100, TrapColor = Color3.fromRGB(255, 80, 0),
    -- Body ESP (Cesetler)
    BodyESP = false, BodyDist = 300, BodyColor = Color3.fromRGB(180, 180, 180),
    -- Misc & Engine
    SpeedEnabled = false, SpeedValue = 0.4,
    ThirdPerson = false, TP_Dist = 12,
    FPSBoost = false, NoFog = false, FullBright = false,
    PanicKey = Enum.KeyCode.RightControl, IsPanicked = false
}

-- [[ SEKMELERİN DÜZENLENMESİ ]] --
local CombatTab = Window:CreateTab("🎯 Savaş & Aim")
local PlayerTab = Window:CreateTab("👤 Oyuncu ESP")
local BotTab = Window:CreateTab("🤖 Bot ESP")
local LootTab = Window:CreateTab("📦 Loot & Tehlike")
local WorldTab = Window:CreateTab("🌍 Dünya & Görsel")
local MiscTab = Window:CreateTab("⚙️ Hareket & Sistem")

-- --- 1. SAVAŞ & AIM ---
CombatTab:CreateSection("Silent Aim & FOV")
CombatTab:CreateToggle({Title = "Silent Aim Aktif", Default = false, Callback = function(v) settings.SilentAim = v end})
CombatTab:CreateSlider({Title = "Aim Menzili", Min = 10, Max = 1000, Default = 150, Callback = function(v) settings.AimDist = v end})
CombatTab:CreateToggle({Title = "FOV Dairesi Göster", Default = false, Callback = function(v) settings.ShowFOV = v end})
CombatTab:CreateSlider({Title = "FOV Boyutu", Min = 30, Max = 500, Default = 100, Callback = function(v) settings.FOVSize = v end})
CombatTab:CreateColorPicker({Title = "FOV Rengi", Default = settings.FOVColor, Callback = function(c) settings.FOVColor = c end})

CombatTab:CreateSection("Triggerbot & Balistik")
CombatTab:CreateToggle({Title = "Triggerbot Aktif", Default = false, Callback = function(v) settings.Triggerbot = v end})
CombatTab:CreateSlider({Title = "Trigger Menzili", Min = 5, Max = 200, Default = 50, Callback = function(v) settings.TriggerDist = v end})
CombatTab:CreateToggle({Title = "No Recoil", Default = false, Callback = function(v) settings.NoRecoil = v end})
CombatTab:CreateToggle({Title = "No Spread", Default = false, Callback = function(v) settings.NoSpread = v end})

-- --- 2. OYUNCU ESP ---
PlayerTab:CreateSection("Oyuncu Takip Ayarları")
PlayerTab:CreateToggle({Title = "Oyuncu ESP Aktif", Default = false, Callback = function(v) settings.PlayerESP = v end})
PlayerTab:CreateSlider({Title = "ESP Menzili", Min = 100, Max = 5000, Default = 1500, Callback = function(v) settings.PlayerDist = v end})
PlayerTab:CreateColorPicker({Title = "ESP Rengi", Default = settings.PlayerColor, Callback = function(c) settings.PlayerColor = c end})

-- --- 3. BOT ESP ---
BotTab:CreateSection("Bot / NPC Takip Ayarları")
BotTab:CreateToggle({Title = "Bot ESP Aktif", Default = false, Callback = function(v) settings.BotESP = v end})
BotTab:CreateSlider({Title = "ESP Menzili", Min = 50, Max = 2000, Default = 600, Callback = function(v) settings.BotDist = v end})
BotTab:CreateColorPicker({Title = "ESP Rengi", Default = settings.BotColor, Callback = function(c) settings.BotColor = c end})

-- --- 4. LOOT & TEHLİKE ---
LootTab:CreateSection("Eşya (Loot) ESP")
LootTab:CreateToggle({Title = "İtem ESP Aktif", Default = false, Callback = function(v) settings.ItemESP = v end})
LootTab:CreateSlider({Title = "İtem Menzili", Min = 10, Max = 1000, Default = 200, Callback = function(v) settings.ItemDist = v end})
LootTab:CreateColorPicker({Title = "İtem Rengi", Default = settings.ItemColor, Callback = function(c) settings.ItemColor = c end})

LootTab:CreateSection("Tehlike (Mayın) & Cesetler")
LootTab:CreateToggle({Title = "Tuzak ESP Aktif", Default = false, Callback = function(v) settings.TrapESP = v end})
LootTab:CreateSlider({Title = "Tuzak Menzili", Min = 10, Max = 500, Default = 100, Callback = function(v) settings.TrapDist = v end})
LootTab:CreateColorPicker({Title = "Tuzak Rengi", Default = settings.TrapColor, Callback = function(c) settings.TrapColor = c end})

LootTab:CreateSection("Ölü Beden ESP")
LootTab:CreateToggle({Title = "Ceset ESP Aktif", Default = false, Callback = function(v) settings.BodyESP = v end})
LootTab:CreateSlider({Title = "Ceset Menzili", Min = 10, Max = 1000, Default = 300, Callback = function(v) settings.BodyDist = v end})
LootTab:CreateColorPicker({Title = "Ceset Rengi", Default = settings.BodyColor, Callback = function(c) settings.BodyColor = c end})

-- --- 5. DÜNYA & GÖRSEL ---
WorldTab:CreateSection("Kamera & Görüş")
WorldTab:CreateToggle({Title = "Third Person Aktif", Default = false, Callback = function(v) settings.ThirdPerson = v end})
WorldTab:CreateSlider({Title = "Kamera Mesafesi", Min = 5, Max = 30, Default = 12, Callback = function(v) settings.TP_Dist = v end})
WorldTab:CreateToggle({Title = "Full Bright (Aydınlık)", Default = false, Callback = function(v) settings.FullBright = v end})
WorldTab:CreateToggle({Title = "No Fog (Sisi Kaldır)", Default = false, Callback = function(v) settings.NoFog = v end})

WorldTab:CreateSection("Atmosfer Optimizasyonu")
WorldTab:CreateToggle({Title = "FPS Boost (Efektleri Sil)", Default = false, Callback = function(v) 
    settings.FPSBoost = v 
    if v then 
        game.Lighting.GlobalShadows = false
        for _, x in pairs(game:GetDescendants()) do if x:IsA("PostEffect") then x.Enabled = false end end
    end
end})

-- --- 6. HAREKET & SİSTEM ---
MiscTab:CreateSection("PashaPJD Hareket")
MiscTab:CreateToggle({Title = "Hız Hilesi Aktif", Default = false, Callback = function(v) settings.SpeedEnabled = v end})
MiscTab:CreateSlider({Title = "Hız Gücü", Min = 0, Max = 1, Default = 0.4, Callback = function(v) settings.SpeedValue = v end})

MiscTab:CreateSection("Güvenlik (Self-Destruct)")
MiscTab:CreateKeybind({Title = "PANİC TUŞU", Default = settings.PanicKey, Callback = function()
    settings.IsPanicked = true
    Window:Destroy()
    if FOVCircle then FOVCircle:Remove() end
    for _, v in pairs(game:GetDescendants()) do if v.Name == "GhostHighlight" then v:Destroy() end end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "PashaPJD", Text = "SİSTEM İMHA EDİLDİ!", Duration = 5})
end})

-- [[ 🚀 CORE ENGINE - FULLY OPTIMIZED ]] --

local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1; FOVCircle.NumSides = 64; FOVCircle.Transparency = 1;

local Tracked = {}
local function applyESP(obj, type) if obj and not Tracked[obj] then Tracked[obj] = type end end

-- ESP LOOP (Task Based)
task.spawn(function()
    while task.wait(0.2) do
        if settings.IsPanicked then break end
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        
        for obj, type in pairs(Tracked) do
            if not obj or not obj.Parent then Tracked[obj] = nil continue end
            local pos = (obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") and obj.HumanoidRootPart.Position) or (obj:IsA("BasePart") and obj.Position)
            if pos then
                local dist = (pos - hrp.Position).Magnitude
                local active, maxD, col = false, 0, Color3.new(1,1,1)
                
                if type == "Player" then active, maxD, col = settings.PlayerESP, settings.PlayerDist, settings.PlayerColor
                elseif type == "Bot" then active, maxD, col = settings.BotESP, settings.BotDist, settings.BotColor
                elseif type == "Item" then active, maxD, col = settings.ItemESP, settings.ItemDist, settings.ItemColor
                elseif type == "Trap" then active, maxD, col = settings.TrapESP, settings.TrapDist, settings.TrapColor
                elseif type == "Body" then active, maxD, col = settings.BodyESP, settings.BodyDist, settings.BodyColor end
                
                local h = obj:FindFirstChild("GhostHighlight")
                if active and dist <= maxD then
                    if not h then h = Instance.new("Highlight", obj); h.Name = "GhostHighlight" end
                    h.FillColor = col; h.Enabled = true
                elseif h then h.Enabled = false end
            end
        end
    end
end)

-- COMBAT & WORLD SYNC
game:GetService("RunService").RenderStepped:Connect(function()
    if settings.IsPanicked then return end
    -- FOV Update
    FOVCircle.Visible = settings.ShowFOV
    FOVCircle.Radius = settings.FOVSize
    FOVCircle.Color = settings.FOVColor
    FOVCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X/2, workspace.CurrentCamera.ViewportSize.Y/2)
    -- Camera Update
