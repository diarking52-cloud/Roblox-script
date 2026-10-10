--[[
    🚀 Universal Script Loader GUI
    Стиль: как у Fluxus / Delta / Codex
    Работает в: любом executor'е
--]]

--// Сервисы
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--// Удаляем старый GUI если есть
pcall(function()
    if CoreGui:FindFirstChild("UniversalLoader") then
        CoreGui.UniversalLoader:Destroy()
    end
end)

--// Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalLoader"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--// Цвета
local Theme = {
    Background = Color3.fromRGB(20, 20, 25),
    Secondary = Color3.fromRGB(28, 28, 35),
    Accent = Color3.fromRGB(88, 101, 242),
    AccentHover = Color3.fromRGB(108, 121, 255),
    Text = Color3.fromRGB(240, 240, 245),
    SubText = Color3.fromRGB(150, 150, 160),
    Success = Color3.fromRGB(87, 242, 135),
    Error = Color3.fromRGB(237, 66, 69),
}

--// Вспомогательная функция создания элементов
local function Create(className, props)
    local obj = Instance.new(className)
    for k, v in pairs(props) do
        if k ~= "Parent" then
            obj[k] = v
        end
    end
    if props.Parent then obj.Parent = props.Parent end
    return obj
end

--// Уголки
local function Corner(parent, radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, radius or 8), Parent = parent})
end

--// Обводка
local function Stroke(parent, color, thickness, transparency)
    return Create("UIStroke", {
        Color = color or Theme.Accent,
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
        Parent = parent
    })
end

--// ============ MAIN FRAME ============
local MainFrame = Create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 520, 0, 380),
    Position = UDim2.new(0.5, -260, 0.5, -190),
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    Active = true,
    Draggable = true,
})
Corner(MainFrame, 14)
Stroke(MainFrame, Theme.Accent, 1.5, 0.4)

--// Градиент сверху
local TopGradient = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 60),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
})
Corner(TopGradient, 14)
Create("Frame", {
    Parent = TopGradient,
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 1, -20),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
})

--// ============ TITLE BAR ============
local Title = Create("TextLabel", {
    Parent = MainFrame,
    Size = UDim2.new(1, -60, 0, 60),
    Position = UDim2.new(0, 20, 0, 0),
    BackgroundTransparency = 1,
    Text = "⚡ Universal Loader",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
})

local Subtitle = Create("TextLabel", {
    Parent = MainFrame,
    Size = UDim2.new(1, -60, 0, 16),
    Position = UDim2.new(0, 20, 0, 32),
    BackgroundTransparency = 1,
    Text = "загружайте скрипты и реквиемы в 1 клик",
    TextColor3 = Theme.SubText,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
})

--// Кнопка закрытия
local CloseBtn = Create("TextButton", {
    Parent = MainFrame,
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(1, -46, 0, 13),
    BackgroundColor3 = Theme.Error,
    Text = "✕",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    BorderSizePixel = 0,
    AutoButtonColor = false,
})
Corner(CloseBtn, 8)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    task.wait(0.2)
    ScreenGui:Destroy()
end)

--// Кнопка свернуть
local MinBtn = Create("TextButton", {
    Parent = MainFrame,
    Size = UDim2.new(0, 34, 0, 34),
    Position = UDim2.new(1, -86, 0, 13),
    BackgroundColor3 = Theme.Secondary,
    Text = "—",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    BorderSizePixel = 0,
    AutoButtonColor = false,
})
Corner(MinBtn, 8)

--// ============ TABS ============
local TabBar = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, -30, 0, 40),
    Position = UDim2.new(0, 15, 0, 70),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
})
Corner(TabBar, 10)

local TabContainer = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, -30, 1, -205),
    Position = UDim2.new(0, 15, 0, 120),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
    ClipsDescendants = true,
})
Corner(TabContainer, 10)

--// Создание вкладок
local Pages = {}
local ActiveTab

local function CreateTab(name, icon)
    local Tab = Create("TextButton", {
        Parent = TabBar,
        Size = UDim2.new(0, 100, 1, -8),
        Position = UDim2.new(0, 4, 0, 4),
        BackgroundColor3 = Theme.Secondary,
        Text = icon .. " " .. name,
        TextColor3 = Theme.SubText,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    })
    Corner(Tab, 8)

    local Page = Create("ScrollingFrame", {
        Parent = TabContainer,
        Size = UDim2.new(1, -20, 1, -20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    })
    local PageLayout = Create("UIListLayout", {
        Parent = Page,
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    Create("UIPadding", {
        Parent = Page,
        PaddingTop = UDim.new(0, 4),
    })

    Pages[name] = {Tab = Tab, Page = Page}

    Tab.MouseButton1Click:Connect(function()
        for n, data in pairs(Pages) do
            TweenService:Create(data.Tab, TweenInfo.new(0.15), {
                BackgroundColor3 = Theme.Secondary,
                TextColor3 = Theme.SubText
            }):Play()
            data.Page.Visible = false
        end
        TweenService:Create(Tab, TweenInfo.new(0.15), {
            BackgroundColor3 = Theme.Accent,
            TextColor3 = Theme.Text
        }):Play()
        Page.Visible = true
        ActiveTab = name
    end)

    return Page
end

--// Позиционирование вкладок
local function LayoutTabs()
    local x = 4
    for _, data in pairs(Pages) do
        data.Tab.Position = UDim2.new(0, x, 0, 4)
        x = x + 104
    end
end

local ScriptsPage = CreateTab("Скрипты", "📜")
local RequiemsPage = CreateTab("Реквиемы", "⚔️")
local SettingsPage = CreateTab("Настройки", "⚙️")
LayoutTabs()

--// Активируем первую вкладку
Pages["Скрипты"].Tab.BackgroundColor3 = Theme.Accent
Pages["Скрипты"].Tab.TextColor3 = Theme.Text
Pages["Реквиемы"].Page.Visible = false
Pages["Настройки"].Page.Visible = false

--// ============ ФУНКЦИЯ ДОБАВЛЕНИЯ СКРИПТА ============
local function AddScriptButton(page, scriptName, scriptUrl, description)
    local Btn = Create("TextButton", {
        Parent = page,
        Size = UDim2.new(1, -8, 0, 60),
        BackgroundColor3 = Theme.Background,
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false,
    })
    Corner(Btn, 8)
    local str = Stroke(Btn, Theme.Accent, 1, 0.7)

    Create("TextLabel", {
        Parent = Btn,
        Size = UDim2.new(1, -20, 0, 22),
        Position = UDim2.new(0, 14, 0, 8),
        BackgroundTransparency = 1,
        Text = scriptName,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local Desc = Create("TextLabel", {
        Parent = Btn,
        Size = UDim2.new(1, -20, 0, 16),
        Position = UDim2.new(0, 14, 0, 30),
        BackgroundTransparency = 1,
        Text = description or "Нажмите чтобы загрузить",
        TextColor3 = Theme.SubText,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local Status = Create("TextLabel", {
        Parent = Btn,
        Size = UDim2.new(0, 60, 0, 18),
        Position = UDim2.new(1, -74, 0, 20),
        BackgroundTransparency = 1,
        Text = "LOAD",
        TextColor3 = Theme.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Right,
    })

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Secondary}):Play()
        str.Color = Theme.AccentHover
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Background}):Play()
        str.Color = Theme.Accent
    end)

    Btn.MouseButton1Click:Connect(function()
        Status.Text = "LOADING..."
        Status.TextColor3 = Theme.Accent

        task.spawn(function()
            local success, err = pcall(function()
                local code = game:HttpGet(scriptUrl)
                local func = loadstring(code)
                if func then func() end
            end)

            if success then
                Status.Text = "✓ DONE"
                Status.TextColor3 = Theme.Success
                Desc.Text = "Успешно загружено!"
            else
                Status.Text = "✕ FAIL"
                Status.TextColor3 = Theme.Error
                Desc.Text = "Ошибка: " .. tostring(err):sub(1, 40)
            end

            task.wait(2)
            Status.Text = "LOAD"
            Status.TextColor3 = Theme.Accent
        end)
    end)

    return Btn
end

--// ============ ДОБАВЛЯЕМ СКРИПТЫ ============
-- Замени ссылки на свои!
AddScriptButton(ScriptsPage, "Infinite Yield", 
    "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    "Мощный админ-скрипт с 200+ командами")

AddScriptButton(ScriptsPage, "Dark Dex", 
    "https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/Dex.lua",
    "Проводник и редактор игры")

AddScriptButton(ScriptsPage, "Owl Hub", 
    "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt",
    "Многофункциональный хаб")

AddScriptButton(ScriptsPage, "Rayfield UI Library", 
    "https://raw.githubusercontent.com/shlexsoftworks/Rayfield/main/source.lua",
    "Библиотека красивого UI")

--// Реквиемы
AddScriptButton(RequiemsPage, "YBA Requiem", 
    "https://raw.githubusercontent.com/YourUser/YBARequiem/main/main.lua",
    "Реквием для Your Bizarre Adventure")

AddScriptButton(RequiemsPage, "Anime Fighting Sim Requiem", 
    "https://raw.githubusercontent.com/YourUser/AFSRequiem/main/main.lua",
    "Реквием для Anime Fighting Simulator")

AddScriptButton(RequiemsPage, "Сustom Requiem", 
    "https://raw.githubusercontent.com/YourUser/CustomRequiem/main/main.lua",
    "Ваш кастомный реквием")

--// ============ ПОЛЕ ВВОДА URL ============
local InputFrame = Create("Frame", {
    Parent = MainFrame,
    Size = UDim2.new(1, -30, 0, 44),
    Position = UDim2.new(0, 15, 1, -56),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
})
Corner(InputFrame, 10)

local UrlBox = Create("TextBox", {
    Parent = InputFrame,
    Size = UDim2.new(1, -120, 1, -12),
    Position = UDim2.new(0, 6, 0, 6),
    BackgroundColor3 = Theme.Background,
    Text = "",
    PlaceholderText = "Вставьте ссылку на скрипт...",
    TextColor3 = Theme.Text,
    PlaceholderColor3 = Theme.SubText,
    Font = Enum.Font.Gotham,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left,
    BorderSizePixel = 0,
    ClearTextOnFocus = false,
})
Corner(UrlBox, 6)
Create("UIPadding", {
    Parent = UrlBox,
    PaddingLeft = UDim.new(0, 10),
})

local ExecBtn = Create("TextButton", {
    Parent = InputFrame,
    Size = UDim2.new(0, 100, 1, -12),
    Position = UDim2.new(1, -106, 0, 6),
    BackgroundColor3 = Theme.Accent,
    Text = "EXECUTE",
    TextColor3 = Theme.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    BorderSizePixel = 0,
    AutoButtonColor = false,
})
Corner(ExecBtn, 6)

ExecBtn.MouseEnter:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.AccentHover}):Play()
end)
ExecBtn.MouseLeave:Connect(function()
    TweenService:Create(ExecBtn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Accent}):Play()
end)

ExecBtn.MouseButton1Click:Connect(function()
    local url = UrlBox.Text
    if url == "" then return end

    ExecBtn.Text = "..."
    task.spawn(function()
        local success, err = pcall(function()
            local code = game:HttpGet(url)
            local func = loadstring(code)
            if func then func() end
        end)

        ExecBtn.Text = success and "✓ OK" or "✕ FAIL"
        task.wait(1.5)
        ExecBtn.Text = "EXECUTE"
        if success then UrlBox.Text = "" end
    end)
end)

--// ============ НАСТРОЙКИ ============
local function AddToggle(page, name, default, callback)
    local ToggleFrame = Create("Frame", {
        Parent = page,
        Size = UDim2.new(1, -8, 0, 44),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
    })
    Corner(ToggleFrame, 8)

    Create("TextLabel", {
        Parent = ToggleFrame,
        Size = UDim2.new(0.6, 0, 1, 0),
        Position = UDim2.new(0, 14, 0, 0),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Theme.Text,
        Font = Enum.Font.GothamMedium,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local state = default
    local ToggleBtn = Create("Frame", {
        Parent = ToggleFrame,
        Size = UDim2.new(0, 44, 0, 22),
        Position = UDim2.new(1, -58, 0.5, -11),
        BackgroundColor3 = state and Theme.Accent or Theme.Secondary,
        BorderSizePixel = 0,
    })
    Corner(ToggleBtn, 11)

    local Knob = Create("Frame", {
        Parent = ToggleBtn,
        Size = UDim2.new(0, 16, 0, 16),
        Position = state and UDim2.new(1, -19, 0, 3) or UDim2.new(0, 3, 0, 3),
        BackgroundColor3 = Theme.Text,
        BorderSizePixel = 0,
    })
    Corner(Knob, 8)

    local Click = Create("TextButton", {
        Parent = ToggleFrame,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "",
    })

    Click.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(ToggleBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = state and Theme.Accent or Theme.Secondary
        }):Play()
        TweenService:Create(Knob, TweenInfo.new(0.15), {
            Position = state and UDim2.new(1, -19, 0, 3) or UDim2.new(0, 3, 0, 3)
        }):Play()
        if callback then callback(state) end
    end)
end

AddToggle(SettingsPage, "🌙 Тёмная тема", true, function(v) end)
AddToggle(SettingsPage, "🔔 Уведомления", true, function(v) end)
AddToggle(SettingsPage, "🎯 Авто-инжект при смерти", false, function(v) end)
AddToggle(SettingsPage, "🛡️ Анти-кик защита", true, function(v) end)

--// ============ АНИМАЦИЯ ПОЯВЛЕНИЯ ============
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 520, 0, 380),
    Position = UDim2.new(0.5, -260, 0.5, -190)
}):Play()

--// Уведомление
local Notif = Create("Frame", {
    Parent = ScreenGui,
    Size = UDim2.new(0, 280, 0, 60),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
})
Corner(Notif, 10)
Stroke(Notif, Theme.Success, 1, 0.3)

Create("TextLabel", {
    Parent = Notif,
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 14, 0, 8),
    BackgroundTransparency = 1,
    Text = "✓ Loader загружен!",
    TextColor3 = Theme.Success,
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
})

Create("TextLabel", {
    Parent = Notif,
    Size = UDim2.new(1, -20, 0, 16),
    Position = UDim2.new(0, 14, 0, 30),
    BackgroundTransparency = 1,
    Text = "Выберите скрипт из списка",
    TextColor3 = Theme.SubText,
    Font = Enum.Font.Gotham,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left,
})

task.delay(4, function()
    TweenService:Create(Notif, TweenInfo.new(0.3), {
        Position = UDim2.new(0, -300, 0, 20)
    }):Play()
    task.wait(0.3)
    Notif:Destroy()
end)

print("[Universal Loader] Загружен успешно!")
