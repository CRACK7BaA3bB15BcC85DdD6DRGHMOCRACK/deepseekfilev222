
local t1 = {}
local t2 = {}
local v3 = unpack or table.unpack
Config = {
	api = "539da4b3-8858-4529-9e87-21e9e75ded30",
	service = "V2",
	provider = "V2"
}
function t2.value1()
    if game.PlaceId ~= 13253735473 then
        game.Players.LocalPlayer:Kick("Game not support!")

        return
    end

    local v92 = cloneref(game:GetService("Workspace"))
    local v93 = cloneref(game:GetService("Players"))
    local _cloneref = cloneref
    local t3 = { game:GetService("RunService") }
    local v96 = _cloneref(v3(t3))
    local v97 = cloneref(game:GetService("Lighting"))
    local v98 = cloneref(game:GetService("UserInputService"))
    local v99 = cloneref(game:GetService("ReplicatedStorage"))
    local LocalPlayer = v93.LocalPlayer

    LocalPlayer:GetMouse()

    local CurrentCamera = v92.CurrentCamera
    local new = CFrame.new
    local new2 = Vector2.new
    local new3 = Vector3.new
    local FindFirstChild = game.FindFirstChild
    local Raycast = v92.Raycast
    local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
    local IsA = game.IsA
    local floor = math.floor
    local round = math.round
    local min = math.min
    local _ = math.abs
    local cos = math.cos
    local sin = math.sin
    local n1 = 3.141592653589793
    local _tick = tick
    local wait = task.wait
    local spawn = task.spawn
    local _pairs = pairs
    local _ipairs = ipairs
    local _type = type
    local _ = next
    local insert = table.insert
    local remove = table.remove
    local sort = table.sort
    local getupvalues = debug.getupvalues
    local getupvalue = debug.getupvalue
    local setupvalue = debug.setupvalue
    local getconstants = debug.getconstants
    local setconstant = debug.setconstant
    local getstack = debug.getstack
    local v132 = getnamecallmethod or function()
        return nil
    end
    local v133 = mousemoverel or function(_, _)
    end
    local t4 = {
		connections = {
			heartbeats = {},
			renderstepped = {}
		},
		hooks = {},
		metahooks = {},
		drawings = {},
		game_hooks = {},
		utility = {}
	}

    function t4.utility.new_heartbeat(p3)
        t4.utility.anti_trace()

        local t5 = {}

        t4.connections.heartbeats[p3] = p3

        function t5.Disconnect(_)
            if p3 then
                t4.connections.heartbeats[p3] = nil
            end
        end

        return t5
    end
    function t4.utility.new_renderstepped(p5)
        t4.utility.anti_trace()

        local t6 = {}

        t4.connections.renderstepped[p5] = p5

        function t6.Disconnect(_)
            if p5 then
                t4.connections.renderstepped[p5] = nil
            end
        end

        return t6
    end
    function t4.utility.new_drawing(p7, p8)
        t4.utility.anti_trace()

        local drawing = Drawing.new(p7)

        for v197, v198 in _pairs(p8) do
            drawing[v197] = v198
        end

        t4.drawings[drawing] = drawing

        return drawing
    end
    function t4.utility.hook_metamethod(p9, p10, p11)
        t4.utility.anti_trace()

        local v202 = hookmetamethod(p9, p10, newcclosure(p11))

        t4.metahooks[p10] = {
			instance = p9,
			func = v202
		}

        return v202
    end
    function t4.utility.protect_constants(p12)
        t4.utility.anti_trace()

        if not p12 then
            return
        end

        local ok, result = pcall(function()
            return getconstants(p12)
        end)

        if ok and result then
            for v206, v207 in _ipairs(result) do
                local v208 = v206
                local v209 = v207

                if _type(v209) == "string" then
                    local v210 = v209:find("hook")

                    if not v210 then
                        v210 = v209:find("debug")

                        if not v210 then
                            v210 = v209:find("cheat")
                        end
                    end

                    if v210 then
                        pcall(function()
                            setconstant(p12, v208, string.reverse(v209))
                        end)
                    end
                end
            end
        end
    end
    function t4.utility.anti_trace()
        local ok, stack = pcall(getstack)

        if ok and _type(stack) == "table" and #stack > 80 then
            return true
        end

        return false
    end
    function t4.utility.protect_upvalues(p13)
        t4.utility.anti_trace()

        if not p13 then
            return
        end

        local ok, result = pcall(function()
            return getupvalues(p13)
        end)

        if ok and result then
            for i = 1, #result do
                local v215 = getupvalue(p13, i)

                if _type(v215) == "function" then
                    local function u216(...)
                        t4.utility.anti_trace()

                        return v215(...)
                    end

                    pcall(function()
                        setupvalue(p13, i, u216)
                    end)
                end
            end
        end
    end

    local connection = v96.Heartbeat:Connect(function(dt)
        t4.utility.anti_trace()

        for _, v219 in _pairs(t4.connections.heartbeats) do
            if _type(v219) == "function" then
                pcall(v219, dt)
            end
        end
    end)
    local connection2 = v96.RenderStepped:Connect(function(dt)
        t4.utility.anti_trace()

        for _, v222 in _pairs(t4.connections.renderstepped) do
            if _type(v222) == "function" then
                pcall(v222, dt)
            end
        end
    end)

    function t4.utility.unload()
        t4.utility.anti_trace()
        connection:Disconnect()
        connection2:Disconnect()
        for v225 in _pairs(t4.connections.heartbeats) do

            t4.connections.heartbeats[v225] = nil
        end
        for v226 in _pairs(t4.connections.renderstepped) do
            t4.connections.renderstepped[v226] = nil
        end
        for v229, v230 in _pairs(t4.drawings) do

            local v231 = v230

            pcall(function()
                v231:Remove()
            end)
            t4.drawings[v229] = nil
        end
        for v232, v233 in _pairs(t4.hooks) do
            local v234 = v232
            local v235 = v233

            if _type(v235) == "function" then
                pcall(function()
                    hookfunction(v234, clonefunction(v235))
                end)
            end
        end
        for v238, v239 in _pairs(t4.metahooks) do

            local v240 = v238
            local v241 = v239
            local v242 = v241

            if v242 then
                v242 = v241.func
            end

            if v242 then
                pcall(function()
                    hookmetamethod(v241.instance, v240, clonefunction(v241.func))
                end)
            end
        end
        for _, v244 in _pairs(t4.game_hooks) do
            local v245 = v244
            local v246 = v245

            if v246 then
                v246 = _type(v245) == "table"

                if v246 then
                    v246 = v245.instance
                end
            end

            if v246 then
                pcall(function()
                    hookmetamethod(v245.instance, v245.metamethod, clonefunction(v245.func))
                end)
            end
        end
    end

    local t7 = {
		middlepart = nil,
		original_model = nil
	}

    local function v138()
        local ok = pcall(function()
            t4.utility.anti_trace()

            local Const = v92:FindFirstChild("Const")

            if Const then
                Const = v92.Const:FindFirstChild("Ignore")

                if Const then
                    Const = v92.Const.Ignore:FindFirstChild("LocalCharacter")
                end
            end

            if Const then
                t7.middlepart = v92.Const.Ignore.LocalCharacter:FindFirstChild("Middle")
            end

            local Shared = v99:FindFirstChild("Shared")

            if Shared then
                Shared = v99.Shared:FindFirstChild("entities")

                if Shared then
                    Shared = v99.Shared.entities:FindFirstChild("Player")

                    if Shared then
                        Shared = v99.Shared.entities.Player:FindFirstChild("Model")
                    end
                end
            end

            if Shared then
                t7.original_model = v99.Shared.entities.Player.Model
            end
        end)

        if ok then
            ok = t7.middlepart

            if ok then
                ok = t7.original_model
            end
        end

        return ok
    end

    v138()

    repeat
        t4.utility.anti_trace()
        wait(0.5)
    until v138()

    spawn(function()
        t4.utility.anti_trace()

        local v248 = t4.utility.hook_metamethod(Random.new(), "__namecall", function(p14, ...)
            t4.utility.anti_trace()

            local t8 = { ... }

            if v132() == "NextNumber" and (t8[1] == -100 and t8[2] == 100) then
                return t4.metahooks.__namecall.func(p14, -1, 1)
            end

            return t4.metahooks.__namecall.func(p14, ...)
        end)

        t4.game_hooks.Random = {
			instance = Random.new(),
			metamethod = "__namecall",
			func = v248
		}
        pcall(function()
            t4.utility.anti_trace()
            t4.utility.protect_constants(loadstring)
            t4.utility.protect_constants(hookfunction)
            t4.utility.protect_constants(hookmetamethod)
            t4.utility.protect_constants(getconstants)
            t4.utility.protect_constants(setconstant)
            t4.utility.protect_constants(getupvalues)
            t4.utility.protect_constants(setupvalue)
            t4.utility.protect_constants(v132)
            t4.utility.protect_constants(getstack)
        end)
        pcall(function()
            t4.utility.anti_trace()
            t4.utility.protect_upvalues(LocalPlayer.GetMouse)
            t4.utility.protect_upvalues(v96.Heartbeat.Connect)
            t4.utility.protect_upvalues(v96.RenderStepped.Connect)
            t4.utility.protect_upvalues(game.FindFirstChild)
            t4.utility.protect_upvalues(Drawing.new)
            t4.utility.protect_upvalues(Instance.new)
            t4.utility.protect_upvalues(v133)
            t4.utility.protect_upvalues(getrawmetatable)
        end)
    end)
    spawn(function()
        local t9 = {}
        t4.utility.anti_trace()
        t9.value1 = nil
        t9.value2 = nil
        t9.value2 = nil
        if not pcall(function()
            t4.utility.anti_trace()
            t9.value1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/Splix" .. "?t=" .. tostring(_tick())))()

            if t9.value1 then
                local value1 = t9.value1
                local EnumFont = Enum.Font
                local new4 = value1.new
                local RobotoMono = EnumFont.RobotoMono
                local color3 = Color3.fromRGB(255, 230, 225)

                t9.value2 = new4(value1, {
					textsize = 13.5,
					font = RobotoMono,
					name = "trident",
					color = color3
				})
            end
        end) or not t9.value1 then
            return
        end
        local t10 = {}
        local v251 = t9.value2:page({
			name = "COMBAT"
		})
        local v252 = t9.value2:page({
			name = "ESP"
		})
        local v253 = t9.value2:page({
			name = "VISUALS"
		})
        local v254 = t9.value2:page({
			name = "MISC"
		})
        local v255 = v251:section({
			name = "AIMBOT",
			side = "left",
			size = 250
		})
        local v256 = v251:section({
			name = "REDICTION",
			side = "right",
			size = 250
		})
        local v257 = v251:section({
			name = "HITBOX",
			side = "left",
			size = 250
		})
        local v258 = v252:section({
			name = "PLAYER ESP",
			side = "left",
			size = 300
		})
        local v259 = v252:section({
			name = "ORE ESP",
			side = "right",
			size = 300
		})
        local v260 = v252:section({
			name = "VEHICLE ESP",
			side = "left",
			size = 300
		})
        local v261 = v252:section({
			name = "OTHER",
			side = "right",
			size = 300
		})
        local v262 = v253:section({
			name = "CHAMS",
			side = "left",
			size = 250
		})
        local v263 = v253:section({
			name = "WORLD",
			side = "left",
			size = 250
		})
        local v264 = v253:section({
			name = "CROSSHAIR",
			side = "right",
			size = 250
		})
        local v265 = v254:section({
			name = "X-RAY",
			side = "left",
			size = 250
		})
        local v266 = v254:section({
			name = "LONG NECK",
			side = "right",
			size = 250
		})
        t10.value1 = {}
        local original_model = t7.original_model
        if original_model then
            original_model = t7.original_model.Head

            if original_model then
                original_model = t7.original_model.Head.Size
            end
        end
        local v268 = original_model or new3(2, 1, 1)
        local v269 = new3(3, 3, 3)
        t10.value2 = nil
        t10.value3 = v268
        t10.value4 = v269
        t10.value5 = 3
        t10.value6 = 3
        t10.value7 = 0.5
        t10.value8 = false
        t10.value9 = 200
        t10.value10 = false
        t10.value11 = false
        t10.value12 = 0
        t10.value13 = 0.25
        t10.value14 = Color3.new(1, 1, 1)
        t10.value15 = {}
        t10.value16 = false
        t10.value17 = false
        t10.value18 = false
        t10.value19 = false
        t10.value20 = false
        t10.value21 = false
        t10.value22 = false
        t10.value23 = 1000
        t10.value24 = Color3.new(1, 1, 1)
        t10.value25 = Color3.new(1, 1, 1)
        t10.value26 = Color3.new(1, 1, 1)
        t10.value27 = Color3.new(1, 1, 1)
        t10.value28 = 12
        t10.value29 = false
        local color3 = Color3.fromRGB(255, 255, 255)
        local color3_2 = Color3.fromRGB(248, 248, 248)
        local color3_3 = Color3.fromRGB(72, 72, 72)
        local t11 = {
			Name = "NITRATE",
			Color = color3,
			Part1Color = color3_2,
			Part2Color = color3_3,
			TextureID = "rbxassetid://12939036056"
		}
        local color3_4 = Color3.fromRGB(255, 200, 100)
        local color3_5 = Color3.fromRGB(199, 172, 120)
        local color3_6 = Color3.fromRGB(72, 72, 72)
        local t12 = {
			Name = "IRON",
			Color = color3_4,
			Part1Color = color3_5,
			Part2Color = color3_6,
			TextureID = "rbxassetid://12939036056"
		}
        local color3_7 = Color3.fromRGB(128, 128, 128)
        local color3_8 = Color3.fromRGB(72, 72, 72)
        t10.value30 = {
			["Nitrate Ore"] = t11,
			["Iron Ore"] = t12,
			Cobblestone = {
				Name = "STONE",
				Color = color3_7,
				Part1Color = color3_8,
				TextureID = "rbxassetid://12939036056"
			}
		}
        t10.value31 = {
			stone = false,
			iron = false,
			nitrate = false
		}
        t10.value32 = false
        t10.value33 = 1000
        t10.value34 = setmetatable({}, {
			__mode = "v"
		})
        t10.value35 = {}
        t10.value36 = false
        t10.value37 = 80
        t10.value38 = 5
        t10.value39 = 1000
        t10.value40 = false
        t10.value41 = false
        t10.value42 = false
        t10.value43 = nil
        t10.value44 = false
        t10.value45 = Color3.new(1, 1, 1)
        t10.value46 = false
        t10.value47 = false
        t10.value48 = false
        t10.value49 = 100
        t10.value50 = 1000
        t10.value51 = false
        t10.value52 = nil
        t10.value53 = nil
        t10.value54 = nil
        t10.value55 = "Head"
        t10.value56 = {}
        t10.value57 = Drawing.new("Line")
        t10.value57.Thickness = 1
        t10.value57.Color = Color3.new(1, 1, 1)
        t10.value57.Visible = false
        t4.drawings[t10.value57] = t10.value57
        t10.value58 = Drawing.new("Text")
        t10.value58.Visible = false
        t10.value58.Size = 12
        t10.value58.Center = true
        t10.value58.Font = 2
        t10.value58.Outline = false
        t10.value58.Color = Color3.new(0, 1, 0)
        t10.value58.Text = "HIT SCANNER"
        t4.drawings[t10.value58] = t10.value58
        t10.value59 = Drawing.new("Circle")
        t10.value59.Thickness = 1
        t10.value59.NumSides = 64
        t10.value59.Radius = t10.value37
        t10.value59.Filled = false
        t10.value59.Visible = false
        t10.value59.Transparency = 0.5
        t10.value59.Color = t10.value45
        t10.value59.ZIndex = 999
        local drawings = t4.drawings
        local value59 = t10.value59
        drawings[t10.value59] = value59
        t10.value60 = false
        t10.value61 = "Neon"
        t10.value62 = 0.3
        t10.value63 = Color3.fromRGB(255, 255, 255)
        t10.value64 = {}
        t10.value65 = {}
        t10.value66 = false
        t10.value67 = "Neon"
        t10.value68 = 0.3
        t10.value69 = Color3.fromRGB(255, 255, 255)
        t10.value70 = {}
        t10.value71 = {}
        t10.value72 = {}
        t10.value73 = false
        t10.value74 = false
        t10.value75 = Color3.new(1, 1, 1)
        t10.value76 = 2
        t10.value77 = 8
        t10.value78 = 4
        t10.value79 = 1
        t10.value80 = 0
        function t10.value81()

            for v393, v394 in _ipairs(t10.value72) do

                v394.Visible = t10.value73
            end
            if not t10.value73 then
                return
            end
            local MouseLocation = v98:GetMouseLocation()
            local v396 = t10.value74 and t10.value80 or 0
            local v397 = cos(v396)
            local v398 = sin(v396)
            local v399 = floor(t10.value77 / 2)
            local v400 = floor(t10.value78 / 2)
            local v401 = -v399 - v400
            local t13 = {
				fromX = 0,
				fromY = v401,
				toX = 0,
				toY = -v400
			}
            local t14 = {
				fromX = 0,
				fromY = v400,
				toX = 0,
				toY = v399 + v400
			}
            local v404 = -v399 - v400
            local v405 = -v400
            local t15 = {
				fromX = v404,
				fromY = 0,
				toX = v405,
				toY = 0
			}
            local v407 = v399 + v400
            local t16 = {
				t13,
				t14,
				t15,
				{
					fromX = v400,
					fromY = 0,
					toX = v407,
					toY = 0
				}
			}
            for v409, v410 in _ipairs(t10.value72) do
                local v411 = v409

                if v411 <= #t16 then
                    local v412 = t16[v411]
                    local fromX = v412.fromX
                    local fromY = v412.fromY
                    local toX = v412.toX
                    local toY = v412.toY

                    v410.From = new2(MouseLocation.X + (fromX * v397 - fromY * v398), MouseLocation.Y + (fromX * v398 + fromY * v397))
                    v410.To = new2(MouseLocation.X + (toX * v397 - toY * v398), MouseLocation.Y + (toX * v398 + toY * v397))
                end
            end
        end
        local function v282()

            for v419, v420 in _ipairs(t10.value72) do

                local v421 = v420

                pcall(function()
                    v421:Remove()
                end)
            end
            t10.value72 = {}
            if not t10.value73 then
                return
            end
            for _ = 1, 4 do
                local drawing = Drawing.new("Line")
                local max = math.max
                local value76 = t10.value76

                drawing.Thickness = max(1, floor(value76))
                drawing.Color = t10.value75
                drawing.Visible = true
                t4.drawings[drawing] = drawing
                insert(t10.value72, drawing)
            end
        end
        t10.value82 = false
        t10.value83 = Color3.new(1, 1, 1)
        t10.value84 = 0.6
        t10.value85 = false
        t10.value86 = false
        t10.value87 = 1000
        t10.value88 = Color3.new(1, 1, 1)
        t10.value89 = false
        t10.value90 = 1000
        t10.value91 = Color3.new(1, 1, 1)
        t10.value92 = setmetatable({}, {
			__mode = "v"
		})
        t10.value93 = setmetatable({}, {
			__mode = "v"
		})
        t10.value94 = {
			CustomSight = true,
			Suppressor = true
		}
        t10.value95 = {
			"Const",
			"Ignore",
			"FPSArms"
		}
        t10.value96 = {
			Bow = {
				"Arrow",
				"Fabric",
				"Meshes/Bow",
				"Handle",
				"AnimationController"
			},
			AR15 = {
				"AnimSaves",
				"Barrel",
				"Body",
				"Bolt",
				"ChargingHandle",
				"Decor",
				"Grip",
				"Mag",
				"Rails",
				"Stock",
				"Muzzle",
				"AnimationController"
			},
			SCAR = {
				"DefaultSight",
				"Barrel",
				"Body",
				"ChargingHandle",
				"Decals",
				"Mag",
				"Rails",
				"ShoulderPad",
				"Stock",
				"Muzzle",
				"AnimationController"
			},
			SVD = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Magazine",
				"Magazine2",
				"Metal2",
				"Wood",
				"AnimationController"
			},
			Blunderbuss = {
				"Body",
				"Tube",
				"thing",
				"Muzzle",
				"AnimationController"
			},
			C9 = {
				"Barrel",
				"Body",
				"Bolt",
				"Decor",
				"Grip",
				"LowerSlide",
				"Mag",
				"Sight1",
				"Sight2",
				"UpperSlide",
				"Muzzle",
				"AnimationController"
			},
			CrossBow = {
				"AnimationController",
				"FrontNails",
				"SpringSteel",
				"Body",
				"Slide",
				"Release",
				"Wheel",
				"BackMetal",
				"String",
				"Arrow",
				"Handle",
				"ADS"
			},
			EnergyRifle = {
				"DefaultSight",
				"FrontCover",
				"Glowing",
				"Grip",
				"Mag",
				"Metal",
				"Metal2",
				"RearCover",
				"RearDecor",
				"Screws",
				"Tubes",
				"AnimationController"
			},
			GaussRifle = {
				"DefaultSight",
				"Barrel",
				"Body",
				"CoilHolders",
				"Coils",
				"Decals1",
				"Decals2",
				"Grip",
				"Housing",
				"Mag",
				"StockBack",
				"AnimationController"
			},
			HMAR = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Bolts",
				"Cover",
				"Mag",
				"Rails",
				"Spring",
				"Stock",
				"Wood",
				"Muzzle",
				"AnimationController"
			},
			LeverActionRifle = {
				"9mm",
				"DefaultSight",
				"Body",
				"Brass",
				"Hammer",
				"Lever",
				"Metal",
				"Thing",
				"Wood",
				"Muzzle",
				"AnimationController"
			},
			M4A1 = {
				"DefaultSight",
				"Body",
				"Bolt",
				"ChargeHandle",
				"Grip",
				"Mag",
				"Metal",
				"mbrk",
				"Muzzle",
				"AnimationController"
			},
			PipePistol = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Mag",
				"Muzzle",
				"AnimationController",
				"Animator"
			},
			PipeSMG = {
				"DefaultSight",
				"Barrel",
				"Body",
				"Bolt",
				"Flap",
				"Grip",
				"Mag",
				"Stock",
				"Muzzle",
				"AnimationController"
			},
			PumpShotgun = {
				"Barrel",
				"Body",
				"MainMetal",
				"RearSight",
				"Shell",
				"Slider",
				"Muzzle",
				"AnimationController"
			},
			RPG = {
				"RocketModel",
				"Body",
				"Body2",
				"Caps",
				"Fasteners",
				"FireMech",
				"Safety",
				"Sight",
				"Trigger",
				"Muzzle",
				"AnimationController"
			},
			USP9 = {
				"Body",
				"Mag",
				"Slide",
				"Muzzle",
				"AnimationController"
			},
			UZI = {
				"DefaultSight",
				"Body",
				"Body2",
				"Bolt",
				"ChargingHandle",
				"Decor",
				"Grip",
				"Mag",
				"Stock",
				"Muzzle",
				"AnimationController"
			}
		}
        local t17 = {
			"Neon",
			"ForceField",
			"SmoothPlastic",
			"Glass",
			"Foil",
			"Ice",
			"DiamondPlate",
			"Cobblestone",
			"Brick",
			"Wood",
			"Metal",
			"Concrete"
		}
        t10.value97 = setmetatable({}, {
			__mode = "k"
		})
        t10.value98 = setmetatable({}, {
			__mode = "k"
		})
        t10.value99 = setmetatable({}, {
			__mode = "k"
		})
        t10.value100 = setmetatable({}, {
			__mode = "k"
		})
        t10.value101 = {}
        t10.value102 = {
			master = false,
			atv = false,
			boat = false,
			helicopter = false,
			trolly = false
		}
        local color3_9 = Color3.new(1, 1, 1)
        local color3_10 = Color3.new(1, 1, 1)
        local color3_11 = Color3.new(1, 1, 1)
        local color3_12 = Color3.new(1, 1, 1)
        t10.value103 = {
			atv = color3_9,
			boat = color3_10,
			helicopter = color3_11,
			trolly = color3_12
		}
        t10.value104 = 1000
        t10.value105 = {}
        t10.value106 = {}
        t10.value107 = math.tan((math.rad(CurrentCamera.FieldOfView * 0.5)))
        CurrentCamera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
            t4.utility.anti_trace()
            t10.value107 = math.tan((math.rad(CurrentCamera.FieldOfView * 0.5)))
        end)
        local function v288(p15)
            t4.utility.anti_trace()

            local v427 = t10.value99[p15]

            if v427 ~= nil then
                return v427
            end

            local v428 = FindFirstChild(p15, "Torso")

            if not v428 then
                t10.value99[p15] = false

                return false
            end

            local v429 = not not FindFirstChild(v428, "LeftBooster")

            t10.value99[p15] = v429

            return v429
        end
        local function v289(p16)
            t4.utility.anti_trace()

            local v431 = FindFirstChild(p16, "LowerTorso")

            if not v431 then
                return false
            end

            local v432 = FindFirstChild(v431, "RootRig")

            if not v432 then
                return false
            end

            if typeof(v432.CurrentAngle) == "number" and v432.CurrentAngle ~= 0 then
                return true
            end

            return false
        end
        local function v290(p17)
            t4.utility.anti_trace()
            local GetChildren = p17.GetChildren
            local t18 = {}
            for v438, v439 in _ipairs(GetChildren(p17)) do

                if v439:IsA("BasePart") then
                    insert(t18, v439)
                end
            end
            if #t18 ~= 2 then
                return false
            end
            local v440 = t18[1].Material == Enum.Material.Fabric
            if v440 then
                v440 = t18[2].Material == Enum.Material.Metal
            end
            if not v440 then
                v440 = t18[1].Material == Enum.Material.Metal

                if v440 then
                    v440 = t18[2].Material == Enum.Material.Fabric
                end
            end

            return v440
        end
        t10.value108 = {
			Bow = {
				"Arrow",
				"Fabric",
				"Meshes/Bow",
				"Handle",
				"AnimationController"
			},
			AR15 = {
				"AnimSaves",
				"Barrel",
				"Body",
				"Bolt",
				"ChargingHandle",
				"Decor",
				"Grip",
				"Handle",
				"Mag",
				"Rails",
				"Stock",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			Bandage = {
				"Handle",
				"Bandage",
				"AnimationController"
			},
			Beans = {
				"Beans",
				"Handle",
				"AnimationController"
			},
			BloxyCola = {
				"Bloxy Cola HD",
				"Handle",
				"AnimationController"
			},
			Blunderbuss = {
				"Body",
				"Handle",
				"Tube",
				"thing",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			C9 = {
				"Barrel",
				"Body",
				"Bolt",
				"Decor",
				"Grip",
				"Handle",
				"LowerSlide",
				"Mag",
				"Sight1",
				"Sight2",
				"UpperSlide",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			CrossBow = {
				"AnimationController",
				"FrontNails",
				"SpringSteel",
				"Body",
				"Slide",
				"Release",
				"Wheel",
				"BackMetal",
				"String",
				"Arrow",
				"Handle",
				"ADS"
			},
			EnergyRifle = {
				"DefaultSight",
				"FrontCover",
				"Glowing",
				"Grip",
				"Handle",
				"Mag",
				"Metal",
				"Metal2",
				"RearCover",
				"RearDecor",
				"Screws",
				"Tubes",
				"AnimationController"
			},
			FlameThrower = {
				"Barrel",
				"Body",
				"Decor",
				"Grip",
				"Handle",
				"Hoses",
				"LowerTank",
				"Mag",
				"Strap",
				"Tubes",
				"Particle",
				"AnimationController"
			},
			GaussRifle = {
				"DefaultSight",
				"Barrel",
				"Body",
				"CoilHolders",
				"Coils",
				"Decals1",
				"Decals2",
				"Grip",
				"Handle",
				"Housing",
				"Mag",
				"StockBack",
				"AnimationController"
			},
			HMAR = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Bolts",
				"Cover",
				"Handle",
				"Mag",
				"Rails",
				"Spring",
				"Stock",
				"Wood",
				"Muzzle",
				"AnimationController"
			},
			HealingBandage = {
				"Handle",
				"Bandage",
				"AnimationController"
			},
			LeverActionRifle = {
				"9mm",
				"DefaultSight",
				"Body",
				"Brass",
				"Hammer",
				"Handle",
				"Lever",
				"Metal",
				"Thing",
				"Wood",
				"Muzzle",
				"AnimationController"
			},
			M4A1 = {
				"DefaultSight",
				"Body",
				"Bolt",
				"ChargeHandle",
				"Grip",
				"Handle",
				"Mag",
				"Metal",
				"mbrk",
				"Muzzle",
				"AnimationController"
			},
			MedSerum = {
				"Body",
				"Cross",
				"Handle",
				"Injector",
				"Plunger",
				"Spring",
				"AnimationController"
			},
			MiningDrill = {
				"Bearings",
				"Body",
				"DrillBit",
				"Handle",
				"Inlets",
				"Tubes",
				"VisualHandle",
				"AnimationController"
			},
			PipePistol = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Handle",
				"Mag",
				"Muzzle",
				"AnimationController",
				"Animator"
			},
			PipeSMG = {
				"DefaultSight",
				"Barrel",
				"Body",
				"Bolt",
				"Flap",
				"Grip",
				"Handle",
				"Mag",
				"Stock",
				"Muzzle",
				"AnimationController"
			},
			PumpShotgun = {
				"Barrel",
				"Body",
				"Handle",
				"MainMetal",
				"RearSight",
				"Shell",
				"Slider",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			RPG = {
				"RocketModel",
				"Body",
				"Body2",
				"Caps",
				"Fasteners",
				"FireMech",
				"Handle",
				"Safety",
				"Sight",
				"Trigger",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			SCAR = {
				"DefaultSight",
				"Barrel",
				"Body",
				"ChargingHandle",
				"Decals",
				"Handle",
				"Mag",
				"Rails",
				"ShoulderPad",
				"Stock",
				"Muzzle",
				"AnimationController"
			},
			SVD = {
				"DefaultSight",
				"Body",
				"Bolt",
				"Handle",
				"Magazine",
				"Magazine2",
				"Metal2",
				"Wood",
				"AnimationController"
			},
			USP9 = {
				"Body",
				"Handle",
				"Mag",
				"Slide",
				"ADS",
				"Muzzle",
				"AnimationController"
			},
			UZI = {
				"DefaultSight",
				"Body",
				"Body2",
				"Bolt",
				"ChargingHandle",
				"Decor",
				"Grip",
				"Handle",
				"Mag",
				"Stock",
				"Muzzle",
				"AnimationController"
			}
		}
        function t10.value109(p18)
            t4.utility.anti_trace()
            task.delay(0.3, function()
                t4.utility.anti_trace()

                local v873 = not p18

                if not v873 then
                    v873 = not p18.Parent
                end

                if v873 then
                    return
                end

                local v874 = FindFirstChild(p18, "HandModel")

                if not v874 then
                    t10.value98[p18] = "None"

                    return
                end

                local s1 = "None"
                local n2 = 0

                for v877, v878 in _pairs(t10.value108) do
                    t4.utility.anti_trace()

                    local n3 = 0

                    for _, v881 in _ipairs(v878) do
                        if v874:FindFirstChild(v881, true) then
                            n3 += 1
                        end
                    end

                    if n2 < n3 then
                        s1 = v877
                        n2 = n3
                    end
                end

                t10.value98[p18] = s1
            end)
        end
        function t10.value110(p19)
            t4.utility.anti_trace()

            if t10.value100[p19] then
                return
            end

            t10.value100[p19] = true
            spawn(function()
                t4.utility.anti_trace()
                local u882
                local t19 = {}
                local function v884()
                    for _, v932 in _ipairs(t19) do
                        local v933 = v932

                        pcall(function()
                            t4.utility.anti_trace()
                            v933:Disconnect()
                        end)
                    end

                    t19 = {}
                end
                while true do
                    local v885 = p19

                    if v885 then
                        v885 = p19.Parent
                    end

                    if not v885 then
                        break
                    end

                    t4.utility.anti_trace()

                    local v886 = FindFirstChild(p19, "HandModel")

                    if v886 ~= u882 then
                        if v886 then
                            (function(p20)
                                t4.utility.anti_trace()
                                v884()
                                u882 = p20
                                insert(t19, p20.DescendantAdded:Connect(function()
                                    t4.utility.anti_trace()
                                    t10.value109(p19)
                                end))
                                insert(t19, p20.DescendantRemoving:Connect(function()
                                    t4.utility.anti_trace()
                                    t10.value109(p19)
                                end))
                                t10.value109(p19)
                            end)(v886)
                        else
                            v884()
                            u882 = nil
                            t10.value98[p19] = "None"
                        end
                    end

                    wait(1.5)
                end
                v884()
            end)
        end
        function t10.value111()
            t4.utility.anti_trace()

            local drawing = Drawing.new("Square")

            drawing.Visible = false
            drawing.Filled = false
            drawing.Thickness = 1
            t4.drawings[drawing] = drawing

            local drawing2 = Drawing.new("Text")

            drawing2.Visible = false
            drawing2.Size = 13
            drawing2.Center = true
            drawing2.Font = 2
            drawing2.Outline = false
            t4.drawings[drawing2] = drawing2

            local drawing3 = Drawing.new("Text")

            drawing3.Visible = false
            drawing3.Size = 12
            drawing3.Center = true
            drawing3.Font = 2
            drawing3.Outline = false
            t4.drawings[drawing3] = drawing3

            local drawing4 = Drawing.new("Text")

            drawing4.Visible = false
            drawing4.Size = 12
            drawing4.Center = true
            drawing4.Font = 2
            drawing4.Outline = false
            t4.drawings[drawing4] = drawing4

            return {
				box = drawing,
				nameText = drawing2,
				weaponText = drawing3,
				distanceText = drawing4
			}
        end
        function t10.value112(p21)
            t4.utility.anti_trace()

            if p21.box then
                p21.box.Visible = false
            end

            if p21.nameText then
                p21.nameText.Visible = false
            end

            if p21.weaponText then
                p21.weaponText.Visible = false
            end

            if p21.distanceText then
                p21.distanceText.Visible = false
            end
        end
        local function v291(p22)
            t4.utility.anti_trace()

            while p22 do
                if t10.value94[p22.Name] then
                    return true
                end

                p22 = p22.Parent
            end

            return false
        end
        function t10.value113(p23, p24)
            t4.utility.anti_trace()

            for match in string.gmatch(p24, "[^/]+") do
                p23 = p23:FindFirstChild(match)

                if not p23 then
                    return nil
                end
            end

            return p23
        end
        function t10.value114(p25)
            t4.utility.anti_trace()

            if not p25:IsA("BasePart") then
                return
            end

            if not t10.value60 then
                return
            end

            if v291(p25) then
                return
            end

            if not t10.value65[p25] then
                local value65 = t10.value65
                local p25Material = p25.Material
                local p25Color = p25.Color
                local p25Transparency = p25.Transparency
                local Reflectance = p25.Reflectance

                value65[p25] = {
					material = p25Material,
					color = p25Color,
					transparency = p25Transparency,
					reflectance = Reflectance
				}
            end

            p25.Material = Enum.Material[t10.value61]
            p25.Color = t10.value63
            p25.Transparency = t10.value62
            p25.Reflectance = 0

            local t20 = {
				p25:GetPropertyChangedSignal("Material"):Connect(function()
                t4.utility.anti_trace()

                local value60 = t10.value60

                if value60 then
                    value60 = p25.Material ~= Enum.Material[t10.value61]
                end

                if value60 then
                    p25.Material = Enum.Material[t10.value61]
                end
            end),
				p25:GetPropertyChangedSignal("Color"):Connect(function()
                t4.utility.anti_trace()

                local value60 = t10.value60

                if value60 then
                    value60 = p25.Color ~= t10.value63
                end

                if value60 then
                    p25.Color = t10.value63
                end
            end),
				(p25:GetPropertyChangedSignal("Transparency"):Connect(function()
                t4.utility.anti_trace()

                local value60 = t10.value60

                if value60 then
                    value60 = p25.Transparency ~= t10.value62
                end

                if value60 then
                    p25.Transparency = t10.value62
                end
            end))
			}

            t10.value64[p25] = t20
        end
        function t10.value115(p26)
            t4.utility.anti_trace()

            if t10.value65[p26] then
                local v462 = t10.value65[p26]

                p26.Material = v462.material
                p26.Color = v462.color
                p26.Transparency = v462.transparency
                p26.Reflectance = v462.reflectance
                t10.value65[p26] = nil
            end

            if t10.value64[p26] then
                for _, v464 in _ipairs(t10.value64[p26]) do
                    v464:Disconnect()
                end

                t10.value64[p26] = nil
            end
        end
        local function v292(p27, p28)
            t4.utility.anti_trace()

            for _, v468 in _ipairs(p28) do
                local v469 = if not string.find(v468, "/") then p27:FindFirstChild(v468, true) else t10.value113(p27, v468)
                local v470 = v469

                if v469 then
                    v470 = not v291(v469)

                    if v470 then
                        v470 = v469:IsA("BasePart")
                    end
                end

                if v470 then
                    t10.value114(v469)
                end
            end
        end
        function t10.value116()
            t4.utility.anti_trace()
            for v473 in _pairs(t10.value65) do

                local v474 = v473

                if v473 then
                    v474 = v473.Parent
                end

                if v474 then
                    t10.value115(v473)
                end
            end
            for _, v476 in _pairs(t10.value64) do
                for _, v478 in _ipairs(v476) do
                    v478:Disconnect()
                end
            end
            t10.value64 = {}
        end
        function t10.value117()
            t4.utility.anti_trace()
            t10.value116()

            if not t10.value60 then
                return
            end

            local v479 = v92
            local v480, v481, v482 = _ipairs(t10.value95)

            repeat
                local v483

                v482, v483 = v480(v481, v482)

                if not v482 then
                    for _, v485 in _ipairs(v479:GetChildren()) do
                        local v486 = v485

                        if t10.value96[v486.Name] then
                            v292(v486, t10.value96[v486.Name])

                            local connection3 = v486.DescendantAdded:Connect(function(descendant)
                                t4.utility.anti_trace()

                                if not t10.value60 then
                                    return
                                end

                                if not descendant:IsA("BasePart") then
                                    return
                                end

                                if v291(descendant) then
                                    return
                                end

                                for _, v892 in _ipairs(t10.value96[v486.Name]) do
                                    if v892 == descendant.Name then
                                        t10.value114(descendant)
                                    end
                                end
                            end)

                            t10.value64[v486] = { connection3 }
                        end
                    end

                    local connection5 = v479.ChildAdded:Connect(function(child)
                        t4.utility.anti_trace()

                        local value60 = t10.value60

                        if value60 then
                            value60 = t10.value96[child.Name]
                        end

                        if value60 then
                            v292(child, t10.value96[child.Name])

                            local connection4 = child.DescendantAdded:Connect(function(descendant)
                                t4.utility.anti_trace()

                                if not t10.value60 then
                                    return
                                end

                                if not descendant:IsA("BasePart") then
                                    return
                                end

                                if v291(descendant) then
                                    return
                                end

                                for _, v937 in _ipairs(t10.value96[child.Name]) do
                                    if v937 == descendant.Name then
                                        t10.value114(descendant)
                                    end
                                end
                            end)

                            t10.value64[child] = { connection4 }
                        end
                    end)

                    t10.value64.Root = { connection5 }

                    return
                end

                v479 = v479:FindFirstChild(v483)
            until not v479
        end
        function t10.value118(p29)
            t4.utility.anti_trace()
            if not p29:IsA("BasePart") then
                return
            end
            if not t10.value66 then
                return
            end
            local v490 = false
            local v491, v492, v493 = _ipairs({
				"RightHand",
				"LeftHand",
				"Hand_R",
				"Hand_L",
				"Right Hand",
				"Left Hand",
				"LowerArm_L",
				"LowerArm_R",
				"Forearm_L",
				"Forearm_R",
				"LowerArm",
				"LeftLowerArm",
				"RightLowerArm",
				"Left Forearm",
				"Right Forearm"
			})
            local g495
            repeat
                local v494

                v493, v494 = v491(v492, v493)

                if not v493 then
                    g495 = true
                end

                if g495 then
                    break
                end
            until v494 == p29.Name
            if not g495 then
                v490 = true
            end
            g495 = false
            if not v490 then
                local p29Parent = p29.Parent

                if p29Parent then
                    p29Parent = p29Parent.Name == "Fake"
                end

                if p29Parent then
                    local v497 = string.find(p29.Name, "LowerArm")

                    if not v497 then
                        v497 = string.find(p29.Name, "Forearm")

                        if not v497 then
                            v497 = p29.Name == "Arm_L"

                            if not v497 then
                                v497 = p29.Name == "Arm_R"
                            end
                        end
                    end

                    if v497 then
                        v490 = true
                    end
                end
            end
            if not v490 then
                return
            end
            if not t10.value71[p29] then
                local value71 = t10.value71
                local p29Material = p29.Material
                local p29Color = p29.Color
                local p29Transparency = p29.Transparency
                local Reflectance = p29.Reflectance

                value71[p29] = {
					material = p29Material,
					color = p29Color,
					transparency = p29Transparency,
					reflectance = Reflectance
				}
            end
            p29.Material = Enum.Material[t10.value67]
            p29.Color = t10.value69
            p29.Transparency = t10.value68
            p29.Reflectance = 0
            local connection6 = p29:GetPropertyChangedSignal("Material"):Connect(function()
                t4.utility.anti_trace()

                local value66 = t10.value66

                if value66 then
                    value66 = p29.Material ~= Enum.Material[t10.value67]
                end

                if value66 then
                    p29.Material = Enum.Material[t10.value67]
                end
            end)
            local connection7 = p29:GetPropertyChangedSignal("Color"):Connect(function()
                t4.utility.anti_trace()

                local value66 = t10.value66

                if value66 then
                    value66 = p29.Color ~= t10.value69
                end

                if value66 then
                    p29.Color = t10.value69
                end
            end)
            local connection8 = p29:GetPropertyChangedSignal("Transparency"):Connect(function()
                t4.utility.anti_trace()

                local value66 = t10.value66

                if value66 then
                    value66 = p29.Transparency ~= t10.value68
                end

                if value66 then
                    p29.Transparency = t10.value68
                end
            end)
            t10.value70[p29] = {
				connection6,
				connection7,
				connection8
			}
        end
        local function v293(p30)
            t4.utility.anti_trace()

            if t10.value71[p30] then
                local v507 = t10.value71[p30]

                p30.Material = v507.material
                p30.Color = v507.color
                p30.Transparency = v507.transparency
                p30.Reflectance = v507.reflectance
                t10.value71[p30] = nil
            end

            if t10.value70[p30] then
                for _, v509 in _ipairs(t10.value70[p30]) do
                    v509:Disconnect()
                end

                t10.value70[p30] = nil
            end
        end
        local function v294()
            t4.utility.anti_trace()
            for v512 in _pairs(t10.value71) do

                local v513 = v512

                if v512 then
                    v513 = v512.Parent
                end

                if v513 then
                    v293(v512)
                end
            end
            for _, v515 in _pairs(t10.value70) do
                for _, v517 in _ipairs(v515) do
                    v517:Disconnect()
                end
            end
            t10.value70 = {}
        end
        local function v295()
            t4.utility.anti_trace()
            v294()

            if not t10.value66 then
                return
            end

            local v518 = FindFirstChild(v92, "Const")

            if not v518 then
                return
            end

            local v519 = FindFirstChild(v518, "Ignore")

            if not v519 then
                return
            end

            local v520 = FindFirstChild(v519, "FPSArms")

            if not v520 then
                return
            end

            for _, v522 in _pairs(v520:GetChildren()) do
                if v522:IsA("BasePart") then
                    t10.value118(v522)
                end
            end

            local v523 = FindFirstChild(v520, "Fake")

            if v523 then
                local GetChildren = v523.GetChildren

                for _, v526 in _pairs(GetChildren(v523)) do
                    if v526:IsA("BasePart") then
                        t10.value118(v526)
                    end
                end
            end

            local connection9 = v520.ChildAdded:Connect(function(child)
                t4.utility.anti_trace()

                if not t10.value66 then
                    return
                end

                if child:IsA("BasePart") then
                    t10.value118(child)
                end
            end)

            if v523 then
                local connection10 = v523.ChildAdded:Connect(function(child)
                    t4.utility.anti_trace()

                    if not t10.value66 then
                        return
                    end

                    if child:IsA("BasePart") then
                        t10.value118(child)
                    end
                end)

                t10.value70.Fake = { connection10 }
            end

            t10.value70.Root = { connection9 }
        end
        t10.value119 = RaycastParams.new()
        t10.value119.FilterType = Enum.RaycastFilterType.Exclude
        function t10.value120(p31)
            t4.utility.anti_trace()

            if not p31 then
                return false
            end

            t10.value119.FilterDescendantsInstances = {
				LocalPlayer.Character,
				p31.Parent,
				CurrentCamera
			}

            local CFramePosition = CurrentCamera.CFrame.Position
            local v531 = p31.Position - CFramePosition
            local v532 = v92
            local value119 = t10.value119

            return Raycast(v532, CFramePosition, v531, value119) == nil
        end
        function t10.value121()
            t10.value56 = {}
            local MouseLocation = v98:GetMouseLocation()
            for v537, v538 in _ipairs(t10.value106) do

                t4.utility.anti_trace()

                if v538 ~= LocalPlayer.Character then
                    local v539

                    if t10.value55 == "Head" then
                        v539 = FindFirstChild(v538, "Head")
                    else
                        v539 = FindFirstChild(v538, "HumanoidRootPart")

                        if not v539 then
                            v539 = FindFirstChild(v538, "UpperTorso")

                            if not v539 then
                                v539 = FindFirstChild(v538, "LowerTorso")
                            end
                        end
                    end

                    if v539 and (CurrentCamera.CFrame.Position - v539.Position).Magnitude <= t10.value50 then
                        local v541, t21Result = WorldToViewportPoint(CurrentCamera, v539.Position)
                        if t21Result then
                            local Magnitude = (new2(v541.X, v541.Y) - MouseLocation).Magnitude

                            if Magnitude <= t10.value49 and (not t10.value51 or t10.value120(v539)) then
                                local v543 = insert
                                local value56 = t10.value56
                                local v545 = new2(v541.X, v541.Y)

                                v543(value56, {
									part = v539,
									pos = v545,
									dist = Magnitude
								})
                            end
                        end
                    end
                end
            end
            if #t10.value56 > 0 then
                sort(t10.value56, function(p32, p33)
                    return p32.dist < p33.dist
                end)
                t10.value52 = t10.value56[1].part
                t10.value53 = t10.value56[1].pos

                return
            end
            t10.value52 = nil
            t10.value53 = nil
        end
        local function v296(p34)
            t4.utility.anti_trace()
            if not t10.value46 then
                return
            end
            if not IsA(p34, "BasePart") then
                return
            end
            local u547 = false
            local u548
            u548 = p34:GetPropertyChangedSignal("CFrame"):Connect(function()
                t4.utility.anti_trace()

                if not p34.Parent then
                    if u548 then
                        u548:Disconnect()
                        u548 = nil
                    end

                    return
                end

                local v903 = not u547

                if v903 then
                    v903 = (CurrentCamera.CFrame.Position - p34.Position).Magnitude < 2
                end

                if v903 then
                    u547 = true
                end

                local v904 = t10.value54 or t10.value52
                local v905 = u547

                if v905 then
                    v905 = v904 and v904.Parent
                end

                if v905 then
                    local v906 = FindFirstChild(v904.Parent, "HumanoidRootPart") or v904

                    if v906 then
                        pcall(function()
                            t4.utility.anti_trace()
                            v906.CFrame = new(p34.Position.X, v906.Position.Y, p34.Position.Z)
                        end)
                    end
                end
            end)
            p34.AncestryChanged:Connect(function(_, parent)
                t4.utility.anti_trace()

                if not parent and u548 then
                    u548:Disconnect()
                end
            end)
        end
        local Const = v92:FindFirstChild("Const")
        if Const then
            Const = v92.Const:FindFirstChild("Ignore")
        end
        if Const then
            v92.Const.Ignore.ChildAdded:Connect(function(child)
                t4.utility.anti_trace()

                local v550 = IsA(child, "BasePart")

                if v550 then
                    v550 = child.Name == "Arrow"

                    if not v550 then
                        v550 = child.Name == "Bullet"

                        if not v550 then
                            v550 = child.Name == "BulletBlue"
                        end
                    end
                end

                if v550 then
                    v296(child)
                end
            end)
        end
        LocalPlayer.CharacterAdded:Connect(function()
            t4.utility.anti_trace()
            t10.value52 = nil
            t10.value53 = nil
        end)
        function t10.value122(p36)
            t4.utility.anti_trace()

            if not p36 then
                return nil
            end

            local v552 = FindFirstChild(p36, "Head")

            if v552 then
                return v552
            end

            local v553 = FindFirstChild(p36, "UpperTorso")

            if not v553 then
                v553 = FindFirstChild(p36, "LowerTorso")

                if not v553 then
                    v553 = FindFirstChild(p36, "HumanoidRootPart")
                end
            end

            return v553
        end
        local function v298(p37, p38)
            t4.utility.anti_trace()

            if t10.value101[p37] then
                return
            end

            local drawing = Drawing.new("Text")

            drawing.Text = p38
            drawing.Color = t10.value103[p38:lower()]
            drawing.Size = 13
            drawing.Center = true
            drawing.Outline = false
            drawing.Font = 3
            drawing.Visible = false
            t10.value101[p37] = {
				name = drawing,
				type = p38
			}
            t4.drawings[drawing] = drawing
        end
        function t10.value123(p39)
            t4.utility.anti_trace()

            if t10.value92[p39] then
                return
            end

            local drawing = Drawing.new("Text")

            drawing.Text = "Corpse"
            drawing.Color = t10.value88
            drawing.Size = 13
            drawing.Center = true
            drawing.Outline = false
            drawing.Font = 3
            drawing.Visible = false
            t10.value92[p39] = drawing
            t4.drawings[drawing] = drawing
        end
        local function v299(p40, p41)
            t4.utility.anti_trace()

            local GetChildren = p41.GetChildren

            for _, v565 in _ipairs(GetChildren(p41)) do
                if not p40:FindFirstChild(v565.Name) then
                    return false
                end
            end

            return true
        end;
        (function()
            t4.utility.anti_trace()

            local Shared = v99:FindFirstChild("Shared")

            if Shared then
                local entities = Shared:FindFirstChild("entities")

                if entities then
                    local vehicles = entities:FindFirstChild("vehicles")

                    if vehicles then
                        local ATV = vehicles:FindFirstChild("ATV")

                        if ATV then
                            ATV = vehicles.ATV:FindFirstChild("Model")
                        end

                        local Boat = vehicles:FindFirstChild("Boat")

                        if Boat then
                            Boat = vehicles.Boat:FindFirstChild("Model")
                        end

                        local Helicopter = vehicles:FindFirstChild("Helicopter")

                        if Helicopter then
                            Helicopter = vehicles.Helicopter:FindFirstChild("Model")
                        end

                        local Trolly = vehicles:FindFirstChild("Trolly")

                        if Trolly then
                            Trolly = vehicles.Trolly:FindFirstChild("Model")
                        end

                        t10.value105 = {
							ATV = ATV,
							Boat = Boat,
							Helicopter = Helicopter,
							Trolly = Trolly
						}
                    end
                end
            end
        end)()
        local function v300(p42)
            t4.utility.anti_trace()

            if IsA(p42, "Model") then
                local v581 = FindFirstChild(p42, "HumanoidRootPart")

                if not v581 then
                    v581 = FindFirstChild(p42, "LowerTorso")
                end

                if v581 then
                    v581 = p42.Name ~= LocalPlayer.Name
                end

                if v581 then
                    local value106 = t10.value106

                    insert(value106, p42)
                end
            end
        end
        local function v301(p43)
            t4.utility.anti_trace()

            for i = #t10.value106, 1, -1 do
                local v585 = i

                if p43 == t10.value106[v585] then
                    remove(t10.value106, v585)
                end
            end
        end
        for _, v303 in _pairs(v92:GetChildren()) do
            t4.utility.anti_trace()
            t4.utility.anti_trace()

            if v303 then
                local v304 = not FindFirstChild(v303, "Head")

                if v304 then
                    v304 = not FindFirstChild(v303, "LowerTorso")
                end

                if not v304 then
                    t10.value1[v303] = v303
                end
            end

            v300(v303)
        end;
        (function()
            t4.utility.anti_trace()

            for _, v574 in _ipairs(v92:GetChildren()) do
                if v574:IsA("Model") then
                    if not t10.value101[v574] then
                        for v575, v576 in _pairs(t10.value105) do
                            local v577 = v576

                            if v576 then
                                v577 = v299(v574, v576)
                            end

                            if v577 then
                                v298(v574, v575)

                                break
                            end
                        end
                    end

                    if not t10.value92[v574] and v290(v574) then
                        t10.value123(v574)
                    end

                    local v578 = not t10.value93[v574]

                    if v578 then
                        t4.utility.anti_trace()
                        v578 = v574:FindFirstChild("Union")

                        if v578 then
                            v578 = v574:FindFirstChild("Display") and v574:FindFirstChild("Part")
                        end
                    end

                    if v578 then
                        t4.utility.anti_trace()

                        if not t10.value93[v574] then
                            local drawing = Drawing.new("Text")

                            drawing.Text = "Item"
                            drawing.Color = t10.value91
                            drawing.Size = 13
                            drawing.Center = true
                            drawing.Outline = false
                            drawing.Font = 3
                            drawing.Visible = false
                            t10.value93[v574] = drawing
                            t4.drawings[drawing] = drawing
                        end
                    end
                end
            end
        end)()
        v92.ChildAdded:Connect(function(child)
            t4.utility.anti_trace()
            t4.utility.anti_trace()

            if child then
                local v590 = not FindFirstChild(child, "Head")

                if v590 then
                    v590 = not FindFirstChild(child, "LowerTorso")
                end

                if not v590 then
                    t10.value1[child] = child
                end
            end

            v300(child)

            if child:IsA("Model") then
                if not t10.value101[child] then
                    for v591, v592 in _pairs(t10.value105) do
                        if v592 and v299(child, v592) then
                            v298(child, v591)

                            break
                        end
                    end
                end

                if not t10.value92[child] and v290(child) then
                    t10.value123(child)
                end

                local v593 = not t10.value93[child]

                if v593 then
                    t4.utility.anti_trace()
                    v593 = child:FindFirstChild("Union")

                    if v593 then
                        v593 = child:FindFirstChild("Display") and child:FindFirstChild("Part")
                    end
                end

                if v593 then
                    t4.utility.anti_trace()

                    if t10.value93[child] then
                        return
                    end

                    local drawing = Drawing.new("Text")

                    drawing.Text = "Item"
                    drawing.Color = t10.value91
                    drawing.Size = 13
                    drawing.Center = true
                    drawing.Outline = false
                    drawing.Font = 3
                    drawing.Visible = false
                    t10.value93[child] = drawing
                    t4.drawings[drawing] = drawing
                end
            end
        end)
        v92.ChildRemoved:Connect(function(child)
            t4.utility.anti_trace()
            t4.utility.anti_trace()

            if t10.value1[child] then
                t10.value1[child] = nil
            end

            v301(child)

            if t10.value97[child] then
                local v596 = t10.value97[child]

                v596.connection:Disconnect()

                if v596.box then
                    v596.box:Remove()
                end

                if v596.nameText then
                    v596.nameText:Remove()
                end

                if v596.weaponText then
                    v596.weaponText:Remove()
                end

                if v596.distanceText then
                    v596.distanceText:Remove()
                end

                t10.value97[child] = nil
                t10.value98[child] = nil
                t10.value99[child] = nil
            end

            if t10.value101[child] then
                if t10.value101[child].name then
                    t10.value101[child].name:Remove()
                end

                t10.value101[child] = nil
            end

            if t10.value92[child] then
                t10.value92[child]:Remove()
                t10.value92[child] = nil
            end

            if t10.value93[child] then
                t10.value93[child]:Remove()
                t10.value93[child] = nil
            end
        end)
        v261:toggle({
			name = "enable",
			def = false,
			callback = function(p44)
            t4.utility.anti_trace()
            t10.value85 = p44

            if not p44 then

                for v600, v601 in _pairs(t10.value92) do

                    if v601 then
                        v601.Visible = false
                    end
                end
                for _, v603 in _pairs(t10.value93) do
                    if v603 then
                        v603.Visible = false
                    end
                end
            end
        end
		})
        v261:toggle({
			name = "corpse esp",
			def = false,
			callback = function(p45)
            t4.utility.anti_trace()
            t10.value86 = p45
        end
		})
        v261:slider({
			name = "corpse max distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			suffix = "studs",
			callback = function(p46)
            t4.utility.anti_trace()
            t10.value87 = p46
        end
		})
        local _Color3 = Color3
        local colorpicker = v261.colorpicker
        local v307 = _Color3.fromRGB(255, 255, 255)
        colorpicker(v261, {
			name = "corpse color",
			def = v307,
			callback = function(p47)
            t4.utility.anti_trace()

            for _, v608 in _pairs(t10.value92) do
                if v608 then
                    v608.Color = p47
                end
            end
        end
		})
        v261:toggle({
			name = "item esp",
			def = false,
			callback = function(p48)
            t4.utility.anti_trace()
            t10.value89 = p48
        end
		})
        v261:slider({
			name = "item max distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			suffix = "studs",
			callback = function(p49)
            t4.utility.anti_trace()
            t10.value90 = p49
        end
		})
        local color3_13 = Color3.fromRGB(255, 255, 255)
        v261:colorpicker({
			name = "item color",
			def = color3_13,
			callback = function(p50)
            t4.utility.anti_trace()

            for _, v613 in _pairs(t10.value93) do
                if v613 then
                    v613.Color = p50
                end
            end
        end
		})
        v255:toggle({
			name = "enable",
			def = false,
			callback = function(p51)
            t4.utility.anti_trace()
            t10.value36 = p51
            t10.value59.Visible = p51

            if not p51 then
                t10.value43 = nil
            end
        end
		})
        v255:slider({
			name = "fov size",
			def = 80,
			max = 200,
			min = 10,
			rounding = true,
			callback = function(p52)
            t4.utility.anti_trace()
            t10.value37 = p52
            t10.value59.Radius = p52
        end
		})
        v255:slider({
			name = "smoothness",
			def = 5,
			max = 10,
			min = 1,
			rounding = true,
			callback = function(p53)
            t4.utility.anti_trace()
            t10.value38 = p53
        end
		})
        v255:slider({
			name = "working distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			callback = function(p54)
            t4.utility.anti_trace()
            t10.value39 = p54
        end
		})
        v255:toggle({
			name = "fov scanner",
			def = false,
			callback = function(p55)
            t4.utility.anti_trace()
            t10.value44 = p55

            if not p55 then
                t10.value59.Color = t10.value45
            end
        end
		})
        v255:toggle({
			name = "sleeper check",
			def = false,
			callback = function(p56)
            t4.utility.anti_trace()
            t10.value40 = p56
        end
		})
        v255:toggle({
			name = "bot check",
			def = false,
			callback = function(p57)
            t4.utility.anti_trace()
            t10.value41 = p57
        end
		})
        v255:toggle({
			name = "wall check",
			def = false,
			callback = function(p58)
            t4.utility.anti_trace()
            t10.value42 = p58
        end
		})
        local colorpicker2 = v255.colorpicker
        local color3_14 = Color3.fromRGB(255, 255, 255)
        colorpicker2(v255, {
			name = "fov color",
			def = color3_14,
			callback = function(p59)
            t4.utility.anti_trace()

            if not t10.value44 then
                t10.value59.Color = p59
            end
        end
		})
        v256:toggle({
			name = "enable",
			def = false,
			callback = function(p60)
            t4.utility.anti_trace()
            t10.value46 = p60

            if not p60 then
                t10.value57.Visible = false
                t10.value58.Visible = false
                t10.value52 = nil
                t10.value53 = nil
            end
        end
		})
        v256:slider({
			name = "snapline radius",
			def = 100,
			max = 100,
			min = 0,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v256:slider({
			name = "working distance",
			def = 1000,
			max = 1000,
			min = 0,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v256:dropdown({
			name = "bone",
			def = "Head",
			options = {
				"Head",
				"Body"
			},
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v256:toggle({
			name = "show snapline",
			def = false,
			callback = function(p64)
            t4.utility.anti_trace()
            t10.value48 = p64
        end
		})
        v256:toggle({
			name = "hit scanner",
			def = false,
			callback = function(p65)
            t4.utility.anti_trace()
            t10.value47 = p65
        end
		})
        v256:toggle({
			name = "wall check",
			def = false,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        local color3_15 = Color3.fromRGB(255, 255, 255)
        v256:colorpicker({
			name = "snapline color",
			def = color3_15,
			callback = function(p67)
            t4.utility.anti_trace()
            t10.value57.Color = p67
        end
		})
        v257:toggle({
			name = "enable",
			def = false,
			callback = function(p68)
            t4.utility.anti_trace()

            if t10.value2 then
                t10.value2:Disconnect()
            end

            if p68 then
                t4.utility.new_heartbeat(function()
                    t4.utility.anti_trace()
                    if _tick() - t10.value12 < t10.value13 then
                        return
                    end
                    local CFramePosition = CurrentCamera.CFrame.Position
                    local g917
                    for v910, _ in _pairs(t10.value1) do
                        local v912 = v910

                        t4.utility.anti_trace()

                        local v913 = v912

                        if v912 then
                            v913 = FindFirstChild(v912, "Head")
                        end

                        local v914 = v913

                        if not v914 then
                            continue
                        end

                        if (CFramePosition - v914.Position).Magnitude <= t10.value9 then
                            local v915 = v289(v912)
                            local v916 = v288(v912)

                            repeat
                                if not g917 and t10.value10 then
                                    if not v915 then
                                        g917 = true
                                    end
                                else
                                    g917 = false
                                    v915 = t10.value11 and not v916
                                end
                            until not g917

                            if not v915 then
                                pcall(function()
                                    t4.utility.anti_trace()

                                    if not t10.value15[v914] then
                                        t10.value15[v914] = v914.Color
                                    end

                                    v914.Size = t10.value4
                                    v914.Transparency = t10.value7
                                    v914.CanCollide = t10.value8
                                    v914.Color = t10.value14
                                end)
                            else
                                pcall(function()
                                    t4.utility.anti_trace()
                                    v914.Size = t10.value3
                                    v914.Transparency = 0
                                    v914.CanCollide = true

                                    if t10.value15[v914] then
                                        v914.Color = t10.value15[v914]
                                    end
                                end)
                            end

                            continue
                        end

                        pcall(function()
                            t4.utility.anti_trace()
                            v914.Size = t10.value3
                            v914.Transparency = 0
                            v914.CanCollide = true

                            if t10.value15[v914] then
                                v914.Color = t10.value15[v914]
                            end
                        end)
                    end
                end)

                return
            end

            for v632, _ in _pairs(t10.value1) do
                local v634 = v632

                t4.utility.anti_trace()

                if v634 then
                    v634 = FindFirstChild(v634, "Head")
                end

                local v635 = v634

                if v635 then
                    pcall(function()
                        t4.utility.anti_trace()
                        v635.Size = t10.value3
                        v635.Transparency = 0
                        v635.CanCollide = true

                        if t10.value15[v635] then
                            v635.Color = t10.value15[v635]
                        end
                    end)
                end
            end
        end
		})
        v257:slider({
			name = "transparency",
			def = 0.5,
			max = 1,
			min = 0,
			rounding = false,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v257:slider({
			name = "size x",
			def = 3,
			max = 6,
			min = 2,
			rounding = true,
			callback = function(p70)
            t4.utility.anti_trace()
            t10.value5 = p70
            new3(t10.value5, t10.value6, t10.value5)
        end
		})
        v257:slider({
			name = "size y",
			def = 3,
			max = 6,
			min = 2,
			rounding = true,
			callback = function(p71)
            t4.utility.anti_trace()
            t10.value6 = p71
            new3(t10.value5, t10.value6, t10.value5)
        end
		})
        v257:slider({
			name = "working distance",
			def = 200,
			max = 1000,
			min = 50,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v257:toggle({
			name = "can collide",
			def = false,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v257:toggle({
			name = "sleeper check",
			def = false,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v257:toggle({
			name = "bot check",
			def = false,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        local colorpicker3 = v257.colorpicker
        local color3_16 = Color3.fromRGB(255, 255, 255)
        colorpicker3(v257, {
			name = "hitbox color",
			def = color3_16,
			callback = function(_)
            t4.utility.anti_trace()
        end
		})
        v258:toggle({
			name = "enable",
			def = false,
			callback = function(p77)
            t4.utility.anti_trace()
            t10.value16 = p77

            if not p77 then
                for _, v646 in _pairs(t10.value97) do
                    if v646.box then
                        v646.box.Visible = false
                    end

                    if v646.nameText then
                        v646.nameText.Visible = false
                    end

                    if v646.weaponText then
                        v646.weaponText.Visible = false
                    end

                    if v646.distanceText then
                        v646.distanceText.Visible = false
                    end
                end
            end
        end
		})
        v258:slider({
			name = "max distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			callback = function(p78)
            t4.utility.anti_trace()
            t10.value23 = p78
        end
		})
        v258:toggle({
			name = "box",
			def = false,
			callback = function(p79)
            t4.utility.anti_trace()
            t10.value17 = p79
        end
		})
        local color3_17 = Color3.fromRGB(255, 255, 255)
        v258:colorpicker({
			name = "box color",
			def = color3_17,
			callback = function(p80)
            t4.utility.anti_trace()
            t10.value24 = p80
        end
		})
        v258:toggle({
			name = "name",
			def = false,
			callback = function(p81)
            t4.utility.anti_trace()
            t10.value18 = p81
        end
		})
        local color3_18 = Color3.fromRGB(255, 255, 255)
        v258:colorpicker({
			name = "name color",
			def = color3_18,
			callback = function(p82)
            t4.utility.anti_trace()
            t10.value25 = p82
        end
		})
        v258:toggle({
			name = "weapon",
			def = false,
			callback = function(p83)
            t4.utility.anti_trace()
            t10.value19 = p83
        end
		})
        local color3_19 = Color3.fromRGB(255, 255, 255)
        v258:colorpicker({
			name = "weapon color",
			def = color3_19,
			callback = function(p84)
            t4.utility.anti_trace()
            t10.value26 = p84
        end
		})
        v258:toggle({
			name = "distance",
			def = false,
			callback = function(p85)
            t4.utility.anti_trace()
            t10.value20 = p85
        end
		})
        local color3_20 = Color3.fromRGB(255, 255, 255)
        v258:colorpicker({
			name = "distance color",
			def = color3_20,
			callback = function(p86)
            t4.utility.anti_trace()
            t10.value27 = p86
        end
		})
        v258:toggle({
			name = "hide sleeper",
			def = false,
			callback = function(p87)
            t4.utility.anti_trace()
            t10.value21 = p87
        end
		})
        v258:toggle({
			name = "hide bot",
			def = false,
			callback = function(p88)
            t4.utility.anti_trace()
            t10.value22 = p88
        end
		})
        v259:toggle({
			name = "enable",
			def = false,
			callback = function(p89)
            t4.utility.anti_trace()
            t10.value32 = p89

            if not p89 then
                for _, v660 in _pairs(t10.value35) do
                    if v660 then
                        v660.Visible = false
                    end
                end
            end
        end
		})
        v259:slider({
			name = "max distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			callback = function(p90)
            t4.utility.anti_trace()
            t10.value33 = p90
        end
		})
        v259:toggle({
			name = "stone",
			def = false,
			callback = function(p91)
            t4.utility.anti_trace()
            t10.value31.stone = p91
        end
		})
        local colorpicker4 = v259.colorpicker
        local color3_21 = Color3.fromRGB(128, 128, 128)
        colorpicker4(v259, {
			name = "stone color",
			def = color3_21,
			callback = function(p92)
            t4.utility.anti_trace()
            t10.value30.Cobblestone.Color = p92

            for v664, v665 in _pairs(t10.value35) do
                if IdentifyOre(v664) == "Cobblestone" then
                    v665.Color = p92
                end
            end
        end
		})
        v259:toggle({
			name = "iron",
			def = false,
			callback = function(p93)
            t4.utility.anti_trace()
            t10.value31.iron = p93
        end
		})
        local color3_22 = Color3.fromRGB(255, 200, 100)
        v259:colorpicker({
			name = "iron color",
			def = color3_22,
			callback = function(p94)
            t4.utility.anti_trace()
            t10.value30["Iron Ore"].Color = p94

            for v668, v669 in _pairs(t10.value35) do
                if IdentifyOre(v668) == "Iron Ore" then
                    v669.Color = p94
                end
            end
        end
		})
        v259:toggle({
			name = "nitrate",
			def = false,
			callback = function(p95)
            t4.utility.anti_trace()
            t10.value31.nitrate = p95
        end
		})
        local colorpicker5 = v259.colorpicker
        local color3_23 = Color3.fromRGB(255, 255, 255)
        colorpicker5(v259, {
			name = "nitrate color",
			def = color3_23,
			callback = function(p96)
            t4.utility.anti_trace()
            t10.value30["Nitrate Ore"].Color = p96

            for v672, v673 in _pairs(t10.value35) do
                if IdentifyOre(v672) == "Nitrate Ore" then
                    v673.Color = p96
                end
            end
        end
		})
        v260:toggle({
			name = "enable",
			def = false,
			callback = function(p97)
            t4.utility.anti_trace()
            t10.value102.master = p97

            if not p97 then
                for _, v676 in _pairs(t10.value101) do
                    if v676.name then
                        v676.name.Visible = false
                    end
                end
            end
        end
		})
        v260:slider({
			name = "max distance",
			def = 1000,
			max = 1000,
			min = 100,
			rounding = true,
			callback = function(p98)
            t4.utility.anti_trace()
            t10.value104 = p98
        end
		})
        v260:toggle({
			name = "ATV",
			def = false,
			callback = function(p99)
            t4.utility.anti_trace()
            t10.value102.atv = p99
        end
		})
        local color3_24 = Color3.fromRGB(255, 255, 255)
        v260:colorpicker({
			name = "ATV color",
			def = color3_24,
			callback = function(p100)
            t4.utility.anti_trace()
            t10.value103.atv = p100

            for _, v681 in _pairs(t10.value101) do
                if v681.type == "ATV" and v681.name then
                    v681.name.Color = p100
                end
            end
        end
		})
        v260:toggle({
			name = "Boat",
			def = false,
			callback = function(p101)
            t4.utility.anti_trace()
            t10.value102.boat = p101
        end
		})
        local _Color3_2 = Color3
        local colorpicker6 = v260.colorpicker
        local v326 = _Color3_2.fromRGB(255, 255, 255)
        colorpicker6(v260, {
			name = "Boat color",
			def = v326,
			callback = function(p102)
            t4.utility.anti_trace()
            t10.value103.boat = p102

            for _, v685 in _pairs(t10.value101) do
                if v685.type == "Boat" and v685.name then
                    v685.name.Color = p102
                end
            end
        end
		})
        v260:toggle({
			name = "Helicopter",
			def = false,
			callback = function(p103)
            t4.utility.anti_trace()
            t10.value102.helicopter = p103
        end
		})
        local color3_25 = Color3.fromRGB(255, 255, 255)
        v260:colorpicker({
			name = "Helicopter color",
			def = color3_25,
			callback = function(p104)
            t4.utility.anti_trace()
            t10.value103.helicopter = p104

            for _, v689 in _pairs(t10.value101) do
                if v689.type == "Helicopter" and v689.name then
                    v689.name.Color = p104
                end
            end
        end
		})
        v260:toggle({
			name = "Trolly",
			def = false,
			callback = function(p105)
            t4.utility.anti_trace()
            t10.value102.trolly = p105
        end
		})
        local color3_26 = Color3.fromRGB(255, 255, 255)
        v260:colorpicker({
			name = "Trolly color",
			def = color3_26,
			callback = function(p106)
            t4.utility.anti_trace()
            t10.value103.trolly = p106

            for _, v693 in _pairs(t10.value101) do
                if v693.type == "Trolly" and v693.name then
                    v693.name.Color = p106
                end
            end
        end
		})
        v262:toggle({
			name = "gun enable",
			def = false,
			callback = function(p107)
            t4.utility.anti_trace()
            t10.value60 = p107

            if p107 then
                t10.value117()

                return
            end

            t10.value116()
        end
		})
        v262:dropdown({
			name = "gun material",
			def = "Neon",
			options = t17,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value60 then
                t10.value117()
            end
        end
		})
        v262:slider({
			name = "gun transparency",
			def = 30,
			max = 100,
			min = 0,
			rounding = true,
			callback = function(p109)
            t4.utility.anti_trace()

            local _ = p109 / 100

            if t10.value60 then
                t10.value117()
            end
        end
		})
        local color3_27 = Color3.fromRGB(255, 255, 255)
        v262:colorpicker({
			name = "gun color",
			def = color3_27,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value60 then
                t10.value117()
            end
        end
		})
        v262:toggle({
			name = "arm enable",
			def = false,
			callback = function(p111)
            t4.utility.anti_trace()
            t10.value66 = p111

            if p111 then
                v295()

                return
            end

            v294()
        end
		})
        v262:dropdown({
			name = "arm material",
			def = "Neon",
			options = t17,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value66 then
                v295()
            end
        end
		})
        v262:slider({
			name = "arm transparency",
			def = 30,
			max = 100,
			min = 0,
			rounding = true,
			callback = function(p113)
            t4.utility.anti_trace()

            local _ = p113 / 100

            if t10.value66 then
                v295()
            end
        end
		})
        local color3_28 = Color3.fromRGB(255, 255, 255)
        v262:colorpicker({
			name = "arm color",
			def = color3_28,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value66 then
                v295()
            end
        end
		})
        v263:toggle({
			name = "enable time changer",
			def = false,
			callback = function(p115)
            t4.utility.anti_trace()
            t10.value29 = p115
        end
		})
        local v331 = round(v97.ClockTime)
        v263:slider({
			name = "time",
			def = v331,
			max = 24,
			min = 0,
			rounding = true,
			callback = function(p116)
            t4.utility.anti_trace()
            t10.value28 = p116
        end
		})
        v263:toggle({
			name = "enable custom sky",
			def = false,
			callback = function(p117)
            t4.utility.anti_trace()
            t10.value82 = p117

            if not p117 then
                v92.Terrain.Clouds.Color = Color3.new(1, 1, 1)
                v92.Terrain.Clouds.Cover = 0.6

                return
            end

            v92.Terrain.Clouds.Color = t10.value83
            v92.Terrain.Clouds.Cover = t10.value84
        end
		})
        local _Color3_3 = Color3
        local colorpicker7 = v263.colorpicker
        local v334 = _Color3_3.fromRGB(255, 255, 255)
        colorpicker7(v263, {
			name = "clouds color",
			def = v334,
			callback = function(p118)
            t4.utility.anti_trace()

            if t10.value82 then
                v92.Terrain.Clouds.Color = p118
            end
        end
		})
        v263:slider({
			name = "clouds cover",
			def = 0.6,
			max = 1,
			min = 0,
			rounding = false,
			callback = function(p119)
            t4.utility.anti_trace()

            if t10.value82 then
                v92.Terrain.Clouds.Cover = p119
            end
        end
		})
        v264:toggle({
			name = "enable",
			def = false,
			callback = function(_)
            t4.utility.anti_trace()
            v282()
        end
		})
        v264:toggle({
			name = "spin",
			def = false,
			callback = function(p121)
            t4.utility.anti_trace()
            t10.value74 = p121
        end
		})
        local color3_29 = Color3.fromRGB(255, 255, 255)
        v264:colorpicker({
			name = "color",
			def = color3_29,
			callback = function(p122)
            t4.utility.anti_trace()

            for _, v713 in _ipairs(t10.value72) do
                v713.Color = p122
            end
        end
		})
        v264:slider({
			name = "thickness",
			def = 2,
			max = 6,
			min = 1,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
            v282()
        end
		})
        v264:slider({
			name = "length",
			def = 8,
			max = 20,
			min = 4,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
            v282()
        end
		})
        v264:slider({
			name = "gap",
			def = 4,
			max = 12,
			min = 1,
			rounding = true,
			callback = function(_)
            t4.utility.anti_trace()
            v282()
        end
		})
        v264:slider({
			name = "spin speed",
			def = 1,
			max = 10,
			min = 0.1,
			rounding = true,
			callback = function(p126)
            t4.utility.anti_trace()
            t10.value79 = p126
        end
		})
        t10.value124 = false
        t10.value125 = false
        t10.value126 = 0.5
        t10.value127 = Enum.KeyCode.V
        t10.value128 = {}
        t10.value129 = {}
        t10.value130 = {
			Enum.Material.Cobblestone,
			Enum.Material.WoodPlanks,
			Enum.Material.Metal,
			Enum.Material.CorrodedMetal
		}
        function t10.value131()
            t10.value129 = {}
            local g729
            for _, v722 in _ipairs(v92:GetChildren()) do
                if v722:IsA("Model") then
                    for _, v724 in _ipairs(v722:GetDescendants()) do
                        local v725 = v724:IsA("BasePart")

                        if v725 then
                            local Material = v724.Material

                            for _, v728 in _ipairs(t10.value130) do
                                if v728 == Material then
                                    v725 = true
                                    g729 = true
                                end

                                if g729 then
                                    break
                                end
                            end

                            if not g729 then
                                v725 = false
                            end
                        end

                        g729 = false

                        if v725 then
                            insert(t10.value129, v724)

                            if t10.value128[v724] == nil then
                                t10.value128[v724] = v724.Transparency
                            end
                        end
                    end
                end
            end
        end
        local function v336(p127)
            if #t10.value129 == 0 then
                t10.value131()
            end

            for _, v732 in _ipairs(t10.value129) do
                local v733 = v732
                local v734 = v733

                if v734 then
                    v734 = v733.Parent
                end

                if v734 then
                    pcall(function()
                        t4.utility.anti_trace()

                        if p127 then
                            v733.Transparency = t10.value126

                            return
                        end

                        v733.Transparency = t10.value128[v733]
                    end)
                end
            end
        end
        v92.DescendantAdded:Connect(function(descendant)
            local v736 = descendant:IsA("BasePart")
            local g740
            if v736 then
                local descendantMaterial = descendant.Material

                g740 = nil

                for _, v739 in _ipairs(t10.value130) do
                    if v739 == descendantMaterial then
                        v736 = true
                        g740 = true
                    end

                    if g740 then
                        break
                    end
                end

                if not g740 then
                    v736 = false
                end
            end
            if v736 then
                insert(t10.value129, descendant)

                if t10.value128[descendant] == nil then
                    t10.value128[descendant] = descendant.Transparency
                end

                if t10.value125 then
                    pcall(function()
                        t4.utility.anti_trace()
                        descendant.Transparency = t10.value126
                    end)
                end
            end
        end)
        v265:toggle({
			name = "enable",
			def = false,
			callback = function(p128)
            t4.utility.anti_trace()
            t10.value124 = p128

            if not p128 and t10.value125 then
                t10.value125 = false
                v336(false)
            end
        end
		})
        v265:slider({
			name = "transparency",
			def = 0.5,
			max = 1,
			min = 0,
			rounding = false,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value125 then
                v336(true)
            end
        end
		})
        local V = Enum.KeyCode.V
        v265:keybind({
			name = "bind",
			def = V,
			callback = function(p130)
            t4.utility.anti_trace()
            t10.value127 = p130
        end
		})
        t10.value132 = false
        t10.value133 = false
        t10.value134 = 5
        t10.value135 = Enum.KeyCode.L
        t10.value136 = nil
        t10.value137 = nil
        t10.value138 = nil
        local function v338()
            t4.utility.anti_trace()

            local Const2 = v92.Const

            if Const2 then
                Const2 = v92.Const.Ignore

                if Const2 then
                    Const2 = v92.Const.Ignore.LocalCharacter
                end
            end

            if not Const2 then
                return nil, nil, nil
            end

            return Const2:FindFirstChild("Top"), Const2:FindFirstChild("Bottom"), (Const2:FindFirstChild("Middle"))
        end
        local function v339()
            t4.utility.anti_trace()

            if not t10.value137 then
                local v745, _, _ = v338()

                t10.value136 = v745

                local value136 = t10.value136

                if value136 then
                    value136 = t10.value136:FindFirstChild("Prism1")
                end

                if value136 then
                    t10.value138 = t10.value136.Prism1
                    t10.value137 = t10.value138.CFrame
                end
            end
        end
        local function v340(p131)
            t4.utility.anti_trace()

            if not t10.value138 then
                local v750, _, _ = v338()

                t10.value136 = v750

                local value136 = t10.value136

                if value136 then
                    value136 = t10.value136:FindFirstChild("Prism1")
                end

                if not value136 then
                    return
                end

                t10.value138 = t10.value136.Prism1
            end

            v339()
            pcall(function()
                t4.utility.anti_trace()

                if p131 then
                    t10.value138.CFrame = t10.value137 - Vector3.new(0, t10.value134, 0)

                    return
                end

                t10.value138.CFrame = t10.value137
            end)
        end
        v266:toggle({
			name = "enable",
			def = false,
			callback = function(p132)
            t4.utility.anti_trace()

            local v755 = not p132

            t10.value132 = p132

            if v755 then
                v755 = t10.value133
            end

            if v755 then
                t10.value133 = false
                v340(false)
            end
        end
		})
        v266:slider({
			name = "height",
			def = 3,
			max = 6,
			min = 1,
			rounding = false,
			callback = function(_)
            t4.utility.anti_trace()

            if t10.value133 then
                v340(true)
            end
        end
		})
        local L = Enum.KeyCode.L
        v266:keybind({
			name = "bind",
			def = L,
			callback = function(p134)
            t4.utility.anti_trace()
            t10.value135 = p134
        end
		})
        t4.utility.new_heartbeat(function()
            t4.utility.anti_trace()

            if t10.value29 then
                v97.ClockTime = t10.value28
            end
        end)
        v98.InputBegan:Connect(function(input, gameProcessed)
            t4.utility.anti_trace()

            if gameProcessed then
                return
            end

            if input.KeyCode == Enum.KeyCode.End then
                t4.utility.unload()

                local value2 = t9.value2

                if value2 then
                    value2 = t9.value2.hide
                end

                if value2 then
                    t9.value2:hide()
                end
            end

            if t10.value124 and input.KeyCode == t10.value127 then
                t10.value125 = not t10.value125

                if t10.value125 then
                    t10.value131()
                    v336(true)
                else
                    v336(false)
                end
            end

            if t10.value132 and input.KeyCode == t10.value135 then
                t10.value133 = not t10.value133
                v340(t10.value133)
            end
        end)
        function t10.value139(p135)
            t4.utility.anti_trace()

            if t10.value97[p135] then
                return
            end

            t10.value110(p135)

            local v762 = t10.value111()
            local connection11 = v96.RenderStepped:Connect(function()
                t4.utility.anti_trace()

                if not t10.value16 then
                    t10.value112(v762)

                    return
                end

                local v918 = FindFirstChild(p135, "HumanoidRootPart")
                local v919 = FindFirstChild(p135, "Head")
                local v920 = not v918

                if not v920 then
                    v920 = not v919
                end

                if v920 then
                    t10.value112(v762)

                    return
                end

                local v921 = v288(p135)
                local v922 = v289(p135)

                if t10.value22 and not v921 or t10.value21 and v922 then
                    t10.value112(v762)

                    return
                end

                local v923, v924 = WorldToViewportPoint(CurrentCamera, v918.Position)

                if not v924 then
                    t10.value112(v762)

                    return
                end

                local Magnitude = (CurrentCamera.CFrame.Position - v918.Position).Magnitude

                if Magnitude > t10.value23 then
                    t10.value112(v762)

                    return
                end

                local v926 = 1 / (v923.Z * t10.value107 * 2) * 100
                local v927 = floor(60 * v926)
                local v928 = floor(80 * v926)

                if v927 < 2 or v928 < 2 then
                    t10.value112(v762)

                    return
                end

                if t10.value17 then
                    v762.box.Size = new2(v927, v928)
                    v762.box.Position = new2(v923.X - v927 / 2, v923.Y - v928 / 2)
                    v762.box.Visible = true
                    v762.box.Color = t10.value24
                else
                    v762.box.Visible = false
                end

                local v929 = v922 and "sleeper"

                if not v929 then
                    v929 = not v921 and "bot" or "player"
                end

                local v930 = t10.value98[p135] or "None"

                if t10.value18 then
                    v762.nameText.Text = v929
                    v762.nameText.Position = new2(v923.X, v923.Y - v928 / 2 - 16)
                    v762.nameText.Visible = true
                    v762.nameText.Color = t10.value25
                else
                    v762.nameText.Visible = false
                end

                if t10.value19 then
                    v762.weaponText.Text = v930
                    v762.weaponText.Position = new2(v923.X, v923.Y + v928 / 2 - 0)
                    v762.weaponText.Visible = true
                    v762.weaponText.Color = t10.value26
                else
                    v762.weaponText.Visible = false
                end

                if t10.value20 then
                    if t10.value19 then
                        v762.distanceText.Position = new2(v923.X, v923.Y + v928 / 2 + 10)
                    else
                        v762.distanceText.Position = new2(v923.X, v923.Y + v928 / 2 - 1)
                    end

                    v762.distanceText.Text = floor(Magnitude) .. "m"
                    v762.distanceText.Visible = true
                    v762.distanceText.Color = t10.value27

                    return
                end

                v762.distanceText.Visible = false
            end)
            local value97 = t10.value97
            local box = v762.box
            local nameText = v762.nameText
            local weaponText = v762.weaponText
            local distanceText = v762.distanceText

            value97[p135] = {
				box = box,
				nameText = nameText,
				weaponText = weaponText,
				distanceText = distanceText,
				connection = connection11
			}
            t10.value109(p135)
        end
        function t10.value140(p136)
            t4.utility.anti_trace()
            if p136.Name ~= "Model" then
                return nil
            end
            if t10.value34[p136] then
                return t10.value34[p136].name, t10.value34[p136].config
            end
            local children = p136:GetChildren()
            local v771
            local v772
            local v773 = min(#children, 5)
            local v774, v775, v776 = _pairs(t10.value30)
            repeat
                local v777

                v776, v777 = v774(v775, v776)

                if not v776 then
                    break
                end

                t4.utility.anti_trace()

                local v778 = false
                local v779 = v776 == "Cobblestone"

                for i = 1, v773 do
                    local v781 = children[i]
                    local v782 = v781

                    if v781 then
                        v782 = v781:IsA("MeshPart") or v781:IsA("Part")
                    end

                    if v782 then
                        local v783 = true

                        if v781:IsA("MeshPart") then
                            v783 = v781.MeshId == v777.TextureID
                        end

                        if v783 then
                            local v784 = not v778

                            if v784 then
                                v784 = v781.Color == v777.Part1Color
                            end

                            if v784 then
                                v778 = true
                            else
                                local Part2Color = v777.Part2Color

                                if Part2Color then
                                    Part2Color = not v779

                                    if Part2Color then
                                        Part2Color = v781.Color == v777.Part2Color
                                    end
                                end

                                if Part2Color then
                                    v779 = true
                                end
                            end
                        end
                    end

                    if v778 and v779 then
                        v772 = v777
                        v771 = v776

                        break
                    end
                end
            until v778 and v779
            if v771 then
                t10.value34[p136] = {
					name = v771,
					config = v772
				}
            end

            return v771, v772
        end
        local function v342(p137, p138, p139)
            t4.utility.anti_trace()

            if t10.value35[p137] then
                t10.value35[p137]:Remove()
            end

            local drawing = Drawing.new("Text")

            drawing.Text = p138
            drawing.Color = p139.Color
            drawing.Size = 12
            drawing.Center = true
            drawing.Outline = false
            drawing.Font = 3
            drawing.Visible = false
            t10.value35[p137] = drawing
            t4.drawings[drawing] = drawing

            return drawing
        end
        local function v343(p140)
            t4.utility.anti_trace()
            local v791 = new3(0, 0, 0)
            local GetChildren = p140.GetChildren
            local n4 = 0
            for v796, v797 in _pairs(GetChildren(p140)) do

                t4.utility.anti_trace()

                if v797:IsA("BasePart") then
                    insert({}, v797)
                    v791 += v797.Position
                    n4 += 1
                end
            end
            if n4 > 0 then
                return v791 / n4
            end
            local v798 = FindFirstChild(p140, "Part")
            if not v798 then
                v798 = p140:FindFirstChildWhichIsA("BasePart")
            end

            return v798 and v798.Position or nil
        end;
        (function()
            t4.utility.anti_trace()

            for _, v800 in _pairs(v92:GetChildren()) do
                t4.utility.anti_trace()

                local v801 = v800:IsA("Model")

                if v801 then
                    v801 = not t10.value35[v800] and not t10.value34[v800]
                end

                if v801 then
                    local v802, v803 = t10.value140(v800)

                    if v802 then
                        v342(v800, v802, v803)
                    end
                end
            end
        end)()
        v92.DescendantAdded:Connect(function(descendant)
            t4.utility.anti_trace()

            if descendant:IsA("Model") then
                wait(1)

                if descendant.Parent and not t10.value35[descendant] then
                    local v805, v806 = t10.value140(descendant)

                    if v805 then
                        v342(descendant, v805, v806)
                    end
                end
            end
        end)
        v92.DescendantRemoving:Connect(function(descendant)
            t4.utility.anti_trace()

            if descendant:IsA("Model") and t10.value35[descendant] then
                t10.value35[descendant]:Remove()
                t10.value35[descendant] = nil
                t10.value34[descendant] = nil
            end
        end)
        for v346, v347 in _ipairs(v92:GetChildren()) do

            local v348 = v347

            t4.utility.anti_trace()

            local v349 = IsA(v348, "Model")

            if v349 then
                v349 = v348 ~= LocalPlayer.Character
            end

            if v349 then
                task.spawn(function()
                    t4.utility.anti_trace()
                    task.wait(0.1)

                    local v808 = FindFirstChild(v348, "HumanoidRootPart")

                    if v808 then
                        v808 = FindFirstChild(v348, "Head")
                    end

                    if v808 then
                        t10.value139(v348)
                    end
                end)
            end
        end
        v92.ChildAdded:Connect(function(child)
            t4.utility.anti_trace()

            local v810 = IsA(child, "Model")

            if v810 then
                v810 = child ~= LocalPlayer.Character
            end

            if v810 then
                task.wait(0.1)

                local v811 = FindFirstChild(child, "HumanoidRootPart")

                if v811 then
                    v811 = FindFirstChild(child, "Head")
                end

                if v811 then
                    t10.value139(child)
                end
            end
        end)
        for v350, _ in _pairs(t10.value1) do
            local v352 = v350

            t4.utility.anti_trace()

            if v352 then
                v352 = FindFirstChild(v352, "Head")
            end

            if v352 and not t10.value15[v352] then
                t10.value15[v352] = v352.Color
            end
        end
        t10.value141 = 0
        t10.value142 = 0
        t10.value143 = 0
        t10.value144 = 0
        t10.value145 = 0
        t10.value146 = 0
        t4.utility.new_renderstepped(function(p141)
            t4.utility.anti_trace()
            t10.value141 = t10.value141 + 1
            t10.value81()

            if t10.value74 then
                local v813 = p141 * t10.value79
                local _ = (t10.value80 + v813 * 2) % (n1 * 2)
            end

            t10.value142 = t10.value142 + 1

            if t10.value142 >= 3 and t10.value46 then
                t10.value121()
            end

            if t10.value46 then
                local MouseLocation = v98:GetMouseLocation()

                if t10.value48 and t10.value53 then
                    t10.value57.Visible = true
                    t10.value57.From = MouseLocation
                    t10.value57.To = t10.value53
                else
                    t10.value57.Visible = false
                end

                t10.value58.Visible = t10.value47 and t10.value52 ~= nil

                if t10.value58.Visible then
                    t10.value58.Position = new2(MouseLocation.X, MouseLocation.Y + 15)
                end
            else
                t10.value57.Visible = false
                t10.value58.Visible = false
            end

            if t10.value36 and t10.value141 % 2 == 0 then
                local MouseLocation = v98:GetMouseLocation()
                t10.value59.Position = MouseLocation
                local v817
                local value37 = t10.value37
                local v819 = false
                local value43 = t10.value43
                if value43 then
                    value43 = t10.value43.Parent
                end
                if value43 then
                    local v821 = t10.value122(t10.value43)

                    if v821 then
                        if (CurrentCamera.CFrame.Position - v821.Position).Magnitude <= t10.value39 then
                            local v823, t22Result = WorldToViewportPoint(CurrentCamera, v821.Position)
                            if t22Result then
                                if (new2(v823.X, v823.Y) - MouseLocation).Magnitude < t10.value37 * 1.5 then
                                    if not t10.value42 or t10.value120(v821) then
                                        v817 = v823
                                        v819 = true
                                    else
                                        t10.value43 = nil
                                    end
                                else
                                    t10.value43 = nil
                                end
                            else
                                t10.value43 = nil
                            end
                        else
                            t10.value43 = nil
                        end
                    else
                        t10.value43 = nil
                    end
                end
                if not t10.value43 then
                    for _, v825 in _ipairs(t10.value106) do
                        t4.utility.anti_trace()

                        if v825 ~= LocalPlayer.Character then
                            local v826 = t10.value122(v825)

                            if v826 then
                                local v827 = v289(v825)
                                local v828 = v288(v825)
                                local v829 = (CurrentCamera.CFrame.Position - v826.Position).Magnitude <= t10.value39

                                if v829 then
                                    v829 = not (t10.value40 and v827)

                                    if v829 then
                                        v829 = not (t10.value41 and not v828)
                                    end
                                end

                                if v829 then
                                    local v831, t23Result = WorldToViewportPoint(CurrentCamera, v826.Position)
                                    if t23Result then
                                        local Magnitude = (new2(v831.X, v831.Y) - MouseLocation).Magnitude

                                        if Magnitude < t10.value37 then
                                            if not t10.value42 or t10.value120(v826) then
                                                v819 = true
                                            end

                                            if Magnitude < value37 and (not t10.value42 or t10.value120(v826)) then
                                                v817 = v831
                                                value37 = Magnitude
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if t10.value44 then
                    local value59_2 = t10.value59

                    if v819 then
                        v819 = Color3.new(0, 1, 0)
                    end

                    if not v819 then
                        v819 = Color3.new(1, 0, 0)
                    end

                    value59_2.Color = v819
                end
                local v834 = v817
                if v817 then
                    v834 = v98:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
                end
                if v834 then
                    v133((v817.X - MouseLocation.X) / t10.value38, (v817.Y - MouseLocation.Y) / t10.value38)
                end
            elseif not t10.value36 then
                t10.value59.Visible = false
            end

            local CFramePosition = CurrentCamera.CFrame.Position

            t10.value143 = t10.value143 + 1

            if t10.value143 >= 3 then
                for v836, v837 in _pairs(t10.value35) do
                    local v838 = v836

                    t4.utility.anti_trace()

                    local v839 = v838

                    if v838 then
                        v839 = v838.Parent and t10.value32
                    end

                    if v839 then
                        local v840, _ = t10.value140(v838)

                        if v840 then
                            local v842 = v840 == "Cobblestone"

                            if v842 then
                                v842 = t10.value31.stone
                            end

                            if not v842 then
                                v842 = v840 == "Iron Ore"

                                if v842 then
                                    v842 = t10.value31.iron
                                end

                                if not v842 then
                                    v842 = v840 == "Nitrate Ore"

                                    if v842 then
                                        v842 = t10.value31.nitrate
                                    end
                                end
                            end

                            if v842 then
                                local v843 = v343(v838)

                                if v843 then
                                    if (CFramePosition - v843).Magnitude <= t10.value33 then
                                        local v845, t24Result = WorldToViewportPoint(CurrentCamera, v843)
                                        if t24Result then
                                            v837.Position = new2(v845.X, v845.Y)
                                            v837.Visible = true
                                        else
                                            v837.Visible = false
                                        end
                                    else
                                        v837.Visible = false
                                    end
                                else
                                    v837.Visible = false
                                end
                            else
                                v837.Visible = false
                            end
                        else
                            v837.Visible = false
                        end
                    elseif v837 then
                        v837.Visible = false
                    end
                end
            end

            t10.value144 = t10.value144 + 1

            if t10.value144 >= 3 then
                for v846, v847 in _pairs(t10.value101) do
                    local v848 = v846

                    t4.utility.anti_trace()

                    local v849 = v848

                    if v848 then
                        v849 = v848.Parent

                        if v849 then
                            v849 = t10.value102.master
                        end
                    end

                    if v849 then
                        local v850 = false
                        local type2 = v847.type
                        local v852 = type2 == "ATV"

                        if v852 then
                            v852 = t10.value102.atv
                        end

                        if v852 then
                            v850 = true
                        else
                            local v853 = type2 == "Boat"

                            if v853 then
                                v853 = t10.value102.boat
                            end

                            if v853 then
                                v850 = true
                            else
                                local v854 = type2 == "Helicopter"

                                if v854 then
                                    v854 = t10.value102.helicopter
                                end

                                if v854 then
                                    v850 = true
                                else
                                    local v855 = type2 == "Trolly"

                                    if v855 then
                                        v855 = t10.value102.trolly
                                    end

                                    if v855 then
                                        v850 = true
                                    end
                                end
                            end
                        end

                        if v850 then
                            local v856 = v848.PrimaryPart or v848:FindFirstChildWhichIsA("BasePart")

                            if v856 then
                                if (CFramePosition - v856.Position).Magnitude <= t10.value104 then
                                    local v857, v858 = WorldToViewportPoint(CurrentCamera, v856.Position)

                                    if v858 and v847.name then
                                        v847.name.Position = new2(v857.X, v857.Y)
                                        v847.name.Visible = true
                                    elseif v847.name then
                                        v847.name.Visible = false
                                    end
                                elseif v847.name then
                                    v847.name.Visible = false
                                end
                            elseif v847.name then
                                v847.name.Visible = false
                            end
                        elseif v847.name then
                            v847.name.Visible = false
                        end
                    elseif v847 and v847.name then
                        v847.name.Visible = false
                    end
                end
            end

            t10.value145 = t10.value145 + 1

            if t10.value145 >= 3 then
                for v859, v860 in _pairs(t10.value92) do
                    local v861 = v859

                    t4.utility.anti_trace()

                    local v862 = v861

                    if v861 then
                        v862 = v861.Parent

                        if v862 then
                            v862 = t10.value85 and t10.value86
                        end
                    end

                    if v862 then
                        local BasePart = v861:FindFirstChildWhichIsA("BasePart")

                        if BasePart then
                            if (CFramePosition - BasePart.Position).Magnitude <= t10.value87 then
                                local v865, t25Result = WorldToViewportPoint(CurrentCamera, BasePart.Position)
                                if t25Result then
                                    v860.Position = new2(v865.X, v865.Y)
                                    v860.Visible = true
                                else
                                    v860.Visible = false
                                end
                            else
                                v860.Visible = false
                            end
                        else
                            v860.Visible = false
                        end
                    elseif v860 then
                        v860.Visible = false
                    end
                end
            end

            t10.value146 = t10.value146 + 1

            if t10.value146 >= 3 then
                for v866, v867 in _pairs(t10.value93) do
                    local v868 = v866

                    t4.utility.anti_trace()

                    local v869 = v868

                    if v868 then
                        v869 = v868.Parent

                        if v869 then
                            v869 = t10.value85 and t10.value89
                        end
                    end

                    if v869 then
                        local v870 = v868:FindFirstChild("Part") or v868:FindFirstChildWhichIsA("BasePart")

                        if v870 then
                            if (CFramePosition - v870.Position).Magnitude <= t10.value90 then
                                local v871, v872 = WorldToViewportPoint(CurrentCamera, v870.Position)

                                if v872 then
                                    v867.Position = new2(v871.X, v871.Y)
                                    v867.Visible = true
                                else
                                    v867.Visible = false
                                end
                            else
                                v867.Visible = false
                            end
                        else
                            v867.Visible = false
                        end
                    elseif v867 then
                        v867.Visible = false
                    end
                end
            end
        end)
    end)
end
function t2.value2()
end
local t26 = {
	{
		Name = "Trident Survival V2",
		Desc = "<font color=\"rgb(255, 230, 225)\">Low ban risk (only Xeno, Solara)</font>",
		Icon = "rbxassetid://6031091000",
		Script = function()
    pcall(function()
        t2.value1()
    end)
end
	},
	{
		Name = "Rost Alpha SOON!",
		Desc = "<font color=\"rgb(255, 230, 225)\">Undetect (Only 7-8 lvl exploit)</font>",
		Icon = "rbxassetid://6031091000",
		Script = function()
    pcall(function()
        t2.value2()
    end)
end
	}
}
function t2.value3(p142)
    local _, _ = pcall(function()
        p142.Script()
    end)
end
if RedExecutorKeySys then
    return
end
RedExecutorKeySys = true
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

t1.value2 = Color3.fromRGB(18, 18, 26)

local color3 = Color3.fromRGB(255, 230, 225)
local color3_30 = Color3.fromRGB(24, 24, 32)
local color3_31 = Color3.fromRGB(40, 40, 55)
local color3_32 = Color3.fromRGB(24, 24, 32)
local color3_33 = Color3.fromRGB(35, 35, 50)
local color3_34 = Color3.fromRGB(255, 230, 225)
local color3_35 = Color3.fromRGB(140, 140, 150)
local t27 = {
	Name = "<font color=\"rgb(255, 230, 225)\">PROJECT SILVER</font>",
	Colors = {
		Background = t1.value2,
		Title = color3,
		InputField = color3_30,
		InputFieldBorder = color3_31,
		Button = color3_32,
		ButtonHover = color3_33,
		Success = color3_34,
		SecondaryText = color3_35
	}
}
function t1.value1(p143, p144, p145)
    if not p143 then
        return nil
    end

    local tween = TweenService:Create(p143, TweenInfo.new(p144, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), p145)

    tween:Play()

    return tween
end
local function v17(p146, p147)
    local v144 = Instance.new(p146)

    for k, v in pairs(p147) do
        if k ~= "Parent" then
            pcall(function()
                v144[k] = v
            end)
        end
    end

    if p147.Parent then
        pcall(function()
            v144.Parent = p147.Parent
        end)
    end

    return v144
end
local value1 = t1.value1
function t1.value1(p148, p149)
    if not p148 or not p149 then
        return
    end
    local u153 = false
    local inputPosition
    local p149Position
    p148.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            u153 = true
            inputPosition = input.Position
            p149Position = p149.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    u153 = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        local v355 = input.UserInputType == Enum.UserInputType.MouseMovement

        if v355 then
            v355 = u153

            if v355 then
                v355 = inputPosition and p149Position
            end
        end

        if v355 then
            local v356 = input.Position - inputPosition

            p149.Position = UDim2.new(p149Position.X.Scale, p149Position.X.Offset + v356.X, p149Position.Y.Scale, p149Position.Y.Offset + v356.Y)
        end
    end)
end
local v19 = (function()
    local ok, result = pcall(function()
        return v17("ScreenGui", {
			Parent = CoreGui,
			ResetOnSpawn = false,
			DisplayOrder = 999,
			Name = "ProjectSilverGUI"
		})
    end)

    if ok and result then
        return result
    end

    local ok2, result2 = pcall(function()
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 5)

            if PlayerGui then
                return v17("ScreenGui", {
					Parent = PlayerGui,
					ResetOnSpawn = false,
					DisplayOrder = 999,
					Name = "ProjectSilverGUI"
				})
            end
        end
    end)

    if ok2 and result2 then
        return result2
    end

    return v17("ScreenGui", {
		ResetOnSpawn = false,
		DisplayOrder = 999,
		Name = "ProjectSilverGUI"
	})
end)()
if not v19.Parent then
    task.spawn(function()
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui", 10)

            if PlayerGui then
                v19.Parent = PlayerGui
            end
        end
    end)
end
t1.value2 = v17
local Background = t27.Colors.Background
local uDim2 = UDim2.new(0.5, 0, 0.5, 0)
local vector2 = Vector2.new(0.5, 0.5)
local uDim2_2 = UDim2.new(0, 300, 0, 390)
local Background2 = t27.Colors.Background
local uDim2_3 = UDim2.new(0.5, 0, 0.5, 0)
local vector2_2 = Vector2.new(0.5, 0.5)
local uDim2_4 = UDim2.new(0, 0, 0, 0)
local v31 = v17("Frame", {
	Parent = v19,
	BackgroundColor3 = Background2,
	BorderSizePixel = 0,
	Position = uDim2_3,
	AnchorPoint = vector2_2,
	Size = UDim2.new(0, 300, 0, 360),
	ClipsDescendants = true,
	Visible = true
})
local uDim3 = UDim.new(0, 10)

v17("UICorner", {
	Parent = v31,
	CornerRadius = uDim3
})
local color3_37 = Color3.fromRGB(45, 45, 60)

v17("UIStroke", {
	Parent = v31,
	Color = color3_37,
	Thickness = 1.2
})
local function v34(p150, p151)
    local v164 = v17
    local color3_38 = Color3.fromRGB(45, 45, 60)
    local uDim2_5 = UDim2.new(0.5, 0, 0, p151)
    local vector2_3 = Vector2.new(0.5, 0)
    local uDim2_6 = UDim2.new(0.9, 0, 0, 1)

    return v164("Frame", {
		Parent = p150,
		BackgroundColor3 = color3_38,
		BorderSizePixel = 0,
		Position = uDim2_5,
		AnchorPoint = vector2_3,
		Size = uDim2_6
	})
end
local uDim2_7 = UDim2.new(1, 0, 0, 50)
local v36 = v17("Frame", {
	Parent = v31,
	BackgroundTransparency = 1,
	Size = uDim2_7
})
t1.value1(v36, v31)

local uDim2_8 = UDim2.new(0, 15, 0.5, 0)
local uDim2_9 = UDim2.new(0, 200, 0, 20)
local GothamMedium = Enum.Font.GothamMedium
t1.value5 = Color3.fromRGB(255, 255, 255)
t1.value8 = Enum.TextXAlignment.Left
t1.value14 = Vector2.new(0, 0.5)
v17("TextLabel", {
	Parent = v36,
	BackgroundTransparency = 1,
	RichText = true,
	Text = "<font color=\"rgb(255, 230, 225)\">SCRIPT</font> / SELECT",
	Position = uDim2_8,
	Size = uDim2_9,
	Font = GothamMedium,
	TextColor3 = t1.value5,
	TextSize = 14,
	TextXAlignment = t1.value8,
	AnchorPoint = t1.value14
})
v34(v31, 50)

local uDim2_10 = UDim2.new(0.5, 0, 0, 60)
local vector2_4 = Vector2.new(0.5, 0)
local uDim2_11 = UDim2.new(0, 275, 0, 260)

t1.value4 = UDim2.new(0, 0, 0, 0)

local v43 = v17("ScrollingFrame", {
	Parent = v31,
	BackgroundTransparency = 1,
	Position = uDim2_10,
	AnchorPoint = vector2_4,
	Size = uDim2_11,
	ScrollBarThickness = 0,
	CanvasSize = t1.value4,
	BorderSizePixel = 0
})
local uDim4 = UDim.new(0, 10)
local Center = Enum.HorizontalAlignment.Center
v17("UIListLayout", {
	Parent = v43,
	Padding = uDim4,
	HorizontalAlignment = Center
})
local n5 = 0
for k, v in pairs(t26) do
    local v49 = v
    local Button = t27.Colors.Button
    local uDim2_12 = UDim2.new(1, -5, 0, 65)
    local v52 = v17("TextButton", {
		Parent = v43,
		BackgroundColor3 = Button,
		Size = uDim2_12,
		Text = "",
		AutoButtonColor = false
	})
    local uDim5 = UDim.new(0, 8)

    v17("UICorner", {
		Parent = v52,
		CornerRadius = uDim5
	})

    local InputFieldBorder = t27.Colors.InputFieldBorder

    v17("UIStroke", {
		Parent = v52,
		Color = InputFieldBorder
	})
    t1.value4 = UDim2.new(0, 12, 0.5, 0)
    t1.value6 = Vector2.new(0, 0.5)
    t1.value8 = UDim2.new(0, 30, 0, 30)
    t1.value9 = v49.Icon
    v17("ImageLabel", {
		Parent = v52,
		BackgroundTransparency = 1,
		Position = t1.value4,
		AnchorPoint = t1.value6,
		Size = t1.value8,
		Image = t1.value9
	})
    t1.value5 = UDim2.new(0, 55, 0.35, 0)
    t1.value7 = UDim2.new(1, -65, 0, 20)
    t1.value8 = Enum.Font.GothamMedium
    t1.value10 = v49.Name
    t1.value12 = Color3.fromRGB(255, 255, 255)
    t1.value16 = Enum.TextXAlignment.Left
    v17("TextLabel", {
		Parent = v52,
		BackgroundTransparency = 1,
		Position = t1.value5,
		Size = t1.value7,
		Font = t1.value8,
		Text = t1.value10,
		TextColor3 = t1.value12,
		TextSize = 14,
		TextXAlignment = t1.value16,
		Interactable = false
	})
    t1.value7 = UDim2.new(0, 55, 0.65, 0)
    t1.value9 = UDim2.new(1, -65, 0, 15)
    t1.value10 = Enum.Font.GothamMedium
    t1.value11 = v49.Desc
    t1.value13 = t27.Colors.Title
    t1.value17 = Enum.TextXAlignment.Left
    v17("TextLabel", {
		Parent = v52,
		BackgroundTransparency = 1,
		RichText = true,
		Position = t1.value7,
		Size = t1.value9,
		Font = t1.value10,
		Text = t1.value11,
		TextColor3 = t1.value13,
		TextSize = 10,
		TextXAlignment = t1.value17,
		Interactable = false
	})
    v52.MouseEnter:Connect(function()
        pcall(function()
            value1(v52, 0.2, {
				BackgroundColor3 = t27.Colors.ButtonHover
			})
        end)
    end)
    v52.MouseLeave:Connect(function()
        pcall(function()
            value1(v52, 0.2, {
				BackgroundColor3 = t27.Colors.Button
			})
        end)
    end)
    v52.MouseButton1Click:Connect(function()
        pcall(function()
            if v19 then
                v19:Destroy()
            end
        end)
        t2.value3(v49)
    end)
    n5 = k
    v43.CanvasSize = UDim2.new(0, 0, 0, n5 * 75)
end
v43.CanvasSize = UDim2.new(0, 0, 0, n5 * 75 + 10)

