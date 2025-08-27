-- ===== SUPER FINAL MOBILE FE SCRIPT =====
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local startY = 50
local spacing = 60
local guiOffsetX = -200  -- distance from right edge

-- Texture ID
local textureID = "90712695710629"

-- ===== CREATE BUTTON FUNCTION =====
local function createButton(name, offsetY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,180,0,50)
    btn.Position = UDim2.new(1, guiOffsetX, 0, startY + offsetY)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.BorderSizePixel = 1
    btn.BorderColor3 = Color3.fromRGB(255,255,255)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.TextScaled = true
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = name
    btn.ZIndex = 10
    btn.Parent = ScreenGui
    btn.MouseButton1Click:Connect(callback)
end

-- ===== FE-compatible Skybox =====
local function setSkybox()
    local oldSky = game.Lighting:FindFirstChildOfClass("Sky")
    if oldSky then oldSky:Destroy() end

    local sky = Instance.new("Sky")
    sky.SkyboxBk = "rbxassetid://"..textureID
    sky.SkyboxFt = "rbxassetid://"..textureID
    sky.SkyboxLf = "rbxassetid://"..textureID
    sky.SkyboxRt = "rbxassetid://"..textureID
    sky.SkyboxUp = "rbxassetid://"..textureID
    sky.SkyboxDn = "rbxassetid://"..textureID
    sky.Parent = game.Lighting
end

-- ===== FE-compatible SABOG LAHAT =====
local function sabogLahat()
    for _,v in pairs(Workspace:GetDescendants()) do
        if v:IsA("MeshPart") then
            v.TextureID = "rbxassetid://"..textureID
        elseif v:IsA("Decal") then
            v.Texture = "rbxassetid://"..textureID
        elseif v:IsA("Part") or v:IsA("UnionOperation") then
            local sa = v:FindFirstChildOfClass("SurfaceAppearance")
            if sa then sa.Texture = "rbxassetid://"..textureID end
        end
    end

    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            for _,v in pairs(plr.Character:GetDescendants()) do
                if v:IsA("MeshPart") then
                    v.TextureID = "rbxassetid://"..textureID
                elseif v:IsA("Decal") then
                    v.Texture = "rbxassetid://"..textureID
                elseif v:IsA("Part") or v:IsA("UnionOperation") then
                    local sa = v:FindFirstChildOfClass("SurfaceAppearance")
                    if sa then sa.Texture = "rbxassetid://"..textureID end
                end
            end
        end
    end
end

-- ===== Bring all players near you =====
local function bringAll()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local pos = player.Character.HumanoidRootPart.CFrame
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            plr.Character.HumanoidRootPart.CFrame = pos + Vector3.new(0,0,5)
        end
    end
end

-- ===== CREATE BUTTONS =====
createButton("SABOG LAHAT", 0, sabogLahat)
createButton("SET SKYBOX", spacing, setSkybox)
createButton("BRING ALL", spacing*2, bringAll)