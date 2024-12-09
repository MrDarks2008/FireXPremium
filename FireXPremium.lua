-- local HWIDTable = loadstring(game:HttpGet("https://raw.githubusercontent.com/CrismonPetrasion/HWID/main/Checker.lua"))()
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()
--#endregionss
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Variables

local Camera = workspace.CurrentCamera
local Weapons = ReplicatedStorage.Weapons
local Debris = workspace.Debris
local RayIgnore = workspace.Ray_Ignore
local LocalPlayer = Players.LocalPlayer

local CurrentCamera = Camera
local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
------
local ESPSettings = {
    Enabled = false,
    ChamsColor = Color3.fromRGB(200,200,200)
};
--// Library

local Library = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

--// Window

local Window = Library:CreateWindow({
    Name = "FireX",
    LoadingTitle = "Loading Script",
    LoadingSubtitle = "By Ukrainey",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "CounterBlox", -- Create a custom folder for your hub/game
        FileName = "CounterBlox"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
        Title = "Key System",
        Subtitle = "/",
        Note = "discord.gg/vZQTkyCXD8",
        FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
        SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
        GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
        Key = {"keyinfromiryourass2sfdswqsbghgas"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
})
--tabs

local Home = Window:CreateTab("Home", 4483362458) -- Title, Image
local Combat = Window:CreateTab("Combat", 4483362458) -- Title, Image
local Visuals = Window:CreateTab("Visuals", 4483362458) -- Title, Image
local World = Window:CreateTab("World", 4483362458) -- Title, Image

--// Version

local Version = "1.0"

--// Game

if true then
    function GetClosestPlayer(CFrame)
        local Ray = Ray.new(CFrame.Position, CFrame.LookVector).Unit
    
        local Target = nil
        local Mag = math.huge
    
        for _, v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Humanoid").Health > 0 and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart") and v ~= LocalPlayer and (v.Team ~= LocalPlayer.Team or (not AimSettings.TeamCheck)) then
                local Position = v.Character.Head.Position
                local MagBuff = (Position - Ray:ClosestPoint(Position)).Magnitude
                if MagBuff < Mag then
                    Mag = MagBuff
                    Target = v
                end
            end
        end
    
        return Target
    end

    do
        --// Home
        Home:CreateLabel("Premium Version")
        Home:CreateLabel("Version: ".. Version)
    end
end
--sss
Visuals:CreateSection("Jump power")
        Visuals:CreateToggle({
            Name = "Jump Enable",
            CurrentValue = false,
            Flag = "Jump",
            Callback = function(Value)
                _G.Jump = Value
            end,
        })
        Visuals:CreateSlider({
            Name = "Jump Power",
            Range = {32, 70},
            Increment = 1,
            CurrentValue = 0,
            Flag = "Damage", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.JumpSlieder = Value
            end,
        })
Visuals:CreateSection("Damage")
        Visuals:CreateToggle({
            Name = "Damage Enabled",
            CurrentValue = false,
            Flag = "Damage",
            Callback = function(Value)
                _G.Damage = Value
            end,
        })
        Visuals:CreateSlider({
            Name = "Third Person Distance",
            Range = {0, 100},
            Increment = 1,
            CurrentValue = 0,
            Flag = "Damage", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.DamageSlider = Value
            end,
        })
Visuals:CreateSection("Cash")
        Visuals:CreateToggle({
            Name = "Cash",
            CurrentValue = false,
            Flag = "gun_material",
            Callback = function(Value)
                _G.Cash = Value
                RunService.RenderStepped:Connect(function()
                    if LocalPlayer and LocalPlayer.Parent then
                        LocalPlayer.Cash.Value = 25000
                    else
                        LocalPlayer.Cash.Value = default
                    end
            end)   
        end
})
Visuals:CreateSection("Chams")
        Visuals:CreateToggle({
            Name = "Gun chams",
            CurrentValue = false,
            Flag = "gun_material",
            Callback = function(Value)
                _G.GunsChams = Value
            end,
        })
		Visuals:CreateColorPicker({
            Name = "Gun Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "gun_material", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.ChamsColor = Value
            end
        })
		Visuals:CreateSection("Arms Chams")
		Visuals:CreateToggle({
            Name = "Arms chams",
            CurrentValue = false,
            Flag = "arm_material",
            Callback = function(Value)
                _G.ArmsChams = Value
            end,
        })
		Visuals:CreateColorPicker({
            Name = "Arms Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "arm_material", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
				_G.ArmChamsColor = Value
            end
        })
        Visuals:CreateSection("Players")
        Visuals:CreateToggle({
            Name = "Chams",
            CurrentValue = false,
            Flag = "Chams",
            Callback = function(Value)
                ESPSettings.Enabled = Value
            end,
        })
        Visuals:CreateColorPicker({
            Name = "Chams Color",
            Color = Color3.fromRGB(200,200,200),
            Flag = "ChamsColor", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                ESPSettings.ChamsColor = Value
                _G.Chams = Value
            end
        })
        --Comate
        Combat:CreateSection("AimBot")
        Combat:CreateToggle({
            Name = "Silent Aim",
            CurrentValue = false,
            Flag = "AimBot",
            Callback = function(Value)
                getplrsname()
                _G.Silent = Value
            end,
        })
        Combat:CreateDropdown({
            Name = "function to ",
            Options = {'Legit', 'Small', 'Medium', 'Hard'},
            CurrentOption = {"Silent😈"},
            MultipleOptions = false,
            Flag = "Aimbot", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Option)
                _G.FOVring = Option
                if _G.FOVring == "Legit" then
                    Sas.FOVring1 = Vector3.new(7,7,7)
                elseif _G.FOVring == "Small" then
                    Sas.FOVring1 = Vector3.new(16,16,16)
                elseif _G.FOVring == "Medium" then
                    Sas.FOVring1 = Vector3.new(43,43,43)
                elseif _G.FOVring == "Hard" then
                    Sas.FOVring1 = Vector3.new(113,113,113)  
                end
                print("_G.FOVring")
                print("Sas.FOVring1")
            end,
        })
        --#endregionss
        World:CreateSection("Settings World")
        World:CreateToggle({
            Name = "World",
            CurrentValue = false,
            Flag = "World",
            Callback = function(Value)
                world()
                _G.World = Value
            end,
        })
        World:CreateColorPicker({
            Name = "World Color",
            Color = Color3.fromRGB(255,255,255),
            Flag = "world", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                world()
                _G.WorldColor = Value
			end
        })
        World:CreateSlider({
            Name = "Brigthnnes",
            Range = {0, 24},
            Increment = 1,
            CurrentValue = 0,
            Flag = "FOVRadius", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
            Callback = function(Value)
                _G.Brigthnes = Value
            end,
        })
--sasas
function world()
    if _G.World == true then
        if _G.WorldColor then
        game:GetService("Lighting").Ambient = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").OutdoorAmbient = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").FogColor = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").ColorShift_Bottom = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").ColorShift_Top = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").Brightness = _G.Brigthnes or 2

        else
        game:GetService("Lighting").Ambient = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").OutdoorAmbient = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").FogColor = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").ColorShift_Bottom = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").ColorShift_Top = _G.WorldColor or Color3.fromRGB(255,255,255)
        game:GetService("Lighting").Brightness = _G.Brigthnes or 2
    end
else
    game:GetService("Lighting").Ambient = Color3.fromRGB(0, 0, 0)
    game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(0, 0, 0)
    game:GetService("Lighting").FogColor = _G.WorldColor or Color3.fromRGB(0,0,0)
    game:GetService("Lighting").ColorShift_Bottom = Color3.fromRGB(0,0,0)
    game:GetService("Lighting").ColorShift_Top = Color3.fromRGB(0,0,0)
    game:GetService("Lighting").Brightness = 0
    end
end
--functions 
RunService.RenderStepped:Connect(function()
    if _G.GunsChams == true then
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                        AnotherStuff.Color = _G.ChamsColor or Color3.fromRGB(200,200,200)
                        AnotherStuff.Material = Enum.Material.ForceField
                    end
                end
            end
        end
    else
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("MeshPart") or AnotherStuff:IsA("BasePart") then
                        AnotherStuff.Color = Color3.fromRGB(200,200,200)
                        AnotherStuff.Material = Enum.Material.SmoothPlastic
                    end
                end
            end
        end            
    end
    task.wait()
end)
RunService.RenderStepped:Connect(function()
    if _G.ArmsChams == true then
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Color = _G.ArmChamsColor or Color3.fromRGB(204,142,105)
                                Arm.Material = Enum.Material.Glass
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
                                    if StuffInArm:IsA("BasePart") or StuffInArm:IsA("MeshPart") then
                                        StuffInArm.Material = Enum.Material.ForceField
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    else
        for _, Stuff in ipairs(workspace.Camera:GetChildren()) do
            if Stuff:IsA("Model") and Stuff.Name == "Arms" then
                for _, AnotherStuff in ipairs(Stuff:GetChildren()) do
                    if AnotherStuff:IsA("Model") and AnotherStuff.Name ~= "AnimSaves" then
                        for _, Arm in ipairs(AnotherStuff:GetChildren()) do
                            if Arm:IsA("BasePart") then
                                Arm.Color = Color3.fromRGB(204,142,105)
                                Arm.Material = Enum.Material.SmoothPlastic
                                for _, StuffInArm in ipairs(Arm:GetChildren()) do
									if StuffInArm:IsA("BasePart") or StuffInArm:IsA("MeshPart") then
                                        StuffInArm.Material = Enum.Material.SmoothPlastic
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    task.wait()
end);

RunService.RenderStepped:Connect(function()
    for _, Player in ipairs(Players:GetChildren()) do
        if ESPSettings.Enabled == true then
            if Player.Character:FindFirstChild("Highlight") then
                Player.Character.Highlight.FillColor = ESPSettings.ChamsColor or Color3.fromRGB(200,200,200)
                Player.Character.Highlight.Material = Enum.Material.ForceField
                Player.Character.Highlight.FillColorTransparency = 1
                Player.Character.Highlight.OutlineColor = ESPSettings.ChamsColor
                Player.Character.Highlight.OutlineTransparency = 0
            else
                local Highlight = Instance.new("Highlight", Player.Character)
                Highlight.FillColor = ESPSettings.ChamsColor or Color3.fromRGB(200,200,200)
                Highlight.Material =  Enum.Material.ForceField
                Highlight.FillTransparency = 1
                Highlight.OutlineColor = ESPSettings.ChamsColor
                Highlight.OutlineTransparency = 0
            end
        else
            if Player.Character:FindFirstChild("Highlight") then
                Player.Character.Highlight:Destroy()
            end
        end
    end
    task.wait()
end)
--silent
function getplrsname()
    for i,v in pairs(game:GetChildren()) do
        if v.ClassName == "Players" then
            return v.Name
        end
    end
end
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
    while  wait(1) do
        coroutine.resume(coroutine.create(function()
        if _G.Silent == true then
            for _,v in pairs(game[players]:GetPlayers()) do
                if v.Name ~= plr.Name and v.Character then
                    v.Character.RightUpperLeg.CanCollide = false
                    v.Character.RightUpperLeg.Transparency = 10
                    v.Character.RightUpperLeg.Size = Vector3.new(53,53,53)

                    v.Character.LeftUpperLeg.CanCollide = false
                    v.Character.LeftUpperLeg.Transparency = 10
                    v.Character.LeftUpperLeg.Size = Vector3.new(53,53,53)

                    v.Character.HeadHB.CanCollide = false
                    v.Character.HeadHB.Transparency = 10
                    v.Character.HeadHB.Size = Vector3.new(53,53,53)

                    v.Character.HumanoidRootPart.CanCollide = false
                    v.Character.HumanoidRootPart.Transparency = 10
                    v.Character.HumanoidRootPart.Size = Vector3.new(53,53,53)
                    end
            end
        
    else
        for _,v in pairs(game[players]:GetPlayers()) do
            if v.Name ~= plr.Name and v.Character then
                v.Character.RightUpperLeg.CanCollide = true
                v.Character.RightUpperLeg.Transparency = 10
                v.Character.RightUpperLeg.Size = Vector3.new(1,1,1)

                v.Character.LeftUpperLeg.CanCollide = true
                v.Character.LeftUpperLeg.Transparency = 10
                v.Character.LeftUpperLeg.Size = Vector3.new(1,1,1)

                v.Character.HeadHB.CanCollide = true
                v.Character.HeadHB.Transparency = 10
                v.Character.HeadHB.Size = Vector3.new(1,1,1)

                v.Character.HumanoidRootPart.CanCollide = true
                v.Character.HumanoidRootPart.Transparency = 10
                v.Character.HumanoidRootPart.Size = Vector3.new(1,1,1)
                    end
                end
            end
        end))
    end
end))
--Functionn1
if _G.Jump == true then
    _G.JumpSlieder = not _G.JumpSlieder;
        local Humanoid = game:GetService("Players").LocalPlayer.Character.Humanoid;
        Humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        Humanoid.JumpPower = _G.JumpSlieder
        end)
        Humanoid.JumpPower = _G.JumpSlieder
    else
        Humanoid.JumpPower = 34
        task.wait(0.1)
    end
