local UILibrary = {}

function UILibrary:Init(Parent : Part, Title : string, LogoEnabled : boolean, LogoId : NumberValue)
	local TweenServ = game:GetService("TweenService")
	if not Parent then
		Parent = workspace
	end
	if LogoEnabled == true and not LogoId then
		return error("Logo Is Enabled But No Logo Is Provided")
	end
	if not Title then
		Title = "Nitrous Form UI Lib"
	end

	local MainGui = Instance.new("ScreenGui", Parent)
	MainGui.IgnoreGuiInset = true
	MainGui.ResetOnSpawn = false
	MainGui.Name = "Nitrous Form UI Lib"

	game:GetService("UserInputService").InputBegan:Connect(function(Key)
		if Key.KeyCode == Enum.KeyCode.RightAlt then
			MainGui.Enabled = not MainGui.Enabled
		end
	end)

	local MainHolder = Instance.new("CanvasGroup", MainGui)
	MainHolder.BackgroundColor3 = Color3.fromRGB(51, 51, 51)
	MainHolder.Size = UDim2.new(0.56003, 0, 0.62146, 0)
	MainHolder.Position = UDim2.new(0.21967, 0, 0.18876, 0)
	MainHolder.Name = "Holder"
	MainHolder.Active = true
	MainHolder.Draggable = true

	local PagesFolder = Instance.new("Folder", MainHolder)
	PagesFolder.Name = "Pages"

	local PagesHolder = Instance.new("CanvasGroup", PagesFolder)
	PagesHolder.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	PagesHolder.Size = UDim2.new(0.98176, 0, 0.88757, 0)
	PagesHolder.Position = UDim2.new(0.00798, 0, 0.09556, 0)
	PagesHolder.Name = "Holder"

	local PHUIC = Instance.new("UICorner", PagesHolder)
	PHUIC.CornerRadius = UDim.new(0.0125, 0)

	local UIC_1 = Instance.new("UICorner", MainHolder)
	UIC_1.CornerRadius = UDim.new(0.0125, 0)

	local TopBar = Instance.new("Frame", MainHolder)
	TopBar.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
	TopBar.Size = UDim2.new(1, 0, 0.08392, 0)
	TopBar.Position = UDim2.new(0, 0, 0, 0)
	TopBar.Name = "TopBar"
	TopBar.BorderSizePixel = 0

	local TitleText = Instance.new("TextLabel", TopBar)
	TitleText.TextWrapped = true
	TitleText.TextScaled = true
	TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TitleText.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TitleText.TextColor3 = Color3.fromRGB(212, 252, 255)
	TitleText.BackgroundTransparency = 1
	TitleText.Size = UDim2.new(0.17332, 0, 0.80424, 0)
	TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TitleText.Text = Title
	TitleText.Name = "Title"
	TitleText.Position = UDim2.new(0.01026, 0, 0.09409, 0)
	TitleText.TextXAlignment = Enum.TextXAlignment.Left

	if LogoEnabled == true then
		local LogoIcon = Instance.new("ImageLabel", TopBar)
		LogoIcon.BorderSizePixel = 0
		LogoIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LogoIcon.ImageTransparency = 0.69
		LogoIcon.Image = "rbxassetid://"..tostring(LogoId)
		LogoIcon.Size = UDim2.new(0.04866, 0, 0.89929, 0)
		LogoIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LogoIcon.BackgroundTransparency = 1
		LogoIcon.Name = "Logo"
		LogoIcon.Position = UDim2.new(0.95112, 0, 0.06004, 0)
	end

	local SideBarFrame = Instance.new("Frame", MainHolder)
	SideBarFrame.ZIndex = 100
	SideBarFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	SideBarFrame.Size = UDim2.new(0.34664, 0, 0.91639, 0)
	SideBarFrame.Position = UDim2.new(-0.34778, 0, 0.08229, 0)
	SideBarFrame.Name = "Sidebar"
	SideBarFrame.LayoutOrder = 100
	SideBarFrame.BorderSizePixel = 0

	local HamburgerIcon = Instance.new("ImageButton", SideBarFrame)
	HamburgerIcon.BackgroundTransparency = 1
	HamburgerIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HamburgerIcon.ImageColor3 = Color3.fromRGB(144, 144, 144)
	HamburgerIcon.Image = "rbxassetid://12214197591"
	HamburgerIcon.Size = UDim2.new(0.16605, 0, 0.06817, 0)
	HamburgerIcon.Name = "OpenSide"
	HamburgerIcon.Position = UDim2.new(1.03214, 0, 0.01363, 0)

	local Open = false
	local OpenUI = TweenServ:Create(SideBarFrame, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Position = UDim2.new(0, 0, 0.08229, 0)})
	local CloseUI = TweenServ:Create(SideBarFrame, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {Position = UDim2.new(-0.34778, 0, 0.08229, 0)})

	HamburgerIcon.MouseButton1Click:Connect(function()
		if Open == false then
			CloseUI:Cancel()
			OpenUI:Play()
			Open = true
		else
			OpenUI:Cancel()
			CloseUI:Play()
			Open = false
		end
	end)

	local HamburgerIcon_Aspect = Instance.new("UIAspectRatioConstraint", HamburgerIcon)

	local SidebarHolder = Instance.new("ScrollingFrame", SideBarFrame)
	SidebarHolder.Active = true
	SidebarHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SidebarHolder.Name = "SidebarHolder"
	SidebarHolder.Size = UDim2.new(1, 0, 0.968, 0)
	SidebarHolder.Position = UDim2.new(0, 0, 0.015, 0)
	SidebarHolder.ScrollBarThickness = 0
	SidebarHolder.ZIndex = 101
	SidebarHolder.BackgroundTransparency = 1

	local SBHGL = Instance.new("UIGridLayout", SidebarHolder)
	SBHGL.CellSize = UDim2.new(0.95, 0, 0, 50)
	SBHGL.SortOrder = Enum.SortOrder.LayoutOrder
	SBHGL.FillDirection = Enum.FillDirection.Horizontal
	SBHGL.StartCorner = Enum.StartCorner.TopLeft
	SBHGL.CellPadding = UDim2.new(0, 0, 0, 5)
	SBHGL.HorizontalAlignment = Enum.HorizontalAlignment.Center

	_G.Pages = {}

	function _G.Pages:NewPage(Name)		
		local NwPgBtn = Instance.new("TextButton", SidebarHolder)
		NwPgBtn.Visible = true
		NwPgBtn.Text = Name
		NwPgBtn.TextWrapped = true
		NwPgBtn.TextSize = 27
		NwPgBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		NwPgBtn.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		NwPgBtn.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		NwPgBtn.Size = UDim2.new(0.12771, 0, 0.05302, 0)
		NwPgBtn.Name = Name
		NwPgBtn.AutoButtonColor = false
		NwPgBtn.ZIndex = 101

		local NwPgBtnUIC = Instance.new("UICorner", NwPgBtn)
		NwPgBtnUIC.CornerRadius = UDim.new(0.15, 0)

		local NwPgF = Instance.new("ScrollingFrame", PagesHolder)
		NwPgF.Active = true
		NwPgF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NwPgF.Name = Name
		NwPgF.Size = UDim2.new(1, 0, 0.98654, 0)
		NwPgF.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		NwPgF.Position = UDim2.new(0, 0, 0.01346, 0)
		NwPgF.ScrollBarThickness = 0
		NwPgF.BackgroundTransparency = 1
		NwPgF.Visible = false
		NwPgF.AutomaticCanvasSize = Enum.AutomaticSize.Y

		local NwPgFL = Instance.new("UIListLayout", NwPgF)
		NwPgFL.HorizontalAlignment = Enum.HorizontalAlignment.Center
		NwPgFL.Padding = UDim.new(0, 5)
		NwPgFL.SortOrder = Enum.SortOrder.LayoutOrder

		NwPgBtn.MouseButton1Click:Connect(function()
			for i, v in pairs(PagesHolder:GetChildren()) do
				if v:IsA("ScrollingFrame") and v.Name ~= NwPgF.Name then
					v.Visible = false
				end
			end

			NwPgF.Visible = true
		end)

		_G.Elements = {}

		function _G.Elements:SetCurrentPage()
			for i, v in pairs(PagesHolder:GetChildren()) do
				if v:IsA("ScrollingFrame") and v.Name ~= NwPgF.Name then
					v.Visible = false
				end
			end

			NwPgF.Visible = true
		end

		function _G.Elements.Label(Info)
			local LabelFrm = Instance.new("Frame")
			local LabelTitle = Instance.new("TextLabel")
			local LabelDesc = Instance.new("TextLabel")
			local UICorner = Instance.new("UICorner")

			if not Info.Description then
				Info.Description = "NONE"
			end

			LabelFrm.Name = Info.Title
			LabelFrm.Parent = NwPgF
			LabelFrm.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
			LabelFrm.Size = UDim2.new(0.985, 0, 0, 100)
			LabelFrm.LayoutOrder = #PagesHolder:GetChildren()

			LabelTitle.Name = Info.Title
			LabelTitle.Parent = LabelFrm
			LabelTitle.BackgroundTransparency = 1
			LabelTitle.Position = UDim2.new(0.399534047, 0, 0.518102467, 0)
			LabelTitle.Size = UDim2.new(0.203207299, 0, -0.265655011, 0)
			LabelTitle.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			LabelTitle.Text = Info.Title
			LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelTitle.TextScaled = true

			LabelDesc.Name = Info.Description
			LabelDesc.Parent = LabelFrm
			LabelDesc.BackgroundTransparency = 1
			LabelDesc.Position = UDim2.new(0.0139370235, 0, 0.916952908, 0)
			LabelDesc.Size = UDim2.new(0.970916867, 0, -0.39820534, 0)
			LabelDesc.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			LabelDesc.Text = Info.Description
			LabelDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelDesc.TextSize = 20.000
			LabelDesc.TextWrapped = true
			LabelDesc.TextYAlignment = Enum.TextYAlignment.Top

			UICorner.CornerRadius = UDim.new(0.05, 0)
			UICorner.Parent = LabelFrm
		end

		function _G.Elements.Button(Info)
			local NewBtnFRM = Instance.new("Frame", NwPgF)
			NewBtnFRM.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			NewBtnFRM.Size = UDim2.new(0.985, 0, 0, 100)
			NewBtnFRM.Name = Info.Title
			NewBtnFRM.LayoutOrder = #PagesHolder:GetChildren()

			if not Info.Description then
				Info.Description = "NONE"
			end

			local NewBtn = Instance.new("TextButton", NewBtnFRM)
			NewBtn.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			NewBtn.BackgroundTransparency = 1
			NewBtn.Size = UDim2.new(1, 0, 1, 0)
			NewBtn.Text = ""
			NewBtn.Name = Info.Title
			NewBtn.Position = UDim2.new(0, 0, 0, 0)
			NewBtn.MouseButton1Click:Connect(Info.Callback)

			local NewBtnT = Instance.new("TextLabel", NewBtn)
			NewBtnT.TextScaled = true
			NewBtnT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewBtnT.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			NewBtnT.TextColor3 = Color3.fromRGB(255, 255, 255)
			NewBtnT.BackgroundTransparency = 1
			NewBtnT.Size = UDim2.new(0.20321, 0, -0.26566, 0)
			NewBtnT.Text = Info.Title
			NewBtnT.Name = Info.Title.."_Title"
			NewBtnT.Position = UDim2.new(0.39953, 0, 0.5181, 0)

			local NewBtnD = Instance.new("TextLabel", NewBtn)
			NewBtnD.TextWrapped = true
			NewBtnD.TextSize = 20
			NewBtnD.TextYAlignment = Enum.TextYAlignment.Top
			NewBtnD.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			NewBtnD.TextColor3 = Color3.fromRGB(255, 255, 255)
			NewBtnD.BackgroundTransparency = 1
			NewBtnD.Size = UDim2.new(0.97092, 0, -0.39821, 0)
			NewBtnD.Text = Info.Description
			NewBtnD.Name = Info.Description.."_Description"
			NewBtnD.Position = UDim2.new(0.01394, 0, 0.91695, 0)

			local NewBtnC = Instance.new("UICorner", NewBtnFRM)
			NewBtnC.CornerRadius = UDim.new(0.05, 0)
		end

		function _G.Elements.Toggle(Info)
			local NewToggleFRM = Instance.new("Frame", NwPgF)
			NewToggleFRM.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			NewToggleFRM.Size = UDim2.new(0.985, 0, 0, 100)
			NewToggleFRM.Position = UDim2.new(0, 0, 0.2217, 0)
			NewToggleFRM.Name = Info.Title
			NewToggleFRM.LayoutOrder = #PagesHolder:GetChildren()

			if not Info.Description then
				Info.Description = "NONE"
			end

			local UICNF = Instance.new("UICorner", NewToggleFRM)
			UICNF.CornerRadius = UDim.new(0.05, 0)

			local NewTGLT = Instance.new("TextLabel", NewToggleFRM)
			NewTGLT.TextXAlignment = Enum.TextXAlignment.Left
			NewTGLT.TextScaled = true
			NewTGLT.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewTGLT.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			NewTGLT.TextColor3 = Color3.fromRGB(255, 255, 255)
			NewTGLT.BackgroundTransparency = 1
			NewTGLT.Size = UDim2.new(0.20321, 0, -0.26566, 0)
			NewTGLT.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NewTGLT.Text = Info.Title
			NewTGLT.Name = Info.Title.."_Title"
			NewTGLT.Position = UDim2.new(0.01278, 0, 0.364, 0)

			local NewTGLD = Instance.new("TextLabel", NewToggleFRM)
			NewTGLD.TextWrapped = true
			NewTGLD.TextSize = 20
			NewTGLD.TextXAlignment = Enum.TextXAlignment.Left
			NewTGLD.TextYAlignment = Enum.TextYAlignment.Top
			NewTGLD.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NewTGLD.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			NewTGLD.TextColor3 = Color3.fromRGB(255, 255, 255)
			NewTGLD.BackgroundTransparency = 1
			NewTGLD.Size = UDim2.new(0.68869, 0, -0.54324, 0)
			NewTGLD.Text = Info.Description
			NewTGLD.Name = Info.Description.."_Description"
			NewTGLD.Position = UDim2.new(0.01394, 0, 0.89882, 0)

			local MainTgl = Instance.new("TextButton", NewToggleFRM)
			MainTgl.TextSize = 14
			MainTgl.AutoButtonColor = false
			MainTgl.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			MainTgl.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			MainTgl.Size = UDim2.new(0.07429, 0, 0.30313, 0)
			MainTgl.Text = ""
			MainTgl.Position = UDim2.new(0.89626, 0, 0.34432, 0)

			local UIC1 = Instance.new("UICorner", MainTgl)
			UIC1.CornerRadius = UDim.new(0.25, 0)

			local MainTGLFRM = Instance.new("CanvasGroup", MainTgl)
			MainTGLFRM.BackgroundColor3 = Color3.fromRGB(198, 238, 255)
			MainTGLFRM.Size = UDim2.new(0.83116, 0, 0.85631, 0)
			MainTGLFRM.Position = UDim2.new(0.07633, 0, 0.04473, 0)
			MainTGLFRM.BackgroundTransparency = 1

			local ShowVal = Instance.new("Frame", MainTgl)
			ShowVal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ShowVal.Size = UDim2.new(0.43903, 0, 0.9, 0)

			local UIC2 = Instance.new("UICorner", ShowVal)
			UIC2.CornerRadius = UDim.new(0.25, 0)

			local TurnOn = TweenServ:Create(ShowVal, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Position = UDim2.new(0.4955, 0, .05, 0)})
			local TurnOff = TweenServ:Create(ShowVal, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {Position = UDim2.new(0.05, 0, .05, 0)})

			if Info.CurrentValue == false then
				TurnOff:Play()
			else
				TurnOn:Play()
			end

			MainTgl.MouseButton1Click:Connect(function()
				Info.CurrentValue = not Info.CurrentValue
				Info.Callback(Info.CurrentValue)
				print("here")
				if not Info.CurrentValue then
					TurnOn:Cancel()
					TurnOff:Play()
				else
					TurnOff:Cancel()
					TurnOn:Play()
				end
			end)

		end

		function _G.Elements.Input(Info)
			local InputFrm = Instance.new("Frame", NwPgF)
			InputFrm.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
			InputFrm.Size = UDim2.new(0.985, 0, 0, 100)
			InputFrm.Position = UDim2.new(-0, 0, 0.2217, 0)
			InputFrm.Name = Info.Title.."_Input"
			InputFrm.LayoutOrder = #PagesHolder:GetChildren()

			if not Info.Description then
				Info.Description = "NONE"
			end

			local InputTitle = Instance.new("TextLabel", InputFrm)
			InputTitle.TextXAlignment = Enum.TextXAlignment.Left
			InputTitle.TextScaled = true
			InputTitle.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			InputTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputTitle.BackgroundTransparency = 1
			InputTitle.Size = UDim2.new(0.20321, 0, -0.26566, 0)
			InputTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InputTitle.Text = Info.Title
			InputTitle.Name = Info.Title.."_Input"
			InputTitle.Position = UDim2.new(0.01278, 0, 0.364, 0)

			local InputDescription = Instance.new("TextLabel", InputFrm)
			InputDescription.TextWrapped = true
			InputDescription.TextSize = 20
			InputDescription.TextXAlignment = Enum.TextXAlignment.Left
			InputDescription.TextYAlignment = Enum.TextYAlignment.Top
			InputDescription.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			InputDescription.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputDescription.BackgroundTransparency = 1
			InputDescription.Size = UDim2.new(0.68869, 0, -0.54324, 0)
			InputDescription.Text = Info.Description
			InputDescription.Name = Info.Description.."_Description"
			InputDescription.Position = UDim2.new(0.01394, 0, 0.89882, 0)

			local UICInp = Instance.new("UICorner", InputFrm)
			UICInp.CornerRadius = UDim.new(0.05, 0)

			local InpBox = Instance.new("TextBox", InputFrm)
			InpBox.TextWrapped = true
			InpBox.TextSize = 14
			InpBox.TextColor3 = Color3.fromRGB(236, 236, 236)
			InpBox.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
			InpBox.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			InpBox.PlaceholderText = "..."
			InpBox.Size = UDim2.new(0.07334, 0, 0.28471, 0)
			InpBox.Position = UDim2.new(0.89626, 0, 0.36274, 0)
			InpBox.Text = ""

			InpBox.FocusLost:Connect(function()
				if InpBox.Text ~= "" then
					if Info.Type == "Number" then
						if tonumber(InpBox.Text) then
							Info.Callback(InpBox.Text)
						end
					else
						Info.Callback(InpBox.Text)
					end
				end
			end)

			local UICInpBox = Instance.new("UICorner", InpBox)
			UICInpBox.CornerRadius = UDim.new(0.25, 0)
		end
		return _G.Elements
	end
	return _G.Pages
end


local init = UILibrary:Init(game.Players.LocalPlayer.PlayerGui, "Nitrous Form (Phantom Forces)", true, 100163952664510)

local Toggles = {
	["Esp"] = false
}

local function GetPlayersData()
	local Fold = game:GetService('Workspace'):FindFirstChild('Players')

	local FullData = {}
	if Fold:GetChildren()[1] and Fold:GetChildren()[2] then
		for a, b in Fold:GetChildren()[1]:GetChildren() do
			if b:IsA('Model') then
				for c, d in b:GetChildren() do
					local PackedData = {Player=""; Torso=nil; ObfuscatedName=""; ParentFolder=nil}
					if d:FindFirstChildOfClass('SpecialMesh') and d:FindFirstChildOfClass('SpecialMesh').MeshId == "rbxassetid://4049240078" then
						PackedData.Torso = d
					end
					if d:FindFirstChild('NameTagGui') then
						PackedData.Player = d.NameTagGui.PlayerTag.Text
					end
					PackedData.ObfuscatedName = d.Name
					PackedData.ParentFolder = b
					table.insert(FullData, PackedData)
				end
			end
		end

		for a, b in Fold:GetChildren()[2]:GetChildren() do
			if b:IsA('Model') then
				for c, d in b:GetChildren() do
					local PackedData = {Player=""; Torso=nil; ObfuscatedName=""; ParentFolder=nil}
					if d:FindFirstChildOfClass('SpecialMesh') and d:FindFirstChildOfClass('SpecialMesh').MeshId == "rbxassetid://4049240078" then
						PackedData.Torso = d
					end
					if d:FindFirstChild('NameTagGui') then
						PackedData.Player = d.NameTagGui.PlayerTag.Text
					end
					PackedData.ObfuscatedName = d.Name
					PackedData.ParentFolder = b
					table.insert(FullData, PackedData)
				end
			end
		end
	end
	return FullData
end

local FunctionThread = task.spawn(function()
	while task.wait() do
		if Toggles["Esp"] == true then
			local EspGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
			EspGui.Name = "Esp"

			game.Players.PlayerRemoving:Connect(function(Player)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Esp") then
					if game.Players.LocalPlayer.PlayerGui.Esp:FindFirstChild(Player.UserId) then
						game.Players.LocalPlayer.PlayerGui[tostring(Player.UserId)]:Destroy()
					end
				end
			end)

			while Toggles["Esp"] == true do
				task.wait()
				for i,v in GetPlayersData() do
					if v.Player ~= nil then
						local Torso = v.Torso
						v.Player = game.Players:FindFirstChild(v.Player)
						if v.Player ~= nil then
							local d = v.ParentFolder:FindFirstChild(v.ObfuscatedName)
							if d then
								if v ~= game.Players.LocalPlayer then
									if EspGui:FindFirstChild(tostring(v.Player.UserId)) then
										local PosToScreen, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Torso.Position)
										local UI = EspGui:FindFirstChild(tostring(v.UserId))
										if OnScreen then
											UI.Visible = true
											local scale = 1 / (PosToScreen.Z * math.tan(math.rad(workspace.CurrentCamera.FieldOfView * 0.5)) * 2) * 1000
											local width, height = math.floor(4.5 * scale), math.floor(6 * scale)
											local x, y = math.floor(PosToScreen.X), math.floor(PosToScreen.Y)
											local xPosition, yPosition = math.floor(x - width * 0.5), math.floor((y - height * 0.5) + (0.5 * scale))

											UI.Size = UDim2.new(0, width, 0, height)
											UI.Position = UDim2.new(0, xPosition, 0, yPosition)
											UI.Transparency = 1		
										else
											UI.Visible = false
										end
									else
										local PlayerEsp = Instance.new("Frame", EspGui)
										local Border_1 = Instance.new("UIStroke", PlayerEsp)
										local PlayerName = Instance.new("TextLabel", PlayerEsp)
										local Border_2 = Instance.new("UIStroke", PlayerName)

										PlayerEsp.Name = tostring(v.Player.UserId)

										Border_1.Thickness = 4
										Border_1.Color = Color3.fromRGB(255,0,0)

										PlayerEsp.Transparency = 1

										PlayerName.BackgroundTransparency = 1
										PlayerName.Position = UDim2.new(0, 0, -0.239999995, 0)
										PlayerName.TextColor3 = Color3.fromRGB(255,255,255)
										PlayerName.Size = UDim2.new(1, 0, 0.180000007, 0)
										PlayerName.Text = v.Player.Name
										PlayerName.TextScaled = true

										Border_2.Thickness = 1
										Border_2.Color = Color3.fromRGB(0,0,0)
									end
								end
							end
						end
					end
				end
			end
		else
			if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Esp") then
				game.Players.LocalPlayer.PlayerGui.Esp:Destroy()
			end
		end
	end
end)

local Page1 = init:NewPage("Esp")

Page1:SetCurrentPage()

local EspToggle = Page1.Toggle({
	Title = "Esp"; 
	Description = "NONE"; 
	CurrentValue = false; 
	Callback = function(Value) 
		Toggles["Esp"] = Value
	end 
})
