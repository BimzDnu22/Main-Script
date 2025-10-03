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

local function ShowSupportNotif()
    local plr = Players.LocalPlayer
    if not plr then return end
    local CoreGui = game:GetService("CoreGui")

    -- Hapus lama
    if CoreGui:FindFirstChild("BimzNotif") then
        CoreGui.BimzNotif:Destroy()
    end

    local gui = Instance.new("ScreenGui")
    gui.Name = "BimzNotif"
    gui.Parent = CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 120)
    frame.Position = UDim2.new(0.5, -150, 1, 200)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 1
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = gui
    frame.ClipsDescendants = true

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 12)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 10, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = "⚡ Support Bimz Dnu ⚡"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.6, 0, 0, 40)
    button.Position = UDim2.new(0.2, 0, 1, -50)
    button.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
    button.Text = "📋 Copy Link"
    button.TextColor3 = Color3.new(1,1,1)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = frame

    local btncorner = Instance.new("UICorner", button)
    btncorner.CornerRadius = UDim.new(0, 8)

    button.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://github.com/BimzDnu21")
        end
        button.Text = "✅ Copied!"
        task.wait(1.5)
        button.Text = "📋 Copy Link"
    end)

    -- ANIMASI MASUK
    TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -150, 0.5, 0),
        BackgroundTransparency = 0
    }):Play()

    task.delay(5, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -150, 1, 200),
            BackgroundTransparency = 1
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            gui:Destroy()
        end)
    end)
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
    ShowSupportNotif()
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



