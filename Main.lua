-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Check if User is bonki042
local isAdmin = LocalPlayer.Name == "bonki042"
local logs = {} -- Store execution logs for admin

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxstrapX"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Floating Toggle Button (Mobile-Friendly)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0.95, -70, 0.5, -30)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Image = "rbxassetid://14298792530" -- Bloxstrap logo as clickable square
ToggleBtn.Parent = ScreenGui
ToggleBtn.ZIndex = 10

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 350, 0, 450)
Frame.Position = UDim2.new(0.5, -175, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = true
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false -- Hidden by default
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Color = Color3.fromRGB(0, 120, 215)
Stroke.Parent = Frame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 1, 0)
Title.Position = UDim2.new(0.12, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Bloxstrap X"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.Parent = TitleBar

-- Logo Button in Title Bar (Clickable)
local LogoBtn = Instance.new("ImageButton")
LogoBtn.Size = UDim2.new(0, 32, 0, 32)
LogoBtn.Position = UDim2.new(0.02, 0, 0, 4)
LogoBtn.BackgroundTransparency = 1
LogoBtn.Image = "rbxassetid://14298792530"
LogoBtn.Parent = TitleBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(0.92, 0, 0, 5)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 20
MinimizeBtn.Parent = TitleBar

-- Tab System
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, 0, 0, 40)
TabBar.Position = UDim2.new(0, 0, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TabBar.BorderSizePixel = 0
TabBar.Parent = Frame

local TabLayout = Instance.new("UIListLayout")
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0, 5)
TabLayout.Parent = TabBar

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -80)
ContentFrame.Position = UDim2.new(0, 0, 0, 80)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ClipsDescendants = true
ContentFrame.Parent = Frame

-- Tab Creation Function
local function createTab(name)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(0.25 if isAdmin else 0.33, -5, 1, 0)
    TabBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.TextSize = 16
    TabBtn.Parent = TabBar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 5)
    TabCorner.Parent = TabBtn

    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, 0, 1, 0)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = ContentFrame

    TabBtn.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            child.Visible = (child == TabContent)
        end
        for _, btn in pairs(TabBar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.TextColor3 = btn == TabBtn and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
            end
        end
    end)
    return TabContent
end

-- Script Tab
local ScriptTab = createTab("Scripts")
TabBar:GetChildren()[1].TextColor3 = Color3.fromRGB(255, 255, 255)

local ScriptBox = Instance.new("TextBox")
ScriptBox.Size = UDim2.new(0.9, 0, 0.5, 0)
ScriptBox.Position = UDim2.new(0.05, 0, 0.05, 0)
ScriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ScriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptBox.PlaceholderText = "Enter your Lua script..."
ScriptBox.Text = ""
ScriptBox.MultiLine = true
ScriptBox.TextWrapped = true
ScriptBox.Font = Enum.Font.SourceSans
ScriptBox.TextSize = 14
ScriptBox.Parent = ScriptTab

local ScriptStroke = Instance.new("UIStroke")
ScriptStroke.Thickness = 1
ScriptStroke.Color = Color3.fromRGB(0, 120, 215)
ScriptStroke.Parent = ScriptBox

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Size = UDim2.new(0.42, 0, 0.12, 0)
ExecuteBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
ExecuteBtn.Text = "Execute"
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextSize = 18
ExecuteBtn.Parent = ScriptTab

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 5)
ExecuteCorner.Parent = ExecuteBtn

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.42, 0, 0.12, 0)
ClearBtn.Position = UDim2.new(0.53, 0, 0.6, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ClearBtn.Text = "Clear"
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextSize = 18
ClearBtn.Parent = ScriptTab

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 5)
ClearCorner.Parent = ClearBtn

-- Mods Tab
local ModsTab = createTab("Mods")
local ModsList = Instance.new("ScrollingFrame")
ModsList.Size = UDim2.new(0.9, 0, 0.9, 0)
ModsList.Position = UDim2.new(0.05, 0, 0.05, 0)
ModsList.BackgroundTransparency = 1
ModsList.CanvasSize = UDim2.new(0, 0, 1.5, 0)
ModsList.ScrollBarThickness = 4
ModsList.Parent = ModsTab

local ModsLayout = Instance.new("UIListLayout")
ModsLayout.Padding = UDim.new(0, 10)
ModsLayout.Parent = ModsList

-- Mod Toggle Function
local function createMod(name, callback)
    local ModFrame = Instance.new("Frame")
    ModFrame.Size = UDim2.new(1, 0, 0, 40)
    ModFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    ModFrame.Parent = ModsList

    local ModCorner = Instance.new("UICorner")
    ModCorner.CornerRadius = UDim.new(0, 5)
    ModCorner.Parent = ModFrame

    local ModLabel = Instance.new("TextLabel")
    ModLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ModLabel.BackgroundTransparency = 1
    ModLabel.Text = name
    ModLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ModLabel.Font = Enum.Font.Gotham
    ModLabel.TextSize = 16
    ModLabel.Position = UDim2.new(0.05, 0, 0, 0)
    ModLabel.Parent = ModFrame

    local ModToggle = Instance.new("TextButton")
    ModToggle.Size = UDim2.new(0.25, 0, 0.7, 0)
    ModToggle.Position = UDim2.new(0.7, 0, 0.15, 0)
    ModToggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    ModToggle.Text = "OFF"
    ModToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    ModToggle.Font = Enum.Font.Gotham
    ModToggle.TextSize = 14
    ModToggle.Parent = ModFrame

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 5)
    ToggleCorner.Parent = ModToggle

    local enabled = false
    ModToggle.MouseButton1Click:Connect(function()
        enabled = not enabled
        ModToggle.Text = enabled and "ON" or "OFF"
        ModToggle.BackgroundColor3 = enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        callback(enabled)
        if isAdmin then
            table.insert(logs, {type = "mod", name = name, state = enabled, time = os.time()})
        end
    end)
end

-- Mods Implementation
local mods = {speed = false, fly = false, esp = false, noclip = false, jump = false, teleport = false}

createMod("Speed Hack", function(enabled)
    mods.speed = enabled
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then humanoid.WalkSpeed = enabled and 50 or 16 end
end)

local flyConnection
createMod("Fly", function(enabled)
    mods.fly = enabled
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if enabled and root then
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        flyConnection = RunService.RenderStepped:Connect(function()
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            bv.Velocity = moveDir * 50
        end)
    elseif not enabled and root then
        if flyConnection then flyConnection:Disconnect() end
        local bv = root:FindFirstChildOfClass("BodyVelocity")
        if bv then bv:Destroy() end
    end
end)

createMod("ESP", function(enabled)
    mods.esp = enabled
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

local noclipConnection
createMod("Noclip", function(enabled)
    mods.noclip = enabled
    if enabled then
        noclipConnection = RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if noclipConnection then noclipConnection:Disconnect() end
    end
end)

createMod("Infinite Jump", function(enabled)
    mods.jump = enabled
end)

UserInputService.JumpRequest:Connect(function()
    if mods.jump then
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

createMod("Teleport to Touch", function(enabled)
    mods.teleport = enabled
    if enabled then
        UserInputService.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) and mods.teleport then
                local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = CFrame.new(input.Position.X, input.Position.Y, root.Position.Z) + Vector3.new(0, 5, 0)
                end
            end
        end)
    end
end)

-- Settings Tab
local SettingsTab = createTab("Settings")
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(0.9, 0, 0, 30)
InfoLabel.Position = UDim2.new(0.05, 0, 0.05, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Toggle UI: Tap Logo (Mobile) or RightShift (PC)"
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextSize = 14
InfoLabel.TextWrapped = true
InfoLabel.Parent = SettingsTab

-- Admin Tab (bonki042 Only)
if isAdmin then
    local AdminTab = createTab("Admin")
    local AdminList = Instance.new("ScrollingFrame")
    AdminList.Size = UDim2.new(0.9, 0, 0.9, 0)
    AdminList.Position = UDim2.new(0.05, 0, 0.05, 0)
    AdminList.BackgroundTransparency = 1
    AdminList.CanvasSize = UDim2.new(0, 0, 0, 0)
    AdminList.ScrollBarThickness = 4
    AdminList.Parent = AdminTab

    local AdminLayout = Instance.new("UIListLayout")
    AdminLayout.Padding = UDim.new(0, 5)
    AdminLayout.Parent = AdminList

    local function updateAdminLogs()
        for _, child in pairs(AdminList:GetChildren()) do
            if child:IsA("TextLabel") then child:Destroy() end
        end
        for i, log in pairs(logs) do
            local LogEntry = Instance.new("TextLabel")
            LogEntry.Size = UDim2.new(1, 0, 0, 30)
            LogEntry.BackgroundTransparency = 1
            LogEntry.Text = log.type == "script" and
                `[Script] Ran at {os.date("%H:%M:%S", log.time)}: {log.script}` or
                `[Mod] {log.name} turned {log.state and "ON" or "OFF"} at {os.date("%H:%M:%S", log.time)}`
            LogEntry.TextColor3 = Color3.fromRGB(255, 255, 255)
            LogEntry.Font = Enum.Font.SourceSans
            LogEntry.TextSize = 14
            LogEntry.TextWrapped = true
            LogEntry.Parent = AdminList
            AdminList.CanvasSize = UDim2.new(0, 0, 0, AdminLayout.AbsoluteContentSize.Y)
        end
    end

    local StatsLabel = Instance.new("TextLabel")
    StatsLabel.Size = UDim2.new(0.9, 0, 0, 30)
    StatsLabel.Position = UDim2.new(0.05, 0, 0, 0)
    StatsLabel.BackgroundTransparency = 1
    StatsLabel.Text = "Logistics: Tracking scripts and mods..."
    StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    StatsLabel.Font = Enum.Font.GothamBold
    StatsLabel.TextSize = 16
    StatsLabel.Parent = AdminTab
end

-- Functionality
ExecuteBtn.MouseButton1Click:Connect(function()
    local script = ScriptBox.Text
    print("Executing: " .. script) -- Replace with your exploit's API (e.g., loadstring(script)())
    if isAdmin then
        table.insert(logs, {type = "script", script = script, time = os.time()})
        updateAdminLogs()
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    ScriptBox.Text = ""
end)

MinimizeBtn.MouseButton1Click:Connect(function()
    local isMinimized = Frame.Size.Y.Offset == 40
    TweenService:Create(Frame, TweenInfo.new(0.3), {
        Size = isMinimized and UDim2.new(0, 350, 0, 450) or UDim2.new(0, 350, 0, 40)
    }):Play()
    ContentFrame.Visible = isMinimized
    TabBar.Visible = isMinimized
end)

ToggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

LogoBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Keybind Toggle (PC Users)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        Frame.Visible = not Frame.Visible
    end
end)

-- Hover Effects
local function addHover(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = btn.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.1)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = btn.BackgroundColor3:Lerp(Color3.fromRGB(0, 0, 0), 0.1)
        }):Play()
    end)
end

addHover(ExecuteBtn)
addHover(ClearBtn)
for _, btn in pairs(TabBar:GetChildren()) do
    if btn:IsA("TextButton") then addHover(btn) end
end

-- Fade-In Animation
Frame.BackgroundTransparency = 1
Stroke.Transparency = 1
for _, child in pairs(Frame:GetDescendants()) do
    if child:IsA("GuiObject") then
        child.BackgroundTransparency = 1
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            child.TextTransparency = 1
        end
    end
end

TweenService:Create(Frame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
TweenService:Create(Stroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
for _, child in pairs(Frame:GetDescendants()) do
    if child:IsA("GuiObject") then
        local props = {BackgroundTransparency = child.BackgroundTransparency == 1 and 1 or 0}
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            props.TextTransparency = 0
        end
        TweenService:Create(child, TweenInfo.new(0.5), props):Play()
    end
end

-- Welcome Message
print("Bloxstrap X Loaded! Tap the logo (mobile) or press RightShift (PC) to toggle.")
