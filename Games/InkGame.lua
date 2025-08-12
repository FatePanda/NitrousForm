ScriptUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FatePanda/NitrousFormUILIB/refs/heads/main/Main.lua"))()

if not ScriptUI then
    print("NoUi")
    return
end

_G.toggles = {
	Speed_Boost = false;
	Jump_Boost = false;
	InfJump = false;
	WinTugOfWar = false;
	Esp = false;
	NameEsp = false;
    Fling = false;
    Noclip = false;
}

_G.toggleValues = {
	Speed_Boost = 100;
	Jump_Boost = 15;
	IgnoreFriends = true;
	DoTeamCheck = false;
	AutoSkip = true;
	HiderEspC = Color3.fromRGB(0,0,255),
	SeekerEspC = Color3.fromRGB(255,0,0)
}

print("Building Functions")

_G.Focus = true
local LastGoodPos = CFrame.new(0,0,0)
game:GetService("UserInputService").WindowFocused:Connect(function()
	_G.Focus = true
end)
game:GetService("UserInputService").WindowFocusReleased:Connect(function()
	_G.Focus = false
    if _G.toggles.Fling then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LastGoodPos
    end
end)
task.spawn(function()
	local movel = 0.1
	while task.wait() do
        if _G.toggles.Fling then
            game:GetService("RunService").Heartbeat:Wait()
                if _G.Focus then
                    local char = game.Players.LocalPlayer.Character
                    if char:WaitForChild("HumanoidRootPart") then
                        local v = char:WaitForChild("HumanoidRootPart").Velocity
                        char:WaitForChild("HumanoidRootPart").Velocity = v * 10000 + Vector3.new(0, 10000, 0)
                        game:GetService("RunService").RenderStepped:Wait()
                        char:WaitForChild("HumanoidRootPart").Velocity = v
                        game:GetService("RunService").Stepped:Wait()
                        char:WaitForChild("HumanoidRootPart").Velocity = v + Vector3.new(0, movel, 0)
                        movel = -movel
                    if _G.Focus then
                        LastGoodPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    end
                end
            end
        end
    end
end)

function _G.RemoveEsp(T)
	if T == 1 then
		for i,v in workspace:WaitForChild("Live"):GetChildren() do
			if v:FindFirstChild("Esp") then
				repeat
					v:FindFirstChild("Esp"):Destroy()
				until not v:FindFirstChild("Esp")
			end
		end
	else
		for i,v in workspace:WaitForChild("Live"):GetChildren() do
			if v:FindFirstChild("NameEsp") then
				repeat
					v:FindFirstChild("NameEsp"):Destroy()
				until not v:FindFirstChild("NameEsp")
			end
		end
	end
end

local function returnfullnumber(Num)
	local s = string.split(tostring(Num))
	local fullfinal = ""

	for i,v in s do
		if v ~= "." then
			fullfinal = fullfinal..v
		else
			break
		end
	end
	if fullfinal ~= "" then
		return tonumber(fullfinal)
	end
end

local MainLoopThread = task.spawn(function()
	while task.wait() do
        game:GetService("UserInputService").MouseIconEnabled = true
		if _G.toggles.Speed_Boost == true then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.toggleValues.Speed_Boost
		end

		if _G.toggles.Jump_Boost == true then
			if game.Players.LocalPlayer.Character.Humanoid.UseJumpPower == false then
				game.Players.LocalPlayer.Character.Humanoid.JumpHeight = _G.toggleValues.Jump_Boost
			else
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = _G.toggleValues.Jump_Boost
			end
		end

		if _G.toggles.InfJump == true then
			game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = false

			if game.Players.LocalPlayer.Character.Humanoid.Jump == true then
				game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		else
			game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
		end

		if _G.toggles.Esp == true then
			for i,v in workspace.Live:GetChildren() do
				if game.Players:FindFirstChild(v.Name) then
					if v:FindFirstChild("Esp") == nil then
						if v.Name ~= game.Players.LocalPlayer.Name then
							local HL = Instance.new("Highlight", v)
							HL.Name = "Esp"
							HL.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
						end
					else
						if _G.toggleValues.DoTeamCheck == true then
							if game.Players:FindFirstChild(v.Name):GetAttribute("IsHider") then
								v.Esp.FillColor = _G.toggleValues.HiderEspC
							else
								if game.Players:FindFirstChild(v.Name):GetAttribute("IsHunter") then
									v.Esp.FillColor = _G.toggleValues.SeekerEspC
								else
									print("! None Found !")
								end
							end
						end
					end
				end
			end
		else
			_G.RemoveEsp(1)
		end

		if _G.toggles.NameEsp == true then
			for i,v in workspace.Live:GetChildren() do
				if game.Players:FindFirstChild(v.Name) and v.Name ~= game.Players.LocalPlayer.Name then
					local plr = game.Players:FindFirstChild(v.Name)
					if not v:FindFirstChild("NameEsp") then
						local nesp = Instance.new("BillboardGui", v)
						nesp.Name = "NameEsp"
						nesp.Size = UDim2.new(0, 100,0, 50)
						nesp.AlwaysOnTop = true
						local txt = Instance.new("TextLabel", nesp)
						txt.BackgroundTransparency = 1
						txt.Name = "MainEsp"
						txt.Size = UDim2.new(1,0,1,0)
						txt.TextScaled = true
						txt.TextColor3 = Color3.fromRGB(208, 208, 208)
						txt.RichText = false
						if plr:FindFirstChild("PlayerTagValue") then
							txt.Text = plr.DisplayName.." (#"..plr:FindFirstChild("PlayerTagValue").Value..") ["..returnfullnumber(v:WaitForChild("Humanoid").Health).."/"..v:WaitForChild("Humanoid").MaxHealth.."]"
						else
							v.NameEsp.MainEsp.Text = tostring(plr.DisplayName.." (#000) ["..v:WaitForChild("Humanoid").Health.."/"..v:WaitForChild("Humanoid").MaxHealth.."]")
						end
						Instance.new("UIStroke", txt)
					else
						if plr:FindFirstChild("PlayerTagValue") then
							v.NameEsp.MainEsp.Text = tostring(plr.DisplayName.." (#"..plr:FindFirstChild("PlayerTagValue").Value..") ["..returnfullnumber(v:WaitForChild("Humanoid").Health).."/"..v:WaitForChild("Humanoid").MaxHealth.."]")
						else
							v.NameEsp.MainEsp.Text = tostring(plr.DisplayName.." (#000) ["..returnfullnumber(v:WaitForChild("Humanoid").Health).."/"..v:WaitForChild("Humanoid").MaxHealth.."]")
						end
					end
				end
			end
		else
			_G.RemoveEsp(2)
		end

		if _G.WinTugOfWar == true then
			game.ReplicatedStorage.Replication:WaitForChild("Event"):FireServer("AttempingToJump")
			game.ReplicatedStorage.TemporaryReachedBindable:FireServer({GameQTE = true})
		end

		if _G.toggles.AutoSkip == true then
			game.ReplicatedStorage.Remotes:WaitForChild("DialogueRemote"):FireServer("Skipped")
		end

        if _G.toggles.Noclip then
            for i,v in game.Players.LocalPlayer.Character:GetDescendants() do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
	end
end)

function _G.TeleportToEnd()
	if workspace:FindFirstChild("RedLightGreenLight") then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.RedLightGreenLight.sand.crossedover.CFrame
	else
		warn("Could Not Find Game")
	end
end

function _G.CheckTiles()
	for i,v in workspace.GlassBridge.GlassHolder:GetChildren() do
		if v.glassmodel1.glasspart:GetAttribute("exploitingisevil") then
			v.glassmodel1.glasspart.Transparency = 0
			v.glassmodel1.glasspart.Color = Color3.fromRGB(255,0,0)
			v.glassmodel2.glasspart.Transparency = 0
			v.glassmodel2.glasspart.Color = Color3.fromRGB(0,255,0)
		else
			v.glassmodel1.glasspart.Transparency = 0
			v.glassmodel1.glasspart.Color = Color3.fromRGB(0,255,0)
			v.glassmodel2.glasspart.Transparency = 0
			if v.glassmodel2.glasspart:GetAttribute("exploitingisevil") then
				v.glassmodel2.glasspart.Color = Color3.fromRGB(255,0,0)
			else
				v.glassmodel2.glasspart.Color = Color3.fromRGB(0,255,0)
			end
		end
	end
end

function _G.KillRandomHider()
	for i,v in game.Players:GetPlayers() do
		if not v:IsFriendsWith(game.Players.LocalPlayer.UserId) and _G.toggleValues.IgnoreFriends == true then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
		end
	end
end

function _G.MakeAllTilesSafe()
	for i,v in workspace.GlassBridge.GlassHolder:GetChildren() do
		if v:FindFirstChild("MakeSafe1") or v:FindFirstChild("MakeSafe2") then
			return
		end
		local function Create(Ele : Part)
			Ele.Transparency = 1
			Ele.Size = Vector3.new(15,1,15)
			Ele.Anchored = true
		end

		local p = Instance.new("Part", v)
		p.CFrame = v.glassmodel1.glasspart.CFrame + Vector3.new(0,0.25,0)
		p.Name = "MakeSafe1"
		Create(p)

		local p2 = Instance.new("Part", v)
		p2.CFrame = v.glassmodel2.glasspart.CFrame + Vector3.new(0,0.25,0)
		p2.Name = "MakeSafe2"
		Create(p2)
	end
end

function _G.CompleteDalgona()
	game.ReplicatedStorage.Remotes:WaitForChild("DALGONATEMPREMPTE"):FireServer({Completed = true})
	for a,b in workspace.Live:GetChildren() do
		if game.Players:FindFirstChild(b.Name) then
			for i,v in b:GetDescendants() do
                if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
                    v.LocalTransparencyModifier = 0
                    v.Transparency = 0
                end
			end
		end
	end
	game.Players.LocalPlayer.PlayerGui.ImpactFrames.ViewportFrame:Destroy()
	game.Players.LocalPlayer.PlayerGui.ImpactFrames.ProgressBar:Destroy()
	workspace.CurrentCamera:Destroy()
    local newcam = Instance.new("Camera", workspace)
    newcam.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
    workspace.CurrentCamera = newcam
    newcam.CameraType = Enum.CameraType.Custom
end

function _G.CompleteJumpRope()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.JumpRope.Model_3.Model_96.Model_97.Model_103.Union.CFrame + Vector3.new(0,5,0)
end

function _G.GoToEndJR()
	if workspace:FindFirstChild("JumpRope") then
		game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = workspace.JumpRope.Model_3.Model_96.Model_97.Model_103.Union.CFrame + Vector3.new(0,5,0)
	end
end

function _G.GotoSafeSpot()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.AFKWorldMap.SpawnCF.CFrame
end

print("Functions Built. Building UI")

local function initui()
	local MainUi = ScriptUI:Init(game.Players.LocalPlayer.PlayerGui, "Nitrous Form", true, 117032672662162)

	local MiscPage = MainUi:NewPage("Misc")

	MiscPage:SetCurrentPage()

	local SbToggle = MiscPage.Toggle({
		Title = "Speed Boost";
		Description = "NONE";
		CurrentValue = false;
		Callback = function(Value)
			_G.toggles.Speed_Boost = Value
		end
	})

	local SbInput = MiscPage.Input({
		Title = "Speed Boost Value";
		Description = "NONE";
		Type = "Number";
		Callback = function(Value)
			_G.toggleValues.Speed_Boost = tonumber(Value)
		end
	})

	local JbToggle = MiscPage.Toggle({
		Title = "Jump Boost";
		Description = "NONE";
		CurrentValue = false;
		Callback = function(Value)
			_G.toggles.Jump_Boost = Value
		end
	})

	local JbInput = MiscPage.Input({
		Title = "Jump Boost Value";
		Description = "NONE";
		Type = "Number";
		Callback = function(Value)
			_G.toggleValues.Jump_Boost = tonumber(Value)
		end
	})

	local InfJumpTog = MiscPage.Toggle({
		Title = "Infinite Jump";
		Description = "NONE";
		CurrentValue = false;
		Callback  = function(Value)
			_G.toggles.InfJump = Value
		end
	})

	local Esp1 = MiscPage.Toggle({
		Title = "Esp";
		Description = "NONE";
		CurrentValue = false;
		Callback = function(Value)
			_G.toggles.Esp = Value
		end
	})

	local Esp2 = MiscPage.Toggle({
		Title = "Name Esp";
		Description = "NONE";
		CurrentValue = false;
		Callback = function(Value)
			_G.toggles.NameEsp = Value
		end
	})

	local SkipD = MiscPage.Toggle({
		Title = "Auto Skip Dialogue";
		Description = "NONE";
		CurrentValue = true;
		Callback = function(Value)
			_G.toggles.AutoSkip = Value
		end
	})

    local Fling = MiscPage.Toggle({
		Title = "Fling";
		Description = "Does not work rn";
		CurrentValue = false;
		Callback = function(Value)
			_G.toggles.Fling = Value
		end
	})

    local NoClip = MiscPage.Toggle({
		Title = "Noclip";
		Description = "NONE";
		CurrentValue = false;
		Callback = function(Value)
            if Value == true then
                _G.Items = {}
                for i,v in game.Players.LocalPlayer.Character:GetDescendants() do
                    if v:IsA("BasePart") then
                        table.insert(_G.Items, {v, v.CanCollide})
                    end
                end
            else
                if _G.Items then
                    for i,v in _G.Items do
                        if v[1] and v[2] then
                            v[1].CanCollide = v[2]
                        end
                    end
					_G.Items = nil
                end
            end
			_G.toggles.Noclip = Value
		end
	})

	local GamePage = MainUi:NewPage("Games")

	local RLGLL = GamePage.Label({
		Title = "Redlight Greenlight"
	})

	local TeleportToEndRlgl = GamePage.Button({
		Title = "Teleport To End",
		Description = "NONE";
		Callback = function()
			_G.TeleportToEnd()
		end
	})

	local DLGNAL = GamePage.Label({
		Title = "Dalgona"
	})

	local DLGNASKIP = GamePage.Button({
		Title = "Skip Dalgona",
		Description = "Does Not Work Yet!";
		Callback = function()
			_G.CompleteDalgona()
		end
	})

	local TOWL = GamePage.Label({
		Title = "Tug Of War",
	})

	local WINTOW = GamePage.Toggle({
		Title = "Win Tug Of War",
		Description = "Does Not Work Yet!";
		CurrentValue = false,
		Callback = function(Value)
			_G.toggles.WinTugOfWar = Value
		end,
	})

	local HAS = GamePage.Label({
		Title = "Hide And Seek"
	})

	local ESPTC = GamePage.Toggle({
		Title = "Esp Team Check",
		Description = "NONE";
		CurrentValue = false,
		Callback = function(Value)
			_G.toggleValues.DoTeamCheck = Value
		end,
	})

	local HASH = GamePage.Label({
		Title = "Hiders";
	})
	
	local Warn1 = GamePage.Label({
		Title = "No Options Yet";
	})
	local HASS = GamePage.Label({
		Title ="Seekers"
	})
	local Warn2 = GamePage.Label({
		Title ="No Options Yet"
	})
	
	local JRL = GamePage.Label({
		Title = "Jump Rope"
	})

	local TPTOENDJR = GamePage.Button({
		Title = "Teleport To End",
		Description = "NONE";
		Callback = function()
			_G.GoToEndJR()
		end
	})


	local GBL = GamePage.Label({
		Title ="Glass Bridge"
	})

	local GBRT = GamePage.Button({
		Title = "Reveal Tiles",
		Description = "NONE";
		Callback = function()
			_G.CheckTiles()
		end
	})

	local GBMS = GamePage.Button({
		Title = "Make All Tiles Safe (Only Works For You)",
		Description = "NONE";
		Callback = function()
			_G.MakeAllTilesSafe()
		end
	})

	print("UI Built")
end

initui()
