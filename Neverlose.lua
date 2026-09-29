-[[
    NEVERLOSE.CC | MM2 Delta Edition
    Key: mrbecon99
]]

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local LocalPlayer       = Players.LocalPlayer
local Camera            = workspace.CurrentCamera

local CORRECT_KEY = "mrbecon99"

local ACCENT     = Color3.fromRGB(0, 180, 255)
local BG_MAIN    = Color3.fromRGB(8, 14, 23)
local BG_HEADER  = Color3.fromRGB(12, 20, 31)
local BG_ELEMENT = Color3.fromRGB(14, 22, 35)
local TEXT_MAIN  = Color3.fromRGB(230, 235, 245)
local TEXT_DIM   = Color3.fromRGB(140, 155, 175)
local GREEN      = Color3.fromRGB(0, 255, 120)
local RED        = Color3.fromRGB(255, 70, 70)
local ORANGE     = Color3.fromRGB(255, 140, 0)

local function addCorner(obj, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 6)
    c.Parent = obj
end

----------------------------------------------------------------
-- ЕДИНЫЙ ScreenGui
----------------------------------------------------------------
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "NeverloseUI"
MainGui.ResetOnSpawn = false
MainGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- KEY SYSTEM
----------------------------------------------------------------
local KeyFrame = Instance.new("Frame", MainGui)
KeyFrame.Name = "KeyFrame"
KeyFrame.Size = UDim2.new(0, 320, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyFrame.BackgroundColor3 = BG_MAIN
KeyFrame.BorderSizePixel = 0
addCorner(KeyFrame, 10)

local KeyHeader = Instance.new("Frame", KeyFrame)
KeyHeader.Size = UDim2.new(1, 0, 0, 40)
KeyHeader.BackgroundColor3 = BG_HEADER
KeyHeader.BorderSizePixel = 0
addCorner(KeyHeader, 10)

local KeyTitle = Instance.new("TextLabel", KeyHeader)
KeyTitle.Size = UDim2.new(1, -20, 1, 0)
KeyTitle.Position = UDim2.new(0, 14, 0, 0)
KeyTitle.Text = "NEVERLOSE.CC | KEY"
KeyTitle.TextColor3 = ACCENT
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 13
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(1, -30, 0, 38)
KeyInput.Position = UDim2.new(0, 15, 0, 60)
KeyInput.BackgroundColor3 = BG_ELEMENT
KeyInput.BorderSizePixel = 0
KeyInput.PlaceholderText = "Enter key..."
KeyInput.Text = ""
KeyInput.TextColor3 = TEXT_MAIN
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
addCorner(KeyInput, 6)

local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(1, -30, 0, 38)
SubmitBtn.Position = UDim2.new(0, 15, 0, 110)
SubmitBtn.BackgroundColor3 = ACCENT
SubmitBtn.BorderSizePixel = 0
SubmitBtn.Text = "SUBMIT"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 12
SubmitBtn.AutoButtonColor = false
addCorner(SubmitBtn, 6)

local StatusLabel = Instance.new("TextLabel", KeyFrame)
StatusLabel.Size = UDim2.new(1, -30, 0, 20)
StatusLabel.Position = UDim2.new(0, 15, 0, 158)
StatusLabel.Text = ""
StatusLabel.TextColor3 = RED
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 10
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.BackgroundTransparency = 1

----------------------------------------------------------------
-- MAIN SCRIPT
----------------------------------------------------------------

