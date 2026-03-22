local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PashaPJD | Ultimate Menu V4",
   LoadingTitle = "Hız Ayarı Aktif Edildi",
   LoadingSubtitle = "by Pasha ",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Pasha_Configs",
      FileName = "MainConfig"
   },
   Keybind = "RightShift" -- Menüyü açıp kapatan tuş: SAĞ SHIFT
})

-- AYARLAR DEĞİŞKENLERİ
local settings = {
    WalkSpeed = 16, -- Varsayılan hız (Roblox standartı 16'dır)
    Noclip = false,
    FullBright = false,
    InfJump = false,
    ESP = false,
    ShowDistance = false,
    MaxDistance = 500
}

-- SEKMELER
local MainTab = Window:CreateTab("Oyuncu Ayarları", 4483362458)
local VisualsTab = Window:CreateTab("Görsel & ESP", 4483362458)

-- 1. HIZ AYARI (Hız Limitini Sen Belirle)
MainTab:CreateSlider({
   Name = "Yürüme Hızı (Speed Hack)",
   Range = {16, 1000}, -- 16 ile 1000 arası hız ayarı
   Increment = 1,
   Suffix = " Hız Birimi",
   CurrentValue = 16,
   Callback = function(Value)
      settings.WalkSpeed = Value
      -- Anlık güncelleme için karakter kontrolü
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
          game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

MainTab:CreateToggle({
   Name = "Noclip (Duvarlardan Geçme)",
   CurrentValue = false,
   Callback = function(Value) settings.Noclip = Value end,
})

MainTab:CreateToggle({
   Name = "Infinite Jump (Uçma/Zıplama)",
   CurrentValue = false,
   Callback = function(Value) settings.InfJump = Value end,
})

-- 2. GÖRSEL AYARLAR
VisualsTab:CreateToggle({
   Name = "ESP Chams",
   CurrentValue = false,
   Callback = function(Value) settings.ESP = Value end,
})

VisualsTab:CreateSlider({
   Name = "ESP Görme Mesafesi",
   Range = {50, 5000},
   Increment = 50,
   CurrentValue = 500,
   Callback = function(Value) settings.MaxDistance = Value end,
})

VisualsTab:CreateToggle({
   Name = "Full Bright (Aydınlatma)",
   CurrentValue = false,
   Callback = function(Value) settings.FullBright = Value end,
})

-- SİSTEM DÖNGÜSÜ (SÜREKLİ KONTROL)
game:GetService("RunService").RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        -- Hızın sürekli ayarlandığından emin ol (Bazı oyunlar hızı sıfırlayabilir)
        char.Humanoid.WalkSpeed = settings.WalkSpeed
        
        -- Noclip
        if settings.Noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
    
    -- Aydınlatma
    if settings.FullBright then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
    end
end)

-- Sınırsız Zıplama
game:GetService("UserInputService").JumpRequest:Connect(function()
    if settings.InfJump and game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ESP SİSTEMİ (Öncekiyle aynı stabil versiyon)
local function createESP(p)
    if p == game.Players.LocalPlayer then return end
    game:GetService("RunService").RenderStepped:Connect(function()
        local char = p.Character
        local myChar = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and myChar and myChar:FindFirstChild("HumanoidRootPart") then
            local dist = (myChar.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
            local h = char:FindFirstChild("ESPHighlight") or Instance.new("Highlight", char)
            h.Name = "ESPHighlight"
            h.Enabled = settings.ESP and (dist <= settings.MaxDistance)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end)
end
for _, p in pairs(game.Players:GetPlayers()) do createESP(p) end
game.Players.PlayerAdded:Connect(createESP)

Rayfield:Notify({Title = "NyxPJD Yüklendi", Content = "Hız ayarını menüden yapabilirsin!", Duration = 5})
