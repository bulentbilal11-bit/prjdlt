local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PashaPJD | Ultimate AIO Menu",
   LoadingTitle = "Sistem Hazırlanıyor...",
   LoadingSubtitle = "by PashaBEY",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Pasha_Configs",
      FileName = "MainConfig"
   },
   Keybind = "RightShift" -- MENÜYÜ GİZLEME/AÇMA TUŞU
})

-- AYARLAR DEĞİŞKENLERİ
local settings = {
    WalkSpeed = 16,
    Noclip = false,
    FullBright = false,
    InfJump = false,
    ESP = false,
    MaxDistance = 500
}

-- SEKMELER
local MainTab = Window:CreateTab("Oyuncu", 4483362458)
local VisualsTab = Window:CreateTab("Görsel", 4483362458)

-- 1. OYUNCU AYARLARI
MainTab:CreateSlider({
   Name = "Yürüme Hızı (Speed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Hız",
   CurrentValue = 16,
   Callback = function(Value)
      settings.WalkSpeed = Value
   end,
})

MainTab:CreateToggle({
   Name = "Noclip (Duvarlardan Geçme)",
   CurrentValue = false,
   Callback = function(Value)
      settings.Noclip = Value
   end,
})

MainTab:CreateToggle({
   Name = "Infinite Jump (Zıplayarak Uçma)",
   CurrentValue = false,
   Callback = function(Value)
      settings.InfJump = Value
   end,
})

-- 2. GÖRSEL AYARLAR
VisualsTab:CreateToggle({
   Name = "Chams (ESP)",
   CurrentValue = false,
   Callback = function(Value)
      settings.ESP = Value
   end,
})

VisualsTab:CreateSlider({
   Name = "ESP Görme Mesafesi",
   Range = {50, 5000},
   Increment = 50,
   Suffix = " Metre",
   CurrentValue = 500,
   Callback = function(Value)
      settings.MaxDistance = Value
   end,
})

VisualsTab:CreateToggle({
   Name = "Full Bright (Aydınlatma)",
   CurrentValue = false,
   Callback = function(Value)
      settings.FullBright = Value
   end,
})

-- ARKA PLAN SİSTEMİ (RunService)
game:GetService("RunService").RenderStepped:Connect(function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        -- Hız Güncelleme
        char.Humanoid.WalkSpeed = settings.WalkSpeed
        
        -- Noclip Güncelleme
        if settings.Noclip then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end
    
    -- Full Bright Güncelleme
    if settings.FullBright then
        game.Lighting.Brightness = 2
        game.Lighting.ClockTime = 14
        game.Lighting.GlobalShadows = false
    end
end)

-- Sınırsız Zıplama Eventi
game:GetService("UserInputService").JumpRequest:Connect(function()
    if settings.InfJump and game.Players.LocalPlayer.Character then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- ESP/Chams Sistemi
local function applyESP(p)
    if p == game.Players.LocalPlayer then return end
    game:GetService("RunService").RenderStepped:Connect(function()
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local myPos = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character.HumanoidRootPart.Position
            if myPos then
                local dist = (myPos - p.Character.HumanoidRootPart.Position).Magnitude
                local h = p.Character:FindFirstChild("ESPHighlight") or Instance.new("Highlight", p.Character)
                h.Name = "ESPHighlight"
                h.Enabled = settings.ESP and (dist <= settings.MaxDistance)
                h.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end)
end

for _, p in pairs(game.Players:GetPlayers()) do applyESP(p) end
game.Players.PlayerAdded:Connect(applyESP)

Rayfield:Notify({Title = "NyxPJD V4 Hazır!", Content = "Sağ Shift ile menüyü kontrol et.", Duration = 5})
