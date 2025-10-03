local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local PlaceScripts = {
    [73347831908825]  = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hell-Expedition.lua",
    [135406051460913] = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Run-Hide-By-Bimz.lua",
    [9872472334]      = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Evade.lua",
    [10118559731]     = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Evade.lua",
    [121864768012064] = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Fist-It.lua",
}

local TargetExecutorLower = "xeno"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local function ShowBimzHubNotif()
    local plr = Players.LocalPlayer
    if not plr then return end
    local CoreGui = game:GetService("CoreGui")

    if CoreGui:FindFirstChild("BimzHubNotif") then
        CoreGui.BimzHubNotif:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "BimzHubNotif"
    gui.Parent = CoreGui
    gui.ResetOnSpawn = false

    -- Frame utama
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 220)
    frame.Position = UDim2.new(0.5, -210, 1, 300)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30) -- mirip background discord pop up
    frame.BackgroundTransparency = 0.7
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = gui
    frame.ClipsDescendants = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "Join Our Community"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -20, 0, 20)
    subtitle.Position = UDim2.new(0, 10, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Join Discord For More Update!"
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 200)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Left
    subtitle.Parent = frame

    -- Deskripsi
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(1, -40, 0, 80)
    desc.Position = UDim2.new(0, 20, 0, 80)
    desc.BackgroundTransparency = 1
    desc.TextWrapped = true
    desc.Text = "Get access to new updates, events,\ngiveaways, and chat with other players in our official Discord server."
    desc.TextColor3 = Color3.fromRGB(220, 220, 220)
    desc.TextScaled = true
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.Parent = frame

    -- Tombol biru
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 50)
    button.Position = UDim2.new(0.1, 0, 1, -70)
    button.BackgroundColor3 = Color3.fromRGB(90, 110, 255) -- warna mirip discord button
    button.Text = "Copy Invite & Join"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = frame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

    button.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/YourInviteCodeHere")
        end
        button.Text = "✅ Copied!"
        task.wait(1.5)
        button.Text = "Copy Invite & Join"
    end)

    -- animasi masuk
    TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -210, 0.5, 0),
        BackgroundTransparency = 0
    }):Play()
end

local function tryCall(fn)
    local ok, res = pcall(fn)
    if ok then return res end
    return nil
end

local function detectExecutorName()
    local idRes = tryCall(function()
        if identifyexecutor then return identifyexecutor() end
    end)
    if idRes then
        if type(idRes) == "string" then
            return idRes
        elseif type(idRes) == "table" and idRes[1] then
            return tostring(idRes[1])
        end
    end

    local getRes = tryCall(function()
        if getexecutorname then return getexecutorname() end
    end)
    if getRes and type(getRes) == "string" then
        return getRes
    end

    return "Unknown"
end

local function isXeno(execName)
    if not execName or execName == "" then return false end
    local lower = tostring(execName):lower()
    return lower:find(TargetExecutorLower, 1, true) ~= nil
end

local currentExecutor = detectExecutorName() or "Unknown"
if isXeno(currentExecutor) then
    local kickMsg = ("Executor '%s' (Xeno) is not supported."):format(tostring(currentExecutor))
    warn("❌ " .. kickMsg)
    if Players.LocalPlayer then
        Players.LocalPlayer:Kick("Xeno Executor is not supported (TROJAN DETEC).")
    end
    return
else
    print("✅ Safe executor detected: " .. tostring(currentExecutor))
    ShowBimzHubNotif()
end

local placeId = game.PlaceId
local url = PlaceScripts[placeId]

if not url then
    warn(("❌ PlaceId %s is not whitelisted"):format(tostring(placeId)))
    if Players.LocalPlayer then
        Players.LocalPlayer:Kick("PlaceId " .. tostring(placeId) .. " is not whitelisted.")
    end
    return
end

local ok, err = pcall(function()
    local got, content = pcall(function() return game:HttpGet(url) end)
    if not (got and type(content) == "string") then
        error("Failed to download remote script: " .. tostring(content))
    end

    local func
    if loadstring then
        func = loadstring(content)
    else
        local okLoad, loaded = pcall(function() return load(content) end)
        if okLoad and type(loaded) == "function" then
            func = loaded
        end
    end

    if not func then error("loadstring/load returned nil") end
    func()
end)

if ok then
    print("✅ Remote script loaded and executed successfully.")
else
    warn("❌ Failed to load/execute remote script: " .. tostring(err))
end




