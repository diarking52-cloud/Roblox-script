-[[
    NEVERLOSE.CC UI & Visuals for Roblox MM2
    Key: mrbecon99
    Mobile-friendly (Delta / Codex / Arceus X / Wave / Volt)
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local Stats             = game:GetService("Stats")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local CORRECT_KEY = "mrbecon99"

local ACCENT       = Color3.fromRGB(0, 180, 255)
local ACCENT_DARK  = Color3.fromRGB(0, 120, 200)
local BG_MAIN      = Color3.fromRGB(8, 14, 23)
local BG_HEADER    = Color3.fromRGB(12, 20, 31)
local BG_ELEMENT   = Color3.fromRGB(14, 22, 35)
local BG_HOVER     = Color3.fromRGB(20, 32, 48)
local TEXT_MAIN    = Color3.fromRGB(230, 235, 245)
local TEXT_DIM     = Color3.fromRGB(140, 155, 175)
local GREEN        = Color3.fromRGB(0, 255, 120)
local RED          = Color3.fromRGB(255, 70, 70)

local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
    return c
end

local function addStroke(obj, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or ACCENT
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.5
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = obj
    return s
end

local function addGradient(obj, c1, c2, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rotation or 90
    g.Parent = obj
    return g
end

----------------------------------------------------------------
-- KEY SYSTEM (мгновенная загрузка)
----------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 340, 0, 210)
KeyFrame.Position = UDim2.new(0.5, -170, 0.5, -105)
KeyFrame.BackgroundColor3 = BG_MAIN
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
addCorner(KeyFrame, 10)
addStroke(KeyFrame, ACCENT_DARK, 1, 0.4)
addGradient(KeyFrame, Color3.fromRGB(10, 16, 28), Color3.fromRGB(6, 10, 18), 90)

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 42)
KeyHeader.BackgroundColor3 = BG_HEADER
KeyHeader.BorderSizePixel = 0
addGradient(KeyHeader, Color3.fromRGB(16, 26, 42), Color3.fromRGB(10, 16, 26), 90)

local KeyAccentLine = Instance.new("Frame", KeyHeader)
KeyAccentLine.Size = UDim2.new(1, 0, 0, 2)
KeyAccentLine.Position = UDim2.new(0, 0, 1, -2)
KeyAccentLine.BackgroundColor3 = ACCENT
KeyAccentLine.BorderSizePixel = 0

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC  |  KEY SYSTEM"
KeyTitle.TextColor3 = ACCENT
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeySubTitle = Instance.new("TextLabel", KeyFrame)
KeySubTitle.Size = UDim2.new(1, -30, 0, 22)
KeySubTitle.Position = UDim2.new(0, 15, 0, 54)
KeySubTitle.Text = "Enter your key below:"
KeySubTitle.TextColor3 = TEXT_DIM
KeySubTitle.Font = Enum.Font.Gotham
KeySubTitle.TextSize = 11
KeySubTitle.TextXAlignment = Enum.TextXAlignment.Left
KeySubTitle.BackgroundTransparency = 1
 
