local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PashaPJD | Ultimate Stealth V1",
   LoadingTitle = "Güvenli Sistemler Yükleniyor...",
   LoadingSubtitle = "Anti-Ban Protokolü Aktif",
   ConfigurationSaving = {Enabled = true, FolderName = "PashaPJD_Final", FileName = "Config"},
   Keybind = "RightShift" 
})

-- AYARLAR VE GÜVENLİK SINIRLARI
local settings = {
    WalkSpeed = 16,
    JumpPower = 50,
    Noclip = false,
    FullBright = false,
    ESP = false,
    LootScanner = false,
    MaxDistance = 400,
    SilentAim = false,
    AimDistance = 150,
    Instakill = false -- Sadece çok yakın mesafede çalışır (Ban koruması için)
}

-- SEKMELER
local MainTab = Window:CreateTab("Hareket", 4483362458)
local CombatTab = Window:CreateTab("Savaş", 4483362458)
local VisualsTab = Window:CreateTab("Görsel & Loot", 4483362458)

-- 1. HAREKET (GÜVENLİ SINIRLARDA)
MainTab:CreateSlider({
   Name = "Legit Speed (Güvenli: 16-45)",
   Range = {16, 60},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(Value) settings.WalkSpeed = Value end,
})

MainTab:CreateToggle({
   Name = "Noclip (Duvar Geçme)",
   CurrentValue = false,
   Callback = function(Value) settings.Noclip = Value end,
})

-- 2. SAVAŞ (GİZLİ SİSTEMLER)
CombatTab:CreateToggle({
   Name = "Silent Aim (Otomatik Hedef)",
   CurrentValue = false,
   Callback = function(Value) settings.SilentAim = Value end,
})

CombatTab:CreateSlider({
   Name = "Aim Mesafesi",
   Range = {10, 300},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value) settings.AimDistance = Value end,
})

CombatTab:CreateToggle({
   Name = "Instakill (Yakın Mesafe Modu)",
   CurrentValue = false,
   Callback = function(Value) settings.Instakill = Value end,
})

-- 3. GÖRSEL & LOOT SCANNER
VisualsTab:CreateToggle({
   Name = "Player ESP & Chams",
   CurrentValue = false,
   Callback = function(Value) settings.ESP = Value end,
})

VisualsTab:CreateToggle({
   Name = "Loot & Silah Scanner",
   CurrentValue = false,
   Callback = function(Value) settings.LootScanner = Value end,
})

VisualsTab:CreateSlider({
   Name = "Tarama Mesafesi",
   Range = {100, 1000},
   Increment = 50,
   CurrentValue = 400,
   Callback = function(Value) settings.MaxDistance = Value end,
})

VisualsTab:CreateToggle({
   Name = "Full Bright",
   CurrentValue = false,
   Callback = function(Value) settings.FullBright = Value end,
})

-- FONKSİYONLAR: LOOT & AIM
local function getLoot(p)
    local w = "Bilinmiyor"
    if p.Character then
        local t = p.Character:FindFirstChildOfClass("Tool") or (p:FindFirstChild("Backpack") and p.Backpack:FindFirstChildOfClass("Tool"))
        if t then w = t.Name end
    end
    return w
end

-- ANA SİSTEM DÖNGÜSÜ
game:GetService("RunService").RenderStepped:Connect(function()
    local lp = game.Players.LocalPlayer
    local char = lp.Character
    if char and char:FindFirstChild("Humanoid") then
        -- Hız Kontrolü
        char.Humanoid.WalkSpeed = settings.WalkSpeed
        
        -- Noclip Kontrolü
        if settings.Noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
    
    -- Işıklandırma
    if settings.FullBright then
        game.Lighting.Brightness = 2
        game.Lighting.GlobalShadows = false
    end
end)

-- ESP & LOOT DISPLAY
local function applyESP(p)
    if p == game.Players.LocalPlayer then return end
    game:GetService("RunService").RenderStepped:Connect(function()
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character then
            local dist = (p.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            
            -- Highlight (Chams)
            local h = p.Character:FindFirstChild("Highlight") or Instance.new("Highlight", p.Character)
            h.Enabled = settings.ESP and (dist <= settings.MaxDistance)
            h.FillColor = Color3.fromRGB(255, 0, 0)
            
            -- Loot Label
            local gui = p.Character:FindFirstChild("InfoGui")
            if settings.LootScanner and (dist <= settings.MaxDistance) then
                if not gui then
                    gui = Instance.new("BillboardGui", p.Character)
                    gui.Name = "InfoGui"
                    gui.Size = UDim2.new(0, 150, 0, 50)
                    gui.AlwaysOnTop = true
                    gui.Adornee = p.Character:FindFirstChild("Head")
                    gui.ExtentsOffset = Vector3.new(0, 3, 0)
                    local l = Instance.new("TextLabel", gui)
                    l.Size = UDim2.new(1,0,1,0)
                    l.BackgroundTransparency = 1
                    l.TextColor3 = Color3.fromRGB(255, 255, 255)
                    l.TextSize = 12
                    l.TextStrokeTransparency = 0
                end
                gui.TextLabel.Text = string.format("%s\nSilah: %s\n[%dm]", p.Name, getLoot(p), math.floor(dist))
            else
                if gui then gui:Destroy() end
            end
        end
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do applyESP(p) end
game.Players.PlayerAdded:Connect(applyESP)

-- GÜVENLİK UYARISI
Rayfield:Notify({
   Title = "NİHAİ SÜRÜM AKTİF",
   Content = "Hızı 45'in, Aim mesafesini 150'nin üzerine çıkarmamanız önerilir.",
   Duration = 10
})
