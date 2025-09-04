local NitrousFormUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/FatePanda/NitrousFormUILIB/refs/heads/main/Main.lua"))()

local init = NitrousFormUI:Init(game.Players.LocalPlayer.PlayerGui, "Nitrous Form (Phantom Forces)", true, 100163952664510)

local Page1 = init:NewPage("Esp")

Page1:SetCurrentPage()

local EspToggle = Page1.Toggle({
	Title = "Esp"; 
	Description = "NONE"; 
	CurrentValue = false; 
	Callback = function(Value) 
		if Value == true then 
			local EspGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
			EspGui.Name = "Esp"

			game.Players.PlayerRemoving:Connect(function(Player)
				if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Esp") then
					if game.Players.LocalPlayer.Esp:FindFirstChild(Player.UserId) then
						game.Players.LocalPlayer.PlayerGui[tostring(Player.UserId)]:Destroy()
					end
				end
			end)

			while Value == true do
				task.wait()
				for i,v in game.Players:GetPlayers() do
					if v ~= game.Players.LocalPlayer then
						local Char

						if v.Character then
							Char = v.Character
						else
							v.CharacterAdded:Wait()
							Char = v.Character
						end

						if Char then
							if EspGui:FindFirstChild(tostring(v.UserId)) then
								local PosToScreen, OnScreen = workspace.CurrentCamera:WorldToScreenPoint(v.Character:WaitForChild("HumanoidRootPart").Position)
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

								PlayerEsp.Name = tostring(v.UserId)

								Border_1.Thickness = 4
								Border_1.Color = Color3.fromRGB(255,0,0)

								PlayerEsp.Transparency = 1

								PlayerName.BackgroundTransparency = 1
								PlayerName.Position = UDim2.new(0, 0, -0.239999995, 0)
								PlayerName.TextColor3 = Color3.fromRGB(255,255,255)
								PlayerName.Size = UDim2.new(1, 0, 0.180000007, 0)
								PlayerName.Text = v.Name
								PlayerName.TextScaled = true

								Border_2.Thickness = 1
								Border_2.Color = Color3.fromRGB(0,0,0)
							end
						else
							warn("No Character")
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
	}
)
