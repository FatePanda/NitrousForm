print("here")
local GameList = "https://raw.githubusercontent.com/FatePanda/NitrousForm/refs/heads/main/GamesList.Lua"

local DebugOptions = {
	SpoofGameId = false;
	SpoofedId = 99567941238278;
	SpoofedScript = false;
	SpoofedScriptLink = "";
}

local MainLoader = Instance.new("ScreenGui", game.CoreGui)
MainLoader.IgnoreGuiInset = true
MainLoader.Name = "NewLoader"
MainLoader.ResetOnSpawn = false


local MainHolder = Instance.new("CanvasGroup", MainLoader)
MainHolder.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
MainHolder.Size = UDim2.new(0.18455, 0, 0.18281, 0)
MainHolder.Position = UDim2.new(0.40741, 0, 0.40827, 0)
MainHolder.Name = "Holder"

UICorner_1 = Instance.new("UICorner", MainHolder)
UICorner_1.CornerRadius = UDim.new(0.05, 0)

local TopBar = Instance.new("Frame", MainHolder)
TopBar["BorderSizePixel"] = 0
TopBar["BackgroundColor3"] = Color3.fromRGB(36, 36, 36)
TopBar["Size"] = UDim2.new(1, 0, 0.19993, 0)
TopBar["Position"] = UDim2.new(0, 0, -0, 0)
TopBar["BorderColor3"] = Color3.fromRGB(0, 0, 0)
TopBar["Name"] = [[TopBar]]

local MainTitle = Instance.new("TextLabel", TopBar)
MainTitle["TextWrapped"] = true
MainTitle["BorderSizePixel"] = 0
MainTitle["TextSize"] = 18
MainTitle["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
MainTitle["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
MainTitle["TextColor3"] = Color3.fromRGB(212, 252, 255)
MainTitle["BackgroundTransparency"] = 1
MainTitle["Size"] = UDim2.new(0.42906, 0, 0.80928, 0)
MainTitle["BorderColor3"] = Color3.fromRGB(0, 0, 0)
MainTitle["Text"] = [[Nitrous Form]]
MainTitle["Name"] = [[Title]]
MainTitle["Position"] = UDim2.new(0.00712, 0, 0.08905, 0)

local Logo = Instance.new("ImageLabel", TopBar)
Logo["BorderSizePixel"] = 0
Logo["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Logo["ImageTransparency"] = 0.67
Logo["Image"] = [[rbxassetid://100163952664510]]
Logo["Size"] = UDim2.new(0.10402, 0, 0.8722, 0)
Logo["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Logo["BackgroundTransparency"] = 1
Logo["Name"] = [[Logo]]
Logo["Position"] = UDim2.new(0.89576, 0, 0.08905, 0)

local UIASC_1 = Instance.new("UIAspectRatioConstraint", Logo)

local StatusText = Instance.new("TextLabel", MainHolder)
StatusText["TextWrapped"] = true
StatusText["BorderSizePixel"] = 0
StatusText["TextSize"] = 14
StatusText["TextScaled"] = true
StatusText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
StatusText["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
StatusText["TextColor3"] = Color3.fromRGB(255, 255, 255)
StatusText["BackgroundTransparency"] = 1
StatusText["Size"] = UDim2.new(1, 0, 0.14061, 0)
StatusText["BorderColor3"] = Color3.fromRGB(0, 0, 0)
StatusText["Text"] = [[Checking Game]]
StatusText["Position"] = UDim2.new(0, 0, 0.7752, 0)

local Throbber = Instance.new("Frame", MainHolder)
Throbber["BorderSizePixel"] = 0
Throbber["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
Throbber["Size"] = UDim2.new(0.22476, 0, 0.37681, 0)
Throbber["Position"] = UDim2.new(0.38651, 0, 0.30979, 0)
Throbber["BorderColor3"] = Color3.fromRGB(0, 0, 0)
Throbber["BackgroundTransparency"] = 1

local UiStroke_1 = Instance.new("UIStroke", Throbber)
UiStroke_1["Thickness"] = 3
UiStroke_1["Color"] = Color3.fromRGB(119, 119, 119)

local UiGrad_1 = Instance.new("UIGradient", UiStroke_1)
UiGrad_1["Transparency"] = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 1),NumberSequenceKeypoint.new(1.000, 0)}

local UICorner_2 = Instance.new("UICorner", Throbber)
UICorner_2["CornerRadius"] = UDim.new(1, 0)

local UIASC_2 = Instance.new("UIAspectRatioConstraint", Throbber)

_G.ThrobberSpin = true

task.spawn(function()
	while _G.ThrobberSpin == true do
		task.wait()
		Throbber.Rotation += 5
	end
	_G.ThrobberSpin = nil
end)

local function GrabGamesList()
	local List = loadstring(game:HttpGet(GameList))()

	for i,v in List do
		if DebugOptions.SpoofGameId == false then
			if v.Id == game.PlaceId then
				print("Here")
				return v.ScriptLink
			end
		else
			if v.Id == DebugOptions.SpoofedId then
				return v.ScriptLink
			end
		end
	end
	return nil
end

local MainScript = ""

if DebugOptions.SpoofedScript == false then
	MainScript = GrabGamesList()
else
	MainScript = DebugOptions.SpoofedScriptLink
end

task.wait(1)

if MainScript ~= nil then
	StatusText.Text = "Game Found. Loading Script"
	loadstring(game:HttpGet(MainScript))()
	task.wait(2)

	_G.ThrobberSpin = false
	MainLoader:Destroy()
else
	_G.ThrobberSpin = false
	MainLoader:Destroy()
end
