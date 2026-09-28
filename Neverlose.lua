-[[
    NEVERLOSE.CC UI & Visuals for Roblox MM2
    Key: mrbecon99
    Get Key: https://linkvertise.com/ТВОЙ_ID/mm2-neverlose-key
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Stats             = game:GetService("Stats")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local CORRECT_KEY = "mrbecon99"
local KEY_LINK    = "https://linkvertise.com/ТВОЙ_ID/mm2-neverlose-key" -- ЗАМЕНИ НА СВОЮ ССЫЛКУ

----------------------------------------------------------------
-- KEY SYSTEM GUI
----------------------------------------------------------------
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "NeverloseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local KeyFrame = Instance.new("Frame", KeyGui)
KeyFrame.Size = UDim2.new(0, 360, 0, 230)
KeyFrame.Position = UDim2.new(0.5, -180, 0.5, -115)
KeyFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 23)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 35)
KeyHeader.BackgroundColor3 = Color3.fromRGB(12, 20, 31)
KeyHeader.BorderSizePixel = 0

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 10, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC | KEY SYSTEM"
KeyTitle.TextColor3 = Color3.fromRGB(0, 180, 255)
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeySubTitle = Instance.new("TextLabel", KeyFrame)
KeySubTitle.Size = UDim2.new(1, -20, 0, 25)
KeySubTitle.Position = UDim2.new(0, 10, 0, 40)
KeySubTitle.Text = "Get key from Linkvertise, then enter below:"
KeySubTitle.TextColor3 = Color3.fromRGB(180, 190, 200)
KeySubTitle.Font = Enum.Font.Gotham
KeySubTitle.TextSize = 11
KeySubTitle.TextXAlignment = Enum.TextXAlignment.Left
KeySubTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -20, 0, 35)
KeyInput.Position = UDim2.new(0, 10, 0, 70)
KeyInput.BackgroundColor3 = Color3.fromRGB(14, 22, 35)
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text 
