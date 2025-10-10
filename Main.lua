local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

-- ===== Place Script Mapping =====
local PlaceScripts = {
    ["73347831908825"]  = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hell-Expedition.lua",
    ["135406051460913"] = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Run-Hide-By-Bimz.lua",
    ["9872472334"]      = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Evade.lua",
    ["10118559731"]     = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Evade.lua",
    ["121864768012064"] = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Fist-It.lua",
    ["18519254033"]     = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hit-Box.lua",
    ["15269951959"]     = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hit-Box.lua",
    ["10449761463"]     = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hit-Box.lua",
    ["4282985734"]      = "https://raw.githubusercontent.com/BimzDnu22/Main-Script/refs/heads/main/Script/Hit-Box.lua",
}

local SERVICE_ID = "1451"
local TargetExecutorLower = "xeno"

-- ===== Utilities =====
local function tryCall(fn)
    local ok, res = pcall(fn)
    return ok and res or nil
end

local function detectExecutorName()
    local name = tryCall(function() if identifyexecutor then return identifyexecutor() end end)
    if type(name) == "string" then return name end
    if type(name) == "table" and name[1] then return tostring(name[1]) end
    name = tryCall(function() if getexecutorname then return getexecutorname() end end)
    return type(name) == "string" and name or "Unknown"
end

local function isXeno(execName)
    return tostring(execName):lower():find(TargetExecutorLower, 1, true) ~= nil
end

-- ===== UI =====
local function ShowBimzHubNotif()
    local plr = Players.LocalPlayer
    if not plr then return end
    local CoreGui = game:GetService("CoreGui")
    if CoreGui:FindFirstChild("BimzHubNotif") then CoreGui.BimzHubNotif:Destroy() end

    local gui = Instance.new("ScreenGui", CoreGui)
    gui.Name = "BimzHubNotif"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 250)
    frame.Position = UDim2.new(0.5, -210, 1, 300)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    frame.BackgroundTransparency = 0.7
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

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

    -- 🔹 Copy Invite Button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 45)
    button.Position = UDim2.new(0.1, 0, 1, -100)
    button.BackgroundColor3 = Color3.fromRGB(90, 110, 255)
    button.Text = "Copy Discord Invite"
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextScaled = true
    button.Parent = frame
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

    button.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard("https://discord.gg/qBEHCRtEQV") end
        button.Text = "✅ Copied!"
        task.wait(1.5)
        button.Text = "Copy Discord Invite"
    end)

    -- 🔹 Get Key Button (AuthGuard)
    local keyBtn = Instance.new("TextButton")
    keyBtn.Size = UDim2.new(0.8, 0, 0, 45)
    keyBtn.Position = UDim2.new(0.1, 0, 1, -50)
    keyBtn.BackgroundColor3 = Color3.fromRGB(70, 200, 120)
    keyBtn.Text = "🔑 Get Key"
    keyBtn.TextColor3 = Color3.new(1, 1, 1)
    keyBtn.Font = Enum.Font.GothamBold
    keyBtn.TextScaled = true
    keyBtn.Parent = frame
    Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 8)

    keyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://authguard.org/a/1451")
            keyBtn.Text = "✅ Link Copied!"
        end
        if request or syn and syn.request then
            local req = request or syn.request
            pcall(function() req({ Url = "https://authguard.org/a/1451" }) end)
        end
        task.wait(1.5)
        keyBtn.Text = "🔑 Get Key"
    end)

    TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -210, 0.5, 0),
        BackgroundTransparency = 0
    }):Play()

    task.delay(5, function()
        local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -150, 1, 200),
            BackgroundTransparency = 1
        })
        tweenOut:Play()
        tweenOut.Completed:Connect(function() gui:Destroy() end)
    end)
end

-- ===== Main Logic (improved validation) =====
local currentExecutor = detectExecutorName()
if isXeno(currentExecutor) then
    warn("❌ Executor '" .. tostring(currentExecutor) .. "' is not supported (XENO DETECTED).")
    Players.LocalPlayer:Kick("Xeno Executor is not supported (TROJAN DETECTED).")
    return
else
    print("✅ Safe executor detected:", currentExecutor)
end

-- Wait for AuthGuard global to be present (but with safety timeout)
local waitStart = tick()
local AUTH_WAIT_TIMEOUT = 6 -- seconds
while (type(_G) ~= "table" or not _G.AuthGuard) and (type(AuthGuard) == "nil") and tick() - waitStart < AUTH_WAIT_TIMEOUT do
    task.wait(0.1)
end

local AuthGuard = (_G and _G.AuthGuard) or AuthGuard
if not AuthGuard then
    warn("⚠️ AuthGuard API not found. Aborting loader.")
    --pcall(function() Players.LocalPlayer:Kick("AuthGuard API not found. Aborting loader.") end)
    return
end

-- Ensure ValidateKey is a function
if type(AuthGuard.ValidateKey) ~= "function" then
    warn("⚠️ AuthGuard.ValidateKey is missing or tampered.")
    --pcall(function() Players.LocalPlayer:Kick("AuthGuard API invalid. Aborting loader.") end)
    return
end

-- Get USER_KEY from getgenv
local USER_KEY = tostring(getgenv().USER_KEY or "")
if USER_KEY == "" then
    warn("❌ No USER_KEY provided. Aborting loader.")
    pcall(function() Players.LocalPlayer:Kick("No USER_KEY provided. Aborting loader.") end)
    return
end
--print("🔍 Using Key:", USER_KEY)

-- Helper: strict validator
local function isValidAuthResponse(res)
    -- Reject plain boolean true/false as insufficient evidence
    if type(res) == "boolean" then
        return false
    end

    if type(res) == "number" then
        -- some APIs return 1 on success
        return tonumber(res) == 1
    end

    if type(res) == "string" then
        local s = res:lower():gsub("%s+", "")
        -- accept only exact tokens
        if s == "valid" or s == "validated" then
            return true
        end
        -- do not accept strings that merely contain 'valid' to avoid accidental matches
        return false
    end

    if type(res) == "table" then
        -- Common expected fields: status, valid, success, code
        local status = res.status or res.Status or res.state
        local validFlag = res.valid or res.Valid
        local successFlag = res.success or res.Success
        local code = res.code or res.Code or res.statusCode

        if type(status) == "string" then
            local st = tostring(status):lower()
            if st == "valid" or st == "validated" then
                return true
            end
        end

        if type(validFlag) == "boolean" and validFlag == true then
            return true
        end

        if type(successFlag) == "boolean" and successFlag == true then
            return true
        end

        if type(code) == "number" and tonumber(code) == 1 then
            return true
        end
        -- fallback: not valid
        return false
    end

    -- other types: reject
    return false
end

-- Try to fetch key link if available (best-effort, protected)
pcall(function()
    if AuthGuard.GetKeyLink and type(AuthGuard.GetKeyLink) == "function" then
        local ok, link = pcall(function() return AuthGuard.GetKeyLink({ Service = SERVICE_ID }) end)
        if ok and type(link) == "string" and #link > 5 then
            print("🔗 Get your key at:", link)
        end
    end
end)

-- Call ValidateKey with strict handling
local ok, res = pcall(function()
    -- Prefer structured call with table if supported
    local status, result = pcall(function()
        return AuthGuard.ValidateKey({ Service = SERVICE_ID, Key = USER_KEY })
    end)
    if status then
        return result
    end
    -- fallback: try calling with raw key
    local ok2, res2 = pcall(function() return AuthGuard.ValidateKey(USER_KEY) end)
    if ok2 then return res2 end
    -- if both fail, propagate original error (so outer pcall will catch)
    error("ValidateKey calls failed")
end)

if not ok then
    warn("⚠️ AuthGuard ValidateKey call failed:", tostring(res))
    --pcall(function() Players.LocalPlayer:Kick("AuthGuard validation error.") end)
    return
end

-- Strict interpretation
local valid = isValidAuthResponse(res)
-- debug print of raw response type/value for troubleshooting (non-sensitive)
--print(("🔎 AuthGuard raw result: type=%s value=%s"):format(typeof(res), tostring(res)))

if not valid then
    warn("⚠️ AuthGuard verification failed. Response did not meet strict criteria.")
    pcall(function()
        Players.LocalPlayer:Kick("Invalid or expired key detected.")
    end)
    return
end

-- If we reach here, key validated strictly
--print("✅ AuthGuard key validated (strict).")

-- Show the notifier UI
ShowBimzHubNotif()

-- ===== Place Whitelist =====
local placeId = tostring(game.PlaceId)
local url = PlaceScripts[placeId]
if not url then
    warn("❌ PlaceId " .. placeId .. " is not whitelisted.")
    pcall(function() Players.LocalPlayer:Kick("PlaceId " .. placeId .. " is not whitelisted.") end)
    return
end

-- Fetch and execute remote script safely
task.delay(3, function()
    local okGet, content = pcall(function()
        -- Try to use safest available http getter: prefer syn.request-like (if available), else game:HttpGet
        if request and type(request) == "function" then
            local r = request({ Url = url, Method = "GET" })
            if r and r.Body then return r.Body end
            error("request returned no body")
        elseif syn and syn.request then
            local r = syn.request({ Url = url, Method = "GET" })
            if r and r.Body then return r.Body end
            error("syn.request returned no body")
        else
            -- fallback to Roblox's HttpGet (may error if disabled)
            return game:HttpGet(url)
        end
    end)

    if not okGet then
        warn("❌ Failed to download remote script:", tostring(content))
        return
    end

    if type(content) ~= "string" or #content < 10 then
        warn("⚠️ Invalid or empty content.")
        return
    end

    getgenv().BimzKeyVerified = true

    local fn, err = loadstring(content)
    if not fn then
        warn("❌ Compile error in remote script:", err)
        return
    end

    local success, execErr = pcall(fn)
    if not success then
        warn("❌ Runtime error while executing remote script:", execErr)
    else
        print("✅ Remote script executed successfully")
    end
end)
