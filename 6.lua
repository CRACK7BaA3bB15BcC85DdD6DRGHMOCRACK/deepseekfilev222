-- This file was generated at discord.gg/syncrypt

if game.PlaceId ~= 13253735473 then
    game.Players.LocalPlayer:Kick("Game not support")

    return
end
local t1 = {}
if identifyexecutor then
    local v2 = identifyexecutor()

    if not v2 then
        game.Players.LocalPlayer:Kick("Unsupported Executor")

        return
    end

    local v3 = v2:lower()
    local v4 = v3:find("xeno")

    if not v4 then
        v4 = v3:find("solara")

        if not v4 then
            v4 = v3:find("velocity")

            if not v4 then
                v4 = v3:find("swift")

                if not v4 then
                    v4 = v3:find("volcano")

                    if not v4 then
                        v4 = v3:find("volt")

                        if not v4 then
                            v4 = v3:find("potassium")

                            if not v4 then
                                v4 = v3:find("seliware")

                                if not v4 then
                                    v4 = v3:find("madium")

                                    if not v4 then
                                        v4 = v3:find("delta")

                                        if not v4 then
                                            v4 = v3:find("sirhurt")

                                            if not v4 then
                                                v4 = v3:find("wave") or (v3:find("synapse z") or (v3:find("synapsez") or v3:find("synapse-z")))
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    if not v4 then
        game.Players.LocalPlayer:Kick("Unsupported Executor")

        return
    end
elseif not getgenv().Solara then
    game.Players.LocalPlayer:Kick("Unsupported Executor")

    return
end
t1.value1 = cloneref(game:GetService("Workspace"))
t1.value2 = cloneref(game:GetService("Players"))
t1.value3 = cloneref(game:GetService("RunService"))
t1.value4 = cloneref(game:GetService("UserInputService"))
t1.value5 = t1.value2.LocalPlayer
t1.value6 = t1.value1.CurrentCamera
t1.value7 = cloneref(game:GetService("PathfindingService"))
t1.value8 = CFrame.new
t1.value9 = Vector2.new
t1.value10 = game.FindFirstChild
t1.value11 = t1.value6.WorldToViewportPoint
t1.value12 = game.IsA
t1.value13 = math.floor
t1.value14 = {
	connections = {
		heartbeats = {},
		renderstepped = {}
	},
	drawings = {},
	hooks = {},
	metahooks = {},
	game_hooks = {}
}
local _ = game
t1.value14.utility = {}
function t1.value14.utility.anti_trace()
    local ok, result = pcall(function()
        return getstack()
    end)

    if ok then
        ok = result and #result > 80
    end

    if ok then
        return true
    end

    return false
end
function t1.value14.utility.new_heartbeat(p1)
    t1.value14.utility.anti_trace()

    local t2 = {}

    t1.value14.connections.heartbeats[p1] = p1

    function t2.Disconnect(_)
        if p1 then
            t1.value14.connections.heartbeats[p1] = nil
        end
    end

    return t2
end
function t1.value14.utility.new_renderstepped(p3)
    t1.value14.utility.anti_trace()

    local t3 = {}

    t1.value14.connections.renderstepped[p3] = p3

    function t3.Disconnect(_)
        if p3 then
            t1.value14.connections.renderstepped[p3] = nil
        end
    end

    return t3
end
function t1.value14.utility.new_drawing(p5, p6)
    t1.value14.utility.anti_trace()

    local drawing = Drawing.new(p5)
    local _pairs = pairs

    if not p6 then
        p6 = {}
    end

    for v154, v155 in _pairs(p6) do
        drawing[v154] = v155
    end

    t1.value14.drawings[drawing] = drawing

    return drawing
end
function t1.value14.utility.hook_metamethod(p7, p8, p9)
    t1.value14.utility.anti_trace()

    local v159 = hookmetamethod(p7, p8, newcclosure(p9))

    t1.value14.metahooks[p8] = {
		instance = p7,
		func = v159
	}

    return v159
end
t1.value15 = t1.value3.Heartbeat:Connect(function(dt)
    t1.value14.utility.anti_trace()

    for _, v in pairs(t1.value14.connections.heartbeats) do
        if type(v) == "function" then
            pcall(v, dt)
        end
    end
end)
t1.value16 = t1.value3.RenderStepped:Connect(function(dt)
    t1.value14.utility.anti_trace()

    for _, v in pairs(t1.value14.connections.renderstepped) do
        if type(v) == "function" then
            pcall(v, dt)
        end
    end
end)
function t1.value14.utility.unload()
    t1.value14.utility.anti_trace()
    for v168, v169 in pairs(heliTexts) do

        safeRemoveDrawing(v169)
    end
    for v172, v173 in pairs(corpseTexts) do

        safeRemoveDrawing(v173)
    end
    t1.value15:Disconnect()
    t1.value16:Disconnect()
    for _, v in pairs(t1.value14.drawings) do
        local v176 = v

        pcall(function()
            if v176 and v176.Remove then
                v176:Remove()
            end
        end)
    end
end
function t1.value17(p10)
    if p10 and p10.Remove then
        pcall(function()
            p10.Visible = false
            p10:Remove()
        end)
    end
end
spawn(function()
    t1.value14.utility.anti_trace()

    local v177 = t1.value14.utility.hook_metamethod(Random.new(), "__namecall", function(p11, ...)
        t1.value14.utility.anti_trace()

        local t4 = { ... }

        if getnamecallmethod() == "NextNumber" and (t4[1] == -100 and t4[2] == 100) then
            return t1.value14.metahooks.__namecall.func(p11, -1, 1)
        end

        return t1.value14.metahooks.__namecall.func(p11, ...)
    end)

    t1.value14.game_hooks.Random = {
		instance = Random.new(),
		metamethod = "__namecall",
		func = v177
	}
end)
t1.value18 = 150
t1.value19 = 2000
t1.value20 = nil
t1.value21 = nil
t1.value22 = nil
t1.value23 = 2000
t1.value24 = 2000
t1.value25 = 2000
t1.value26 = 2000
t1.value27 = 180
t1.value28 = 120
t1.value29 = Enum.KeyCode.J
t1.value30 = 160
local color3 = Color3.new(1, 0, 0)
local color3_2 = Color3.new(0, 0, 0)
local color3_3 = Color3.new(1, 1, 1)
local color3_4 = Color3.new(0, 0, 0)
local color3_5 = Color3.new(1, 1, 1)
local color3_6 = Color3.new(0, 0, 0)
local color3_7 = Color3.new(1, 1, 1)
local color3_8 = Color3.new(0, 0, 0)
local color3_9 = Color3.new(1, 0.4, 0.4)
local color3_10 = Color3.new(0, 0, 0)
local t5 = {
	Enabled = true,
	Box = true,
	BoxOutline = true,
	Name = true,
	NameOutline = true,
	Weapon = true,
	WeaponOutline = true,
	Distance = true,
	DistanceOutline = true,
	BoxColor = color3,
	BoxOutlineColor = color3_2,
	NameColor = color3_3,
	NameOutlineColor = color3_4,
	WeaponColor = color3_5,
	WeaponOutlineColor = color3_6,
	DistanceColor = color3_7,
	DistanceOutlineColor = color3_8,
	Corpse = true,
	CorpseColor = color3_9,
	CorpseOutline = true,
	CorpseOutlineColor = color3_10
}
local color3_11 = Color3.new(0, 1, 0)
local color3_12 = Color3.new(0, 0, 0)
local color3_13 = Color3.new(1, 1, 1)
local color3_14 = Color3.new(0, 0, 0)
local color3_15 = Color3.new(1, 1, 1)
local color3_16 = Color3.new(0, 0, 0)
local color3_17 = Color3.new(1, 1, 1)
local color3_18 = Color3.new(0, 0, 0)
local t6 = {
	Enabled = true,
	Box = true,
	BoxOutline = true,
	Name = true,
	NameOutline = true,
	Weapon = true,
	WeaponOutline = true,
	Distance = true,
	DistanceOutline = true,
	BoxColor = color3_11,
	BoxOutlineColor = color3_12,
	NameColor = color3_13,
	NameOutlineColor = color3_14,
	WeaponColor = color3_15,
	WeaponOutlineColor = color3_16,
	DistanceColor = color3_17,
	DistanceOutlineColor = color3_18
}
local color3_19 = Color3.new(1, 1, 0)
local color3_20 = Color3.new(0, 0, 0)
local color3_21 = Color3.new(1, 1, 1)
local color3_22 = Color3.new(0, 0, 0)
local color3_23 = Color3.new(1, 1, 1)
local color3_24 = Color3.new(0, 0, 0)
local color3_25 = Color3.new(1, 1, 1)
local color3_26 = Color3.new(0, 0, 0)
t1.value31 = {
	Enemy = t5,
	Sleeper = t6,
	Bot = {
		Enabled = true,
		Box = true,
		BoxOutline = true,
		Name = true,
		NameOutline = true,
		Weapon = true,
		WeaponOutline = true,
		Distance = true,
		DistanceOutline = true,
		BoxColor = color3_19,
		BoxOutlineColor = color3_20,
		NameColor = color3_21,
		NameOutlineColor = color3_22,
		WeaponColor = color3_23,
		WeaponOutlineColor = color3_24,
		DistanceColor = color3_25,
		DistanceOutlineColor = color3_26
	}
}
local color3_27 = Color3.new(1, 0.5, 0)
local color3_28 = Color3.new(0, 0, 0)
local t7 = {
	Enabled = true,
	Name = true,
	NameColor = color3_27,
	NameOutline = true,
	NameOutlineColor = color3_28
}
local color3_29 = Color3.new(0, 1, 0.8)
local color3_30 = Color3.new(0, 0, 0)
local t8 = {
	Enabled = true,
	Name = true,
	NameColor = color3_29,
	NameOutline = true,
	NameOutlineColor = color3_30
}
local color3_31 = Color3.new(1, 0, 1)
local color3_32 = Color3.new(0, 0, 0)
local t9 = {
	Enabled = true,
	Name = true,
	NameColor = color3_31,
	NameOutline = true,
	NameOutlineColor = color3_32
}
local color3_33 = Color3.new(0, 0.5, 1)
local color3_34 = Color3.new(0, 0, 0)
t1.value32 = {
	Car = t7,
	Quad = t8,
	Helicopter = t9,
	Boat = {
		Enabled = true,
		Name = true,
		NameColor = color3_33,
		NameOutline = true,
		NameOutlineColor = color3_34
	}
}
local color3_35 = Color3.new(1, 0.8, 0)
local color3_36 = Color3.new(0, 0, 0)
local t10 = {
	Enabled = true,
	Name = true,
	NameColor = color3_35,
	NameOutline = true,
	NameOutlineColor = color3_36
}
local color3_37 = Color3.new(0, 1, 1)
local color3_38 = Color3.new(0, 0, 0)
local t11 = {
	Enabled = true,
	Name = true,
	NameColor = color3_37,
	NameOutline = true,
	NameOutlineColor = color3_38
}
local color3_39 = Color3.new(0.6, 0.6, 0.6)
local color3_40 = Color3.new(0, 0, 0)
local t12 = {
	Enabled = true,
	Name = true,
	NameColor = color3_39,
	NameOutline = true,
	NameOutlineColor = color3_40
}
local color3_41 = Color3.new(1, 0, 0)
local color3_42 = Color3.new(0, 0, 0)
t1.value33 = {
	Box = t10,
	MiniBox = t11,
	Metal = t12,
	Bloxy = {
		Enabled = true,
		Name = true,
		NameColor = color3_41,
		NameOutline = true,
		NameOutlineColor = color3_42
	}
}
local color3_43 = Color3.new(0, 0.8, 0)
local color3_44 = Color3.new(0, 0, 0)
local t13 = {
	Enabled = true,
	Name = true,
	NameColor = color3_43,
	NameOutline = true,
	NameOutlineColor = color3_44
}
local color3_45 = Color3.new(0, 1, 0)
local color3_46 = Color3.new(0, 0, 0)
local t14 = {
	Enabled = true,
	Name = true,
	NameColor = color3_45,
	NameOutline = true,
	NameOutlineColor = color3_46
}
local color3_47 = Color3.new(0.5, 0.5, 0.5)
local color3_48 = Color3.new(0, 0, 0)
local t15 = {
	Enabled = true,
	Name = true,
	NameColor = color3_47,
	NameOutline = true,
	NameOutlineColor = color3_48
}
local color3_49 = Color3.new(1, 1, 1)
local color3_50 = Color3.new(0, 0, 0)
local t16 = {
	Enabled = true,
	Name = true,
	NameColor = color3_49,
	NameOutline = true,
	NameOutlineColor = color3_50
}
local color3_51 = Color3.new(0.8, 0.4, 0.2)
local color3_52 = Color3.new(0, 0, 0)
t1.value34 = {
	Cactus = t13,
	Tree = t14,
	Stone = t15,
	Nitrate = t16,
	Iron = {
		Enabled = true,
		Name = true,
		NameColor = color3_51,
		NameOutline = true,
		NameOutlineColor = color3_52
	}
}
t1.value35 = {
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
	},
	MAGNUM = {
		"Cylinder",
		"Decor",
		"EjectRod",
		"EjectRodDecal",
		"Body",
		"Grip",
		"Hammer",
		"SwingArm",
		"ADS",
		"Muzzle",
		"Handle",
		"MagnumBullet1"
	}
}
t1.value36 = setmetatable({}, {
	__mode = "k"
})
t1.value37 = setmetatable({}, {
	__mode = "k"
})
t1.value38 = setmetatable({}, {
	__mode = "k"
})
t1.value39 = setmetatable({}, {
	__mode = "k"
})
t1.value40 = {
	Car = {},
	Quad = {},
	Helicopter = {},
	Boat = {}
}
t1.value41 = {
	Car = {},
	Quad = {},
	Helicopter = {},
	Boat = {}
}
t1.value42 = {
	Box = {},
	MiniBox = {},
	Metal = {},
	Bloxy = {}
}
t1.value43 = {
	Box = {},
	MiniBox = {},
	Metal = {},
	Bloxy = {}
}
t1.value44 = {
	Cactus = {},
	Tree = {},
	Stone = {},
	Nitrate = {},
	Iron = {}
}
t1.value45 = {
	Cactus = {},
	Tree = {},
	Stone = {},
	Nitrate = {},
	Iron = {}
}
t1.value46 = Color3.fromRGB(158, 0, 153)
t1.value47 = 1
t1.value48 = "Hit Sound 1"
t1.value49 = nil
t1.value50 = 15
t1.value51 = 15
t1.value52 = 15
t1.value53 = nil
t1.value54 = 0
t1.value55 = 0.3
t1.value56 = 5
t1.value57 = nil
t1.value58 = false
t1.value59 = {}
t1.value60 = 0
t1.value61 = Vector3.new()
t1.value62 = false
t1.value63 = false
t1.value64 = false
t1.value65 = false
t1.value66 = false
t1.value67 = false
t1.value68 = false
t1.value69 = false
t1.value70 = false
t1.value71 = false
t1.value72 = false
t1.value73 = false
t1.value74 = false
t1.value75 = false
t1.value76 = false
vehicleReliefEnabled = false
t1.value77 = true
t1.value78 = false
t1.value79 = false
t1.value80 = false
t1.value81 = false
t1.value82 = false
timeChangerEnabled = false
for _, v in pairs(t1.value31) do
    if typeof(v) == "table" then
        v.Enabled = false
        v.Box = false
        v.BoxOutline = false
        v.Name = false
        v.NameOutline = false
        v.Weapon = false
        v.WeaponOutline = false
        v.Distance = false
        v.DistanceOutline = false
        v.Corpse = false
        v.CorpseOutline = false
    end
end
for v74, v75 in pairs(t1.value32) do

    v75.Enabled = false
    v75.Name = false
    v75.NameOutline = false
end
for _, v in pairs(t1.value33) do
    v.Enabled = false
    v.Name = false
    v.NameOutline = false
end
for _, v in pairs(t1.value34) do
    v.Enabled = false
    v.Name = false
    v.NameOutline = false
end
if fovOutline then
    fovOutline.Visible = false
end
if fovFill then
    fovFill.Visible = false
end
if redictionSnapline then
    redictionSnapline.Visible = false
end
t1.value83 = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/Library.lua"))()
local v80 = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/addons/SaveManager.lua"))()
local v81 = loadstring(game:HttpGet("https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/addons/ThemeManager.lua"))()
local v82 = t1.value83:CreateWindow({
	Title = "Nyxon Project | dsc.gg/NyxonProject",
	Center = true,
	AutoShow = true
})
local v83 = v82:AddTab("Combat")
local v84 = v82:AddTab("Visuals")
local v85 = v82:AddTab("Misc")
local v86 = v82:AddTab("Settings")
local t17 = {
	Combat = v83,
	Visuals = v84,
	Misc = v85,
	Settings = v86
}
local v88 = t17.Combat:AddLeftGroupbox("Manipulation")
local v89 = t17.Visuals:AddLeftTabbox()
local v90 = t17.Visuals:AddLeftTabbox()
local v91 = t17.Visuals:AddLeftTabbox()
local v92 = t17.Visuals:AddLeftTabbox()
local v93 = t17.Visuals:AddRightGroupbox("ESP Settings")
local v94 = t17.Visuals:AddRightGroupbox("Combat Settings")
local v95 = t17.Visuals:AddRightGroupbox("Combat Feedback")
local v96 = t17.Visuals:AddRightGroupbox("Camera Settings")
local v97 = t17.Visuals:AddRightGroupbox("World Settings")
local v98 = t17.Misc:AddLeftGroupbox("Weapon Hooks")
local v99 = t17.Misc:AddRightGroupbox("Player Settings")
local v100 = t17.Misc:AddLeftGroupbox("Vehicle Settings")
local _ = game
local _ = CFrame
local _ = Vector2
local _ = Color3
function t1.value84(p12, p13)
    local n1 = 0

    for _ in pairs(p12) do
        n1 += 1

        if p13 < n1 then
            local v183, v184, v185 = pairs(p12)
            local v186, _ = v183(v184, v185)

            if v186 then
                p12[v186] = nil
            end
        end
    end
end
function t1.value85()
    t1.value84(t1.value39, 100)
    t1.value84(t1.value36, 100)
    t1.value84(t1.value37, 100)
    t1.value84(corpseTexts, 50)
    t1.value84(heliTexts, 50)
end
t1.value14.utility.new_heartbeat(function()
    t1.value85()

    for k in pairs(t1.value39) do
        local v189 = k

        if v189 and v189.Parent then
            detectWeapon(v189)
        end
    end
end)
local function v105()
    local n2 = 0
    for v193 in pairs(t1.value39) do

        n2 += 1
    end
    if n2 > 200 then
        for k, _ in pairs(t1.value39) do
            local v196 = k

            if not v196 or not v196.Parent then
                removeEntity(v196)
            end
        end
    end
    if n2 % 50 == 0 then
        task.wait()
        collectgarbage("collect")
    end
end
t1.value86 = {}
v88:AddToggle("RedictionToggle", {
	Text = "Enabled",
	Default = false,
	Callback = function(p14)
    t1.value62 = p14
end
})
v88:AddToggle("HitscanToggle", {
	Text = "Hit Scanner",
	Default = false,
	Callback = function(p15)
    t1.value63 = p15
end
})
v88:AddToggle("IgnoreSleeperToggle", {
	Text = "Ignore Sleeper",
	Default = false,
	Callback = function(p16)
    t1.value64 = p16
end
})
v88:AddToggle("IgnoreBotToggle", {
	Text = "Ignore Bot",
	Default = false,
	Callback = function(p17)
    t1.value65 = p17
end
})
v88:AddSlider("FOVSlider", {
	Text = "FOV Size",
	Default = 50,
	Min = 50,
	Max = 500,
	Rounding = 0,
	Callback = function(p18)
    t1.value18 = p18
end
})
v88:AddSlider("DistanceSlider", {
	Text = "Max Distance",
	Default = 100,
	Min = 100,
	Max = 5000,
	Rounding = 0,
	Callback = function(p19)
    t1.value19 = p19
end
})
local v106 = v89:AddTab("Enemy")
v106:AddToggle("EnemyEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p20)
    t1.value31.Enemy.Enabled = p20
end
})
v106:AddToggle("EnemyBox", {
	Text = "Box",
	Default = false,
	Callback = function(p21)
    t1.value31.Enemy.Box = p21
end
}):AddColorPicker("EnemyBoxColor", {
	Default = Color3.new(1, 0, 0),
	Callback = function(p22)
    t1.value31.Enemy.BoxColor = p22
end
})
v106:AddToggle("EnemyBoxOutline", {
	Text = "Box Outline",
	Default = false,
	Callback = function(p23)
    t1.value31.Enemy.BoxOutline = p23
end
}):AddColorPicker("EnemyBoxOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p24)
    t1.value31.Enemy.BoxOutlineColor = p24
end
})
v106:AddToggle("EnemyName", {
	Text = "Name",
	Default = false,
	Callback = function(p25)
    t1.value31.Enemy.Name = p25
end
}):AddColorPicker("EnemyNameColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p26)
    t1.value31.Enemy.NameColor = p26
end
})
v106:AddToggle("EnemyNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p27)
    t1.value31.Enemy.NameOutline = p27
end
}):AddColorPicker("EnemyNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p28)
    t1.value31.Enemy.NameOutlineColor = p28
end
})
v106:AddToggle("EnemyCorpse", {
	Text = "Corpse",
	Default = false,
	Callback = function(p29)
    t1.value31.Enemy.Corpse = p29
end
}):AddColorPicker("EnemyCorpseColor", {
	Default = Color3.new(1, 0.4, 0.4),
	Callback = function(p30)
    t1.value31.Enemy.CorpseColor = p30
end
})
v106:AddToggle("EnemyCorpseOutline", {
	Text = "Corpse Outline",
	Default = false,
	Callback = function(p31)
    t1.value31.Enemy.CorpseOutline = p31
end
}):AddColorPicker("EnemyCorpseOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p32)
    t1.value31.Enemy.CorpseOutlineColor = p32
end
})
v106:AddToggle("EnemyWeapon", {
	Text = "Weapon",
	Default = false,
	Callback = function(p33)
    t1.value31.Enemy.Weapon = p33
end
}):AddColorPicker("EnemyWeaponColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p34)
    t1.value31.Enemy.WeaponColor = p34
end
})
v106:AddToggle("EnemyWeaponOutline", {
	Text = "Weapon Outline",
	Default = false,
	Callback = function(p35)
    t1.value31.Enemy.WeaponOutline = p35
end
}):AddColorPicker("EnemyWeaponOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p36)
    t1.value31.Enemy.WeaponOutlineColor = p36
end
})
v106:AddToggle("EnemyDistance", {
	Text = "Distance",
	Default = false,
	Callback = function(p37)
    t1.value31.Enemy.Distance = p37
end
}):AddColorPicker("EnemyDistanceColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p38)
    t1.value31.Enemy.DistanceColor = p38
end
})
v106:AddToggle("EnemyDistanceOutline", {
	Text = "Distance Outline",
	Default = false,
	Callback = function(p39)
    t1.value31.Enemy.DistanceOutline = p39
end
}):AddColorPicker("EnemyDistanceOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p40)
    t1.value31.Enemy.DistanceOutlineColor = p40
end
})
local v107 = v89:AddTab("Sleeper")
v107:AddToggle("SleeperEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p41)
    t1.value31.Sleeper.Enabled = p41
end
})
v107:AddToggle("SleeperBox", {
	Text = "Box",
	Default = false,
	Callback = function(p42)
    t1.value31.Sleeper.Box = p42
end
}):AddColorPicker("SleeperBoxColor", {
	Default = Color3.new(0, 1, 0),
	Callback = function(p43)
    t1.value31.Sleeper.BoxColor = p43
end
})
v107:AddToggle("SleeperBoxOutline", {
	Text = "Box Outline",
	Default = false,
	Callback = function(p44)
    t1.value31.Sleeper.BoxOutline = p44
end
}):AddColorPicker("SleeperBoxOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p45)
    t1.value31.Sleeper.BoxOutlineColor = p45
end
})
v107:AddToggle("SleeperName", {
	Text = "Name",
	Default = false,
	Callback = function(p46)
    t1.value31.Sleeper.Name = p46
end
}):AddColorPicker("SleeperNameColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p47)
    t1.value31.Sleeper.NameColor = p47
end
})
v107:AddToggle("SleeperNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p48)
    t1.value31.Sleeper.NameOutline = p48
end
}):AddColorPicker("SleeperNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p49)
    t1.value31.Sleeper.NameOutlineColor = p49
end
})
v107:AddToggle("SleeperWeapon", {
	Text = "Weapon",
	Default = false,
	Callback = function(p50)
    t1.value31.Sleeper.Weapon = p50
end
}):AddColorPicker("SleeperWeaponColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p51)
    t1.value31.Sleeper.WeaponColor = p51
end
})
v107:AddToggle("SleeperWeaponOutline", {
	Text = "Weapon Outline",
	Default = false,
	Callback = function(p52)
    t1.value31.Sleeper.WeaponOutline = p52
end
}):AddColorPicker("SleeperWeaponOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p53)
    t1.value31.Sleeper.WeaponOutlineColor = p53
end
})
v107:AddToggle("SleeperDistance", {
	Text = "Distance",
	Default = false,
	Callback = function(p54)
    t1.value31.Sleeper.Distance = p54
end
}):AddColorPicker("SleeperDistanceColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p55)
    t1.value31.Sleeper.DistanceColor = p55
end
})
v107:AddToggle("SleeperDistanceOutline", {
	Text = "Distance Outline",
	Default = false,
	Callback = function(p56)
    t1.value31.Sleeper.DistanceOutline = p56
end
}):AddColorPicker("SleeperDistanceOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p57)
    t1.value31.Sleeper.DistanceOutlineColor = p57
end
})
local v108 = v89:AddTab("Bot")
v108:AddToggle("BotEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p58)
    t1.value31.Bot.Enabled = p58
end
})
v108:AddToggle("BotBox", {
	Text = "Box",
	Default = false,
	Callback = function(p59)
    t1.value31.Bot.Box = p59
end
}):AddColorPicker("BotBoxColor", {
	Default = Color3.new(1, 1, 0),
	Callback = function(p60)
    t1.value31.Bot.BoxColor = p60
end
})
v108:AddToggle("BotBoxOutline", {
	Text = "Box Outline",
	Default = false,
	Callback = function(p61)
    t1.value31.Bot.BoxOutline = p61
end
}):AddColorPicker("BotBoxOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p62)
    t1.value31.Bot.BoxOutlineColor = p62
end
})
v108:AddToggle("BotName", {
	Text = "Name",
	Default = false,
	Callback = function(p63)
    t1.value31.Bot.Name = p63
end
}):AddColorPicker("BotNameColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p64)
    t1.value31.Bot.NameColor = p64
end
})
v108:AddToggle("BotNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p65)
    t1.value31.Bot.NameOutline = p65
end
}):AddColorPicker("BotNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p66)
    t1.value31.Bot.NameOutlineColor = p66
end
})
v108:AddToggle("BotWeapon", {
	Text = "Weapon",
	Default = false,
	Callback = function(p67)
    t1.value31.Bot.Weapon = p67
end
}):AddColorPicker("BotWeaponColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p68)
    t1.value31.Bot.WeaponColor = p68
end
})
v108:AddToggle("BotWeaponOutline", {
	Text = "Weapon Outline",
	Default = false,
	Callback = function(p69)
    t1.value31.Bot.WeaponOutline = p69
end
}):AddColorPicker("BotWeaponOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p70)
    t1.value31.Bot.WeaponOutlineColor = p70
end
})
v108:AddToggle("BotDistance", {
	Text = "Distance",
	Default = false,
	Callback = function(p71)
    t1.value31.Bot.Distance = p71
end
}):AddColorPicker("BotDistanceColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p72)
    t1.value31.Bot.DistanceColor = p72
end
})
local v109 = v108:AddToggle("BotDistanceOutline", {
	Text = "Distance Outline",
	Default = false,
	Callback = function(p73)
    t1.value31.Bot.DistanceOutline = p73
end
})
local _Color3 = Color3
local AddColorPicker = v109.AddColorPicker
local v112 = _Color3.new(0, 0, 0)
local AddTab = v90.AddTab
AddColorPicker(v109, "BotDistanceOutlineColor", {
	Default = v112,
	Callback = function(p74)
    t1.value31.Bot.DistanceOutlineColor = p74
end
})
local v114 = AddTab(v90, "Car")
v114:AddToggle("CarEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p75)
    t1.value32.Car.Enabled = p75
end
})
v114:AddToggle("CarName", {
	Text = "Name",
	Default = false,
	Callback = function(p76)
    t1.value32.Car.Name = p76
end
}):AddColorPicker("CarNameColor", {
	Default = Color3.new(1, 0.5, 0),
	Callback = function(p77)
    t1.value32.Car.NameColor = p77
end
})
local AddToggle = v114.AddToggle
local _trufalsee = trufalsee
AddToggle(v114, "CarNameOutline", {
	Text = "Name Outline",
	Default = _trufalsee,
	Callback = function(p78)
    t1.value32.Car.NameOutline = p78
end
}):AddColorPicker("CarNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p79)
    t1.value32.Car.NameOutlineColor = p79
end
})
local v117 = v90:AddTab("Quad bike")
v117:AddToggle("QuadEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p80)
    t1.value32.Quad.Enabled = p80
end
})
v117:AddToggle("QuadName", {
	Text = "Name",
	Default = false,
	Callback = function(p81)
    t1.value32.Quad.Name = p81
end
}):AddColorPicker("QuadNameColor", {
	Default = Color3.new(0, 1, 0.8),
	Callback = function(p82)
    t1.value32.Quad.NameColor = p82
end
})
v117:AddToggle("QuadNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p83)
    t1.value32.Quad.NameOutline = p83
end
}):AddColorPicker("QuadNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p84)
    t1.value32.Quad.NameOutlineColor = p84
end
})
local v118 = v90:AddTab("Heli")
v118:AddToggle("HeliEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p85)
    t1.value32.Helicopter.Enabled = p85
end
})
v118:AddToggle("HeliName", {
	Text = "Name",
	Default = false,
	Callback = function(p86)
    t1.value32.Helicopter.Name = p86
end
}):AddColorPicker("HeliNameColor", {
	Default = Color3.new(1, 0, 1),
	Callback = function(p87)
    t1.value32.Helicopter.NameColor = p87
end
})
v118:AddToggle("HeliNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p88)
    t1.value32.Helicopter.NameOutline = p88
end
}):AddColorPicker("HeliNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p89)
    t1.value32.Helicopter.NameOutlineColor = p89
end
})
local v119 = v90:AddTab("Boat")
v119:AddToggle("BoatEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p90)
    t1.value32.Boat.Enabled = p90
end
})
v119:AddToggle("BoatName", {
	Text = "Name",
	Default = false,
	Callback = function(p91)
    t1.value32.Boat.Name = p91
end
}):AddColorPicker("BoatNameColor", {
	Default = Color3.new(0, 0.5, 1),
	Callback = function(p92)
    t1.value32.Boat.NameColor = p92
end
})
local v120 = v119:AddToggle("BoatNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p93)
    t1.value32.Boat.NameOutline = p93
end
})
local _Color3_2 = Color3
local AddColorPicker2 = v120.AddColorPicker
local v123 = _Color3_2.new(0, 0, 0)
local AddTab2 = v91.AddTab
AddColorPicker2(v120, "BoatNameOutlineColor", {
	Default = v123,
	Callback = function(p94)
    t1.value32.Boat.NameOutlineColor = p94
end
})
local v125 = AddTab2(v91, "Box")
v125:AddToggle("BoxEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p95)
    t1.value33.Box.Enabled = p95
end
})
v125:AddToggle("BoxName", {
	Text = "Name",
	Default = false,
	Callback = function(p96)
    t1.value33.Box.Name = p96
end
}):AddColorPicker("BoxNameColor", {
	Default = Color3.new(1, 0.8, 0),
	Callback = function(p97)
    t1.value33.Box.NameColor = p97
end
})
v125:AddToggle("BoxNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p98)
    t1.value33.Box.NameOutline = p98
end
}):AddColorPicker("BoxNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p99)
    t1.value33.Box.NameOutlineColor = p99
end
})
local v126 = v91:AddTab("Mini Box")
v126:AddToggle("MiniBoxEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p100)
    t1.value33.MiniBox.Enabled = p100
end
})
v126:AddToggle("MiniBoxName", {
	Text = "Name",
	Default = false,
	Callback = function(p101)
    t1.value33.MiniBox.Name = p101
end
}):AddColorPicker("MiniBoxNameColor", {
	Default = Color3.new(0, 1, 1),
	Callback = function(p102)
    t1.value33.MiniBox.NameColor = p102
end
})
v126:AddToggle("MiniBoxNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p103)
    t1.value33.MiniBox.NameOutline = p103
end
}):AddColorPicker("MiniBoxNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p104)
    t1.value33.MiniBox.NameOutlineColor = p104
end
})
local v127 = v91:AddTab("Metal")
v127:AddToggle("MetalEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p105)
    t1.value33.Metal.Enabled = p105
end
})
v127:AddToggle("MetalName", {
	Text = "Name",
	Default = false,
	Callback = function(p106)
    t1.value33.Metal.Name = p106
end
}):AddColorPicker("MetalNameColor", {
	Default = Color3.new(0.6, 0.6, 0.6),
	Callback = function(p107)
    t1.value33.Metal.NameColor = p107
end
})
v127:AddToggle("MetalNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p108)
    t1.value33.Metal.NameOutline = p108
end
}):AddColorPicker("MetalNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p109)
    t1.value33.Metal.NameOutlineColor = p109
end
})
local v128 = v91:AddTab("Bloxy")
v128:AddToggle("BloxyEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p110)
    t1.value33.Bloxy.Enabled = p110
end
})
v128:AddToggle("BloxyName", {
	Text = "Name",
	Default = false,
	Callback = function(p111)
    t1.value33.Bloxy.Name = p111
end
}):AddColorPicker("BloxyNameColor", {
	Default = Color3.new(1, 0, 0),
	Callback = function(p112)
    t1.value33.Bloxy.NameColor = p112
end
})
v128:AddToggle("BloxyNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p113)
    t1.value33.Bloxy.NameOutline = p113
end
}):AddColorPicker("BloxyNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p114)
    t1.value33.Bloxy.NameOutlineColor = p114
end
})
local v129 = v92:AddTab("Cactus")
v129:AddToggle("CactusEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p115)
    t1.value34.Cactus.Enabled = p115
end
})
v129:AddToggle("CactusName", {
	Text = "Name",
	Default = false,
	Callback = function(p116)
    t1.value34.Cactus.Name = p116
end
}):AddColorPicker("CactusNameColor", {
	Default = Color3.new(0, 0.8, 0),
	Callback = function(p117)
    t1.value34.Cactus.NameColor = p117
end
})
v129:AddToggle("CactusNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p118)
    t1.value34.Cactus.NameOutline = p118
end
}):AddColorPicker("CactusNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p119)
    t1.value34.Cactus.NameOutlineColor = p119
end
})
local v130 = v92:AddTab("Tree")
v130:AddToggle("TreeEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p120)
    t1.value34.Tree.Enabled = p120
end
})
v130:AddToggle("TreeName", {
	Text = "Name",
	Default = false,
	Callback = function(p121)
    t1.value34.Tree.Name = p121
end
}):AddColorPicker("TreeNameColor", {
	Default = Color3.new(0, 1, 0),
	Callback = function(p122)
    t1.value34.Tree.NameColor = p122
end
})
v130:AddToggle("TreeNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p123)
    t1.value34.Tree.NameOutline = p123
end
}):AddColorPicker("TreeNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p124)
    t1.value34.Tree.NameOutlineColor = p124
end
})
local v131 = v92:AddTab("Stone")
v131:AddToggle("StoneEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p125)
    t1.value34.Stone.Enabled = p125
end
})
v131:AddToggle("StoneName", {
	Text = "Name",
	Default = false,
	Callback = function(p126)
    t1.value34.Stone.Name = p126
end
}):AddColorPicker("StoneNameColor", {
	Default = Color3.new(0.5, 0.5, 0.5),
	Callback = function(p127)
    t1.value34.Stone.NameColor = p127
end
})
v131:AddToggle("StoneNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p128)
    t1.value34.Stone.NameOutline = p128
end
}):AddColorPicker("StoneNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p129)
    t1.value34.Stone.NameOutlineColor = p129
end
})
local v132 = v92:AddTab("Nitrate")
v132:AddToggle("NitrateEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p130)
    t1.value34.Nitrate.Enabled = p130
end
})
v132:AddToggle("NitrateName", {
	Text = "Name",
	Default = false,
	Callback = function(p131)
    t1.value34.Nitrate.Name = p131
end
}):AddColorPicker("NitrateNameColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p132)
    t1.value34.Nitrate.NameColor = p132
end
})
local v133 = v132:AddToggle("NitrateNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p133)
    t1.value34.Nitrate.NameOutline = p133
end
})
local color3_53 = Color3.new(0, 0, 0)
local AddTab3 = v92.AddTab
v133:AddColorPicker("NitrateNameOutlineColor", {
	Default = color3_53,
	Callback = function(p134)
    t1.value34.Nitrate.NameOutlineColor = p134
end
})
local v136 = AddTab3(v92, "Iron")
v136:AddToggle("IronEnabled", {
	Text = "Enabled",
	Default = false,
	Callback = function(p135)
    t1.value34.Iron.Enabled = p135
end
})
v136:AddToggle("IronName", {
	Text = "Name",
	Default = false,
	Callback = function(p136)
    t1.value34.Iron.Name = p136
end
}):AddColorPicker("IronNameColor", {
	Default = Color3.new(0.8, 0.4, 0.2),
	Callback = function(p137)
    t1.value34.Iron.NameColor = p137
end
})
v136:AddToggle("IronNameOutline", {
	Text = "Name Outline",
	Default = false,
	Callback = function(p138)
    t1.value34.Iron.NameOutline = p138
end
}):AddColorPicker("IronNameOutlineColor", {
	Default = Color3.new(0, 0, 0),
	Callback = function(p139)
    t1.value34.Iron.NameOutlineColor = p139
end
})
t1.value87 = false
t1.value88 = 12
v97:AddToggle("TimeChangerToggle", {
	Text = "Time Changer",
	Default = false,
	Callback = function(p140)
    t1.value87 = p140
end
})
v97:AddSlider("TimeChangerSlider", {
	Text = "Time (Hours)",
	Default = 12,
	Min = 0,
	Max = 24,
	Rounding = 1,
	Callback = function(p141)
    t1.value88 = p141
end
})
v93:AddToggle("GlobalESPToggle", {
	Text = "Enabled ESP",
	Default = false,
	Callback = function(p142)
    t1.value66 = p142
end
})
v93:AddSlider("GlobalESPDistance", {
	Text = "ESP Distance",
	Default = 2000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Callback = function(p143)
    t1.value23 = p143
end
})
v93:AddToggle("VehicleESPToggle", {
	Text = "Enabled Vehicle ESP",
	Default = false,
	Callback = function(p144)
    t1.value67 = p144
end
})
v93:AddSlider("VehicleESPDistance", {
	Text = "Vehicle ESP Distance",
	Default = 2000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Callback = function(p145)
    t1.value24 = p145
end
})
v93:AddToggle("ResourceESPToggle", {
	Text = "Enabled Resource ESP",
	Default = false,
	Callback = function(p146)
    t1.value68 = p146
end
})
v93:AddSlider("ResourceESPDistance", {
	Text = "Resource ESP Distance",
	Default = 2000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Callback = function(p147)
    t1.value25 = p147
end
})
v93:AddToggle("MaterialESPToggle", {
	Text = "Enabled Material ESP",
	Default = false,
	Callback = function(p148)
    t1.value69 = p148
end
})
v93:AddSlider("MaterialESPDistance", {
	Text = "Material ESP Distance",
	Default = 2000,
	Min = 100,
	Max = 10000,
	Rounding = 0,
	Callback = function(p149)
    t1.value26 = p149
end
})
t1.value89 = Drawing.new("Line")
t1.value89.Thickness = 1
t1.value89.Color = Color3.new(1, 1, 1)
t1.value89.Visible = false
t1.value14.drawings[t1.value89] = t1.value89
t1.value90 = Drawing.new("Circle")
t1.value90.Thickness = 1.5
t1.value90.NumSides = 64
t1.value90.Filled = false
t1.value90.Visible = false
t1.value90.Transparency = 0
t1.value90.Color = Color3.new(1, 1, 1)
t1.value14.drawings[t1.value90] = t1.value90
t1.value91 = Drawing.new("Circle")
t1.value91.Thickness = 0
t1.value91.NumSides = 64
t1.value91.Filled = true
t1.value91.Visible = false
t1.value91.Transparency = 0.7
t1.value91.Color = Color3.new(1, 0, 0)
t1.value14.drawings[t1.value91] = t1.value91
v94:AddToggle("FOVToggle", {
	Text = "Show FOV Circle",
	Default = false,
	Callback = function(p150)
    t1.value90.Visible = p150

    local value91 = t1.value91

    if p150 then
        p150 = t1.value91.Filled
    end

    value91.Visible = p150
end
}):AddColorPicker("FOVOutlineColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p151)
    t1.value90.Color = p151
end
})
v94:AddSlider("FOVOutlineTransparency", {
	Text = "Outline Transparency",
	Default = 1,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Callback = function(p152)
    t1.value90.Transparency = 1 - p152
end
})
v94:AddToggle("FOVFillToggle", {
	Text = "FOV Fill",
	Default = false,
	Callback = function(p153)
    t1.value91.Filled = p153

    local value91 = t1.value91

    if p153 then
        p153 = t1.value90.Visible
    end

    value91.Visible = p153
end
}):AddColorPicker("FOVFillColor", {
	Default = Color3.new(1, 0, 0),
	Callback = function(p154)
    t1.value91.Color = p154
end
})
v94:AddSlider("FOVFillTransparency", {
	Text = "Fill Transparency",
	Default = 0.3,
	Min = 0,
	Max = 1,
	Rounding = 2,
	Callback = function(p155)
    t1.value91.Transparency = 1 - p155
end
})
v94:AddToggle("SnaplineToggle", {
	Text = "Show Snapline",
	Default = false,
	Callback = function(p156)
    t1.value89.Visible = p156
end
}):AddColorPicker("SnaplineColor", {
	Default = Color3.new(1, 1, 1),
	Callback = function(p157)
    t1.value89.Color = p157
end
})
v95:AddToggle("HitMarkerToggle", {
	Text = "Hit Marker",
	Default = false,
	Callback = function(p158)
    t1.value78 = p158
end
}):AddColorPicker("HitMarkerColor", {
	Default = Color3.fromRGB(158, 0, 153),
	Callback = function(p159)
    t1.value46 = p159
end
})
v95:AddToggle("HitSoundToggle", {
	Text = "Hit Sound",
	Default = false,
	Callback = function(p160)
    t1.value79 = p160
end
})
v95:AddDropdown("HitSoundDropdown", {
	Text = "Hit Sound",
	Default = "Hit Sound 1",
	Values = { "Hit Sound 1" },
	Callback = function(p161)
    t1.value48 = p161
end
})
v95:AddSlider("HitSoundVolume", {
	Text = "Hit Sound Volume",
	Default = 1,
	Min = 0,
	Max = 2,
	Rounding = 2,
	Callback = function(p162)
    t1.value47 = p162
end
})
v95:AddToggle("HitIndicatorToggle", {
	Text = "Hit Indicator",
	Default = false,
	Callback = function(p163)
    t1.value80 = p163
end
})
v95:AddToggle("TrailToggle", {
	Text = "Bullet Tracer",
	Default = false,
	Callback = function(p164)
    t1.value81 = p164
end
})
v98:AddToggle("JumpShootToggle", {
	Text = "Jump Shoot",
	Default = false,
	Callback = function(p165)
    t1.value82 = p165

    if not p165 and t1.value49 then
        t1.value49:Destroy()
        t1.value49 = nil
    end
end
})
v99:AddToggle("SpeedHackToggle", {
	Text = "Speed Hack",
	Default = false,
	Callback = function(p166)
    t1.value72 = p166
end
})
v96:AddToggle("FOVChangerToggle", {
	Text = "FOV Changer",
	Default = false,
	Callback = function(p167)
    t1.value70 = p167
end
})
v96:AddSlider("CameraFOVSlider", {
	Text = "Camera FOV",
	Default = 120,
	Min = 75,
	Max = 120,
	Rounding = 0,
	Callback = function(p168)
    t1.value28 = p168
end
})
v96:AddToggle("FreeCameraToggle", {
	Text = "Free Camera Mode",
	Default = false,
	Callback = function(p169)
    t1.value71 = p169
end
})
v96:AddDropdown("FreeCameraKeyDropdown", {
	Text = "Free Camera Key",
	Values = {
		"J",
		"F",
		"V",
		"X",
		"Z",
		"C",
		"B",
		"K",
		"L",
		"H"
	},
	Default = "J",
	Multi = false,
	Callback = function(p170)
    if p170 == "J" then
        t1.value29 = Enum.KeyCode.J

        return
    end

    if p170 == "F" then
        t1.value29 = Enum.KeyCode.F

        return
    end

    if p170 == "V" then
        t1.value29 = Enum.KeyCode.V

        return
    end

    if p170 == "X" then
        t1.value29 = Enum.KeyCode.X

        return
    end

    if p170 == "Z" then
        t1.value29 = Enum.KeyCode.Z

        return
    end

    if p170 == "C" then
        t1.value29 = Enum.KeyCode.C

        return
    end

    if p170 == "B" then
        t1.value29 = Enum.KeyCode.B

        return
    end

    if p170 == "K" then
        t1.value29 = Enum.KeyCode.K

        return
    end

    if p170 == "L" then
        t1.value29 = Enum.KeyCode.L

        return
    end

    if p170 == "H" then
        t1.value29 = Enum.KeyCode.H
    end
end
})
v96:AddSlider("FreeCameraSpeed", {
	Text = "Free Camera Speed",
	Default = 160,
	Min = 50,
	Max = 500,
	Rounding = 0,
	Callback = function(p171)
    t1.value30 = p171
end
})
v100:AddToggle("VehicleFlyToggle", {
	Text = "Vehicle Fly",
	Default = false,
	Callback = function(p172)
    t1.value73 = p172
end
})
v100:AddLabel("B - Up | N - Down")
v100:AddLabel("← → ↑ ↓ - Move")
v100:AddLabel("Z - Left | X - Right rotate")
v100:AddSlider("VehicleHorizontalSpeed", {
	Text = "Horizontal Speed",
	Default = 15,
	Min = 10,
	Max = 100,
	Rounding = 0,
	Callback = function(p173)
    t1.value50 = p173
end
})
v100:AddSlider("VehicleVerticalSpeed", {
	Text = "Vertical Speed",
	Default = 15,
	Min = 10,
	Max = 50,
	Rounding = 0,
	Callback = function(p174)
    t1.value51 = p174
end
})
v100:AddSlider("VehicleTurnSpeed", {
	Text = "Rotate Speed",
	Default = 180,
	Min = 90,
	Max = 360,
	Rounding = 0,
	Callback = function(p175)
    t1.value27 = p175
end
})
v100:AddToggle("VehicleNoclipToggle", {
	Text = "Vehicle Noclip",
	Default = false,
	Callback = function(p176)
    t1.value74 = p176
end
})
v100:AddToggle("VehicleMomentumToggle", {
	Text = "Smooth Stop",
	Default = true,
	Callback = function(p177)
    t1.value77 = p177
end
})
v100:AddSlider("VehicleMomentumDecay", {
	Text = "Smooth stop Speed",
	Default = 5,
	Min = 1,
	Max = 20,
	Rounding = 1,
	Callback = function(p178)
    t1.value56 = p178
end
})
v100:AddToggle("VehicleReliefToggle", {
	Text = "Relief Movement(Bag)",
	Default = false,
	Callback = function(p179)
    vehicleReliefEnabled = p179
end
})
v100:AddSlider("ReliefHeightOffset", {
	Text = "Height Offset",
	Default = 3,
	Min = 0,
	Max = 10,
	Rounding = 1,
	Callback = function(p180)
    reliefHeightOffset = p180
end
})
v100:AddToggle("BoatSpeedToggle", {
	Text = "Boat Speed(Not work)",
	Default = false,
	Callback = function(p181)
    t1.value75 = p181
end
})
v100:AddSlider("BoatHorizontalSpeed", {
	Text = "Boat Speed",
	Default = 15,
	Min = 10,
	Max = 50,
	Rounding = 0,
	Callback = function(p182)
    t1.value52 = p182
end
})
v100:AddToggle("VehicleKillToggle", {
	Text = "Player Killed by Vehicle (V)",
	Default = false,
	Callback = function(p183)
    t1.value76 = p183

    if not p183 then
        t1.value58 = false
        t1.value57 = nil
    end
end
})
t1.value4.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.V and t1.value76 then
        t1.value58 = not t1.value58

        if t1.value58 and t1.value20 then
            t1.value57 = t1.value20
            t1.value59 = {}

            return
        end

        t1.value57 = nil
        t1.value59 = {}
    end
end)
v81:SetLibrary(t1.value83)
v81:SetFolder("Trident")
v81:ApplyToTab(t17.Settings)
v80:SetLibrary(t1.value83)
v80:SetFolder("Trident")
v80:BuildConfigSection(t17.Settings)
t1.value92 = 2
t1.value93 = 4
t1.value94 = 0
t1.value95 = 0
t1.value96 = t1.value1.CurrentCamera
t1.value97 = game:GetService("UserInputService")
local vector3 = Vector3.new()
local vector3_2 = Vector3.new()
t1.value98 = {
	Enabled = false,
	Speed = 160,
	Sensitivity = 0.35,
	Connection = nil,
	Position = vector3,
	RotationX = 0,
	RotationY = 0,
	Velocity = vector3_2
}
t1.value99 = nil
t1.value100 = nil
t1.value101 = nil
t1.value102 = nil
t1.value103 = nil
function t1.value103()
    local Const = t1.value1:FindFirstChild("Const")

    if not Const then
        return nil
    end

    local Ignore = Const:FindFirstChild("Ignore")

    if not Ignore then
        return nil
    end

    local LocalCharacter = Ignore:FindFirstChild("LocalCharacter")

    if not LocalCharacter then
        return nil
    end

    local Bottom = LocalCharacter:FindFirstChild("Bottom")

    if Bottom and Bottom:IsA("BasePart") then
        return Bottom
    end

    return nil
end
function t1.value104()
    t1.value99 = t1.value103()

    if not t1.value99 then
        return false
    end

    t1.value100 = t1.value99.CFrame
    t1.value101 = t1.value99.Velocity
    t1.value102 = t1.value99.Anchored
    t1.value99.Velocity = Vector3.new(0, 0, 0)
    t1.value99.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    t1.value99.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    t1.value99.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
    t1.value99.Anchored = true

    return true
end
function t1.value105()
    if not t1.value99 then
        t1.value99 = t1.value103()

        if not t1.value99 then
            return
        end
    end

    if t1.value99 and t1.value99.Parent then
        t1.value99.CustomPhysicalProperties = PhysicalProperties.new(1, 1, 1, 1, 1)
        t1.value99.Anchored = t1.value102 or false

        if t1.value100 then
            t1.value99.CFrame = t1.value100
        end

        if t1.value101 then
            t1.value99.Velocity = t1.value101
            t1.value99.AssemblyLinearVelocity = t1.value101
        end

        t1.value99.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end

    t1.value99 = nil
end
local function v139()
    if t1.value99 and t1.value99.Parent then
        t1.value99.Velocity = Vector3.new(0, 0, 0)
        t1.value99.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        t1.value99.AssemblyAngularVelocity = Vector3.new(0, 0, 0)

        if not t1.value99.Anchored then
            t1.value99.Anchored = true

            return
        end
    else
        t1.value99 = t1.value103()

        if t1.value99 then
            t1.value104()
        end
    end
end
function t1.value106()
    t1.value96.CameraType = Enum.CameraType.Scriptable
end
function t1.value107()
    t1.value98.Enabled = not t1.value98.Enabled

    if t1.value98.Enabled then
        t1.value104()

        local value96CFrame = t1.value96.CFrame

        t1.value98.Position = value96CFrame.Position

        local v376, v377, _ = value96CFrame:ToOrientation()

        t1.value98.RotationX = math.deg(v376)
        t1.value98.RotationY = math.deg(v377)
        t1.value106()
        t1.value98.Connection = t1.value3.RenderStepped:Connect(function(dt)
            if not t1.value98.Enabled then
                return
            end

            if t1.value96.CameraType ~= Enum.CameraType.Scriptable then
                t1.value106()
            end

            v139()

            local MouseDelta = t1.value97:GetMouseDelta()

            t1.value98.RotationY = t1.value98.RotationY - MouseDelta.X * t1.value98.Sensitivity
            t1.value98.RotationX = math.clamp(t1.value98.RotationX - MouseDelta.Y * t1.value98.Sensitivity, -89, 89)

            local cFrame = CFrame.fromEulerAnglesYXZ(math.rad(t1.value98.RotationX), math.rad(t1.value98.RotationY), 0)
            local vector3_3 = Vector3.new(0, 0, 0)

            if t1.value97:IsKeyDown(Enum.KeyCode.W) then
                vector3_3 += cFrame.LookVector
            end

            if t1.value97:IsKeyDown(Enum.KeyCode.S) then
                vector3_3 -= cFrame.LookVector
            end

            if t1.value97:IsKeyDown(Enum.KeyCode.A) then
                vector3_3 -= cFrame.RightVector
            end

            if t1.value97:IsKeyDown(Enum.KeyCode.D) then
                vector3_3 += cFrame.RightVector
            end

            if t1.value97:IsKeyDown(Enum.KeyCode.Space) then
                vector3_3 += Vector3.new(0, 1, 0)
            end

            if t1.value97:IsKeyDown(Enum.KeyCode.LeftControl) then
                vector3_3 -= Vector3.new(0, 1, 0)
            end

            if vector3_3.Magnitude > 0 then
                vector3_3 = vector3_3.Unit
            end

            t1.value98.Velocity = t1.value98.Velocity:Lerp(vector3_3 * t1.value98.Speed, 0.22)
            t1.value98.Position = t1.value98.Position + t1.value98.Velocity * dt
            t1.value96.CFrame = CFrame.new(t1.value98.Position) * cFrame
        end)
        t1.value97.MouseBehavior = Enum.MouseBehavior.LockCenter

        return
    end

    if t1.value98.Connection then
        t1.value98.Connection:Disconnect()
        t1.value98.Connection = nil
    end

    t1.value105()
    t1.value96.CameraType = Enum.CameraType.Custom
    t1.value97.MouseBehavior = Enum.MouseBehavior.Default
    t1.value98.Velocity = Vector3.new()
end
t1.value4.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == t1.value29 and t1.value71 then
        t1.value107()
    end
end)
t1.value108 = t1.value3.RenderStepped:Connect(function()
    if t1.value70 then
        t1.value96.FieldOfView = t1.value28

        return
    end

    if t1.value96.FieldOfView ~= 75 then
        t1.value96.FieldOfView = 75
    end
end)
function t1.value109(p184)
    if not t1.value78 then
        return
    end

    local v382 = math.clamp((t1.value96.CFrame.Position - p184).Magnitude / 40, 0.8, 3.5) / 2
    local Part = Instance.new("Part")

    Part.Name = "HitImagePart"
    Part.Size = Vector3.new(1, 1, 1)
    Part.Transparency = 1
    Part.CanCollide = false
    Part.Anchored = true
    Part.Position = p184 + Vector3.new(0, 3, 0)
    Part.Parent = t1.value1

    local BillboardGui = Instance.new("BillboardGui")

    BillboardGui.Adornee = Part
    BillboardGui.Size = UDim2.new(6 * v382, 0, 6 * v382, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.LightInfluence = 0
    BillboardGui.Parent = Part

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://113750946560821"
    ImageLabel.ImageColor3 = t1.value46
    ImageLabel.Parent = BillboardGui
    task.delay(2, function()
        if Part and Part.Parent then
            Part:Destroy()
        end
    end)
end
task.spawn(function()
    local Const = t1.value1:FindFirstChild("Const")

    if not Const then
        return
    end

    local Ignore = Const:FindFirstChild("Ignore")

    if not Ignore then
        return
    end

    Ignore.ChildRemoved:Connect(function(child)
        if child.Name ~= "Arrow" and (child.Name ~= "Bullet" and child.Name ~= "BlueBullet") then
            return
        end

        local childPosition = child.Position

        task.wait(0.05)

        local v772 = t1.value1:FindFirstChild("PlayerHitHeadshot", true) or t1.value1:FindFirstChild("PlayerHit2", true)

        if v772 and v772:IsA("Sound") then
            t1.value109(childPosition)
        end
    end)
end)
t1.value110 = nil
t1.value111 = nil
function t1.value112()
    local PlayerHitHeadshot = t1.value1:FindFirstChild("PlayerHitHeadshot")

    if PlayerHitHeadshot and PlayerHitHeadshot:IsA("Sound") then
        return PlayerHitHeadshot
    end

    return nil
end
function t1.value113(p185)
    if not p185 then
        return nil
    end

    local Sound = Instance.new("Sound")

    for _, v in ipairs({
		"Volume",
		"Pitch",
		"PlaybackSpeed",
		"Looped",
		"RollOffMode",
		"EmitterSize",
		"MaxDistance",
		"MinDistance",
		"PlayOnRemove",
		"TimePosition",
		"PlaybackRegionsEnabled",
		"PlaybackRegion",
		"PlaybackLoudness",
		"PlayInBackground",
		"RespectFilteringEnabled"
	}) do
        local v393 = v

        pcall(function()
            Sound[v393] = p185[v393]
        end)
    end

    Sound.SoundId = "rbxassetid://7130144078"
    Sound.Volume = t1.value47

    return Sound
end
t1.value3.Stepped:Connect(function()
    if not t1.value79 then
        return
    end

    pcall(function()
        local v773 = t1.value112()

        if v773 then
            if v773 ~= t1.value111 then
                if t1.value110 then
                    t1.value110:Destroy()
                end

                t1.value110 = t1.value113(v773)

                if t1.value110 then
                    t1.value110.Parent = t1.value1
                end
            end

            if v773.IsPlaying then
                v773:Pause()
                v773.Volume = 0

                if t1.value110 then
                    t1.value110.TimePosition = v773.TimePosition

                    if not t1.value110.IsPlaying then
                        t1.value110:Play()
                    end
                end
            end
        end
    end)
end)
local v140 = t1.value112()
if v140 then
    t1.value110 = t1.value113(v140)

    if t1.value110 then
        t1.value110.Parent = t1.value1
    end
end
t1.value114 = {
	Messages = {},
	MaxMessages = 5,
	Drawings = {},
	Backgrounds = {},
	CleanupInterval = nil
}
local new = Vector2.new
t1.value115 = nil
new(1920, 1080)
t1.value116 = 960
t1.value117 = nil
t1.value118 = nil
t1.value117 = 700
t1.value118 = 30
t1.value115 = 300
function t1.value119(p186)
    local drawing = Drawing.new("Square")

    drawing.Position = Vector2.new(t1.value116 - t1.value115 / 2, t1.value117 - p186 * t1.value118 - 4)
    drawing.Size = Vector2.new(t1.value115, t1.value118 - 2)
    drawing.Color = Color3.fromRGB(0, 0, 0)
    drawing.Transparency = 0.6
    drawing.Filled = true
    drawing.Visible = true
    drawing.ZIndex = 0

    return drawing
end
function t1.value120(p187)
    local drawing = Drawing.new("Square")

    drawing.Position = Vector2.new(t1.value116 - t1.value115 / 2, t1.value117 - p187 * t1.value118 - 4)
    drawing.Size = Vector2.new(t1.value115, t1.value118 - 2)
    drawing.Color = Color3.fromRGB(100, 100, 100)
    drawing.Thickness = 1
    drawing.Filled = false
    drawing.Visible = true
    drawing.ZIndex = 1

    return drawing
end
function t1.value121(p188, p189, p190)
    local drawing = Drawing.new("Text")

    drawing.Text = p188
    drawing.Size = 18
    drawing.Font = 2
    drawing.Center = true
    drawing.Outline = true
    drawing.OutlineColor = Color3.fromRGB(0, 0, 0)

    if p190 then
        p190 = Color3.fromRGB(255, 70, 70)
    end

    drawing.Color = p190 or Color3.fromRGB(255, 255, 255)

    local new2 = Vector2.new
    local v407 = t1.value117 - p189 * t1.value118

    drawing.Position = new2(t1.value116, v407)
    drawing.Visible = true
    drawing.ZIndex = 2

    return drawing
end
function t1.value122(p191)
    if p191.drawing then
        p191.drawing.Visible = false
        p191.drawing:Remove()
    end

    if p191.background then
        p191.background.Visible = false
        p191.background:Remove()
    end

    if p191.border then
        p191.border.Visible = false
        p191.border:Remove()
    end
end
t1.value123 = nil
function t1.value123()
    for i, v in ipairs(t1.value114.Messages) do
        local v399 = i - 1

        if v.drawing then
            v.drawing.Position = Vector2.new(t1.value116, t1.value117 - v399 * t1.value118)
        end

        if v.background then
            v.background.Position = Vector2.new(t1.value116 - t1.value115 / 2, t1.value117 - v399 * t1.value118 - 4)
        end

        if v.border then
            v.border.Position = Vector2.new(t1.value116 - t1.value115 / 2, t1.value117 - v399 * t1.value118 - 4)
        end
    end
end
t1.value124 = nil
function t1.value124()
    if t1.value114.CleanupInterval then
        return
    end

    t1.value114.CleanupInterval = task.spawn(function()
        while true do
            task.wait(60)

            for i = #t1.value114.Messages, 1, -1 do
                local v775 = i
                local v776 = t1.value114.Messages[v775]

                if v776 and (v776.time and tick() - v776.time > 10) then
                    t1.value122(v776)
                    table.remove(t1.value114.Messages, v775)
                end
            end

            t1.value123()
        end
    end)
end
function t1.value125(p192, p193)
    if #t1.value114.Messages >= t1.value114.MaxMessages then
        local v410 = table.remove(t1.value114.Messages, #t1.value114.Messages)

        if v410 then
            t1.value122(v410)
        end
    end

    local n3 = 0

    for i, v in ipairs(t1.value114.Messages) do
        v.yOffset = i - 1
    end

    local v414 = t1.value119(n3)
    local v415 = t1.value120(n3)
    local v416 = t1.value121(p192, n3, p193)
    local timestamp = tick()
    local t18 = {
		text = p192,
		drawing = v416,
		background = v414,
		border = v415,
		time = timestamp,
		isDead = p193
	}

    table.insert(t1.value114.Messages, 1, t18)
    task.delay(5, function()
        for i, v in ipairs(t1.value114.Messages) do
            if v.drawing == v416 then
                t1.value122(v)
                table.remove(t1.value114.Messages, i)
                t1.value123()

                return
            end
        end
    end)
    t1.value124()
end
local function v142(p194)
    local v420, v421, _, v423, v424, v425 = string.match(p194, "^(%S+)%s+%->(%S+)%s+(%d+)s%s+(%S+)%s+(%d+%.?%d*)%->(%d+%.?%d*)hp$")

    if v420 then
        v420 = v421 and (v423 and (v424 and v425))
    end

    if v420 then
        local num = tonumber(v425)

        if num == 0 then
            t1.value125(v421 .. " dead " .. v423, true)
        else
            t1.value125(v421 .. " hitted " .. v423 .. " hp left " .. num, false)
        end

        return true
    end

    return false
end
game:GetService("LogService").MessageOut:Connect(function(p195, _)
    if t1.value80 then
        v142(p195)
    end
end)
function t1.value126(p197)
    local v437 = t1.value10(p197, "LowerTorso")

    if not v437 then
        return false
    end

    local v438 = t1.value10(v437, "RootRig")

    if v438 and (typeof(v438.CurrentAngle) == "number" and v438.CurrentAngle ~= 0) then
        return true
    end

    return false
end
function t1.value127(p198)
    if t1.value126(p198) then
        return "Sleeper"
    end

    local v449 = t1.value37[p198]

    if not (v449 ~= nil) then
        local v450 = t1.value10(p198, "Torso")

        if not v450 then
            t1.value37[p198] = false
            v449 = false
        else
            v449 = not not t1.value10(v450, "LeftBooster")
            t1.value37[p198] = v449
        end
    end

    if v449 then
        return "Enemy"
    end

    return "Bot"
end
t1.value128 = nil
function t1.value128(p199)
    local v440 = t1.value10(p199, "HandModel")

    if not v440 then
        t1.value36[p199] = "None"

        return
    end

    local s1 = "None"
    local n4 = 0

    for k, v in pairs(t1.value35) do
        local n5 = 0

        for _, v5 in ipairs(v) do
            if v440:FindFirstChild(v5, true) then
                n5 += 1
            end
        end

        if n4 < n5 then
            s1 = k
            n4 = n5
        end
    end

    t1.value36[p199] = n4 >= 3 and s1 or "None"
end
function t1.value129(p200)
    if t1.value38[p200] then
        return
    end

    t1.value38[p200] = true

    local v452 = t1.value10(p200, "HandModel")

    if v452 then
        t1.value128(p200)
        v452.DescendantAdded:Connect(function()
            t1.value128(p200)
        end)
        v452.DescendantRemoving:Connect(function()
            t1.value128(p200)
        end)
    end
end
function t1.value130(p201)
    if not p201 or (t1.value39[p201] or p201 == t1.value5.Character) then
        return
    end

    if not t1.value10(p201, "HumanoidRootPart") then
        return
    end

    t1.value39[p201] = true
    t1.value129(p201)
end
function t1.value131(p202)
    if t1.value39[p202] then
        t1.value39[p202] = nil

        if t1.value86[p202] then
            for _, v in pairs(t1.value86[p202]) do
                t1.value17(v)
            end

            t1.value86[p202] = nil
        end

        t1.value36[p202] = nil
        t1.value37[p202] = nil
        t1.value38[p202] = nil
        boxes[p202] = nil
    end
end
setmetatable({}, {
	__mode = "k"
})
function t1.value132()
    return {
		box = t1.value14.utility.new_drawing("Square", {
			Visible = false,
			Filled = false,
			Thickness = 2,
			ZIndex = 1
		}),
		nameText = t1.value14.utility.new_drawing("Text", {
			Visible = false,
			Size = 14,
			Center = true,
			Font = 2,
			Outline = true,
			ZIndex = 2
		}),
		weaponText = t1.value14.utility.new_drawing("Text", {
			Visible = false,
			Size = 13,
			Center = true,
			Font = 2,
			Outline = true,
			ZIndex = 2
		}),
		distanceText = t1.value14.utility.new_drawing("Text", {
			Visible = false,
			Size = 13,
			Center = true,
			Font = 2,
			Outline = false,
			ZIndex = 2
		})
	}
end
function t1.value133()
    if not t1.value66 then
        for _, v in pairs(t1.value86) do
            for _, v6 in pairs(v) do
                if v6 then
                    v6.Visible = false
                end
            end
        end

        return
    end
    local CFramePosition = t1.value96.CFrame.Position
    local value96 = t1.value96
    local value23 = t1.value23
    math.tan((math.rad(value96.FieldOfView * 0.5)))
    for v463, v464 in pairs(t1.value86) do

        local v465 = not v463

        if not v465 then
            v465 = not v463.Parent

            if not v465 then
                v465 = not v463:FindFirstChild("HumanoidRootPart")
            end
        end

        if v465 then
            for _, v in pairs(v464) do
                t1.value17(v)
            end

            t1.value86[v463] = nil
        end
    end
    for k in pairs(t1.value39) do
        local v469 = k

        if not v469 or not v469.Parent then
            t1.value131(v469)
        else
            local HumanoidRootPart = v469:FindFirstChild("HumanoidRootPart")

            if HumanoidRootPart then
                local Magnitude = (CFramePosition - HumanoidRootPart.Position).Magnitude

                if value23 < Magnitude then
                    if t1.value86[v469] then
                        for _, v in pairs(t1.value86[v469]) do
                            v.Visible = false
                        end
                    end
                else
                    local v474 = t1.value127(v469)
                    local v475 = t1.value31[v474]

                    if not v475 or not v475.Enabled then
                        if t1.value86[v469] then
                            for _, v in pairs(t1.value86[v469]) do
                                v.Visible = false
                            end
                        end
                    else
                        if not t1.value86[v469] then
                            t1.value86[v469] = t1.value132()
                        end

                        local v478 = t1.value86[v469]
                        local v479, v480 = t1.value11(t1.value96, HumanoidRootPart.Position)

                        if not v480 then
                            for _, v in pairs(v478) do
                                v.Visible = false
                            end
                        else
                            local v483 = 30 / Magnitude
                            local v484 = t1.value13((math.max(60 * v483, 8)))
                            local v485 = t1.value13((math.max(80 * v483, 12)))

                            if v484 < 2 or v485 < 2 then
                                for _, v in pairs(v478) do
                                    v.Visible = false
                                end
                            else
                                local vector2 = Vector2.new(v484, v485)

                                if v475.Box then
                                    v478.box.Size = vector2
                                    v478.box.Position = Vector2.new(v479.X - vector2.X / 2, v479.Y - vector2.Y / 2)
                                    v478.box.Color = v475.BoxColor
                                    v478.box.Thickness = not v475.BoxOutline and 2 or 3
                                    v478.box.Visible = true
                                else
                                    v478.box.Visible = false
                                end

                                local v489 = t1.value36[v469] or "None"
                                local v490 = v474 == "Sleeper" and "SLEEPER"

                                if not v490 then
                                    v490 = v474 == "Enemy" and "ENEMY" or "BOT"
                                end

                                if v475.Name then
                                    v478.nameText.Text = v490
                                    v478.nameText.Position = Vector2.new(v479.X, v479.Y - vector2.Y / 2 - 18)
                                    v478.nameText.Color = v475.NameColor
                                    v478.nameText.Outline = v475.NameOutline
                                    v478.nameText.OutlineColor = v475.NameOutlineColor
                                    v478.nameText.Visible = true
                                else
                                    v478.nameText.Visible = false
                                end

                                if v475.Weapon then
                                    v478.weaponText.Text = v489
                                    v478.weaponText.Position = Vector2.new(v479.X, v479.Y + vector2.Y / 2 + 6)
                                    v478.weaponText.Color = v475.WeaponColor
                                    v478.weaponText.Outline = v475.WeaponOutline
                                    v478.weaponText.OutlineColor = v475.WeaponOutlineColor
                                    v478.weaponText.Visible = true
                                else
                                    v478.weaponText.Visible = false
                                end

                                if v475.Distance then
                                    local v491 = v479.Y + vector2.Y / 2 + (not v475.Weapon and 6 or 26)

                                    v478.distanceText.Text = t1.value13(Magnitude) .. "m"
                                    v478.distanceText.Position = Vector2.new(v479.X, v491)
                                    v478.distanceText.Color = v475.DistanceColor
                                    v478.distanceText.Outline = v475.DistanceOutline
                                    v478.distanceText.OutlineColor = v475.DistanceOutlineColor
                                    v478.distanceText.Visible = true
                                else
                                    v478.distanceText.Visible = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end
local function v143()
    local MouseLocation = t1.value4:GetMouseLocation()
    local value18 = t1.value18
    local v494
    local v495
    for k in pairs(t1.value39) do
        local v497 = k

        if v497 and v497.Parent then
            local v498 = t1.value126(v497)
            local v499 = t1.value37[v497]

            if not (v499 ~= nil) then
                local v500 = t1.value10(v497, "Torso")

                if not v500 then
                    t1.value37[v497] = false
                    v499 = false
                else
                    v499 = not not t1.value10(v500, "LeftBooster")
                    t1.value37[v497] = v499
                end
            end

            local v501 = not (t1.value64 and v498)

            if v501 then
                v501 = not (t1.value65 and not v499)
            end

            if v501 then
                local v502 = t1.value10(v497, "Head")

                if v502 and (t1.value96.CFrame.Position - v502.Position).Magnitude <= t1.value19 then
                    local v503, v504 = t1.value11(t1.value96, v502.Position)

                    if v504 then
                        local Magnitude = (t1.value9(v503.X, v503.Y) - MouseLocation).Magnitude

                        if Magnitude < value18 then
                            value18 = Magnitude
                            v494 = v502
                            v495 = t1.value9(v503.X, v503.Y)
                        end
                    end
                end
            end
        else
            t1.value131(v497)
        end
    end
    t1.value20 = v494
    t1.value21 = v495
end
t1.value134 = setmetatable({}, {
	__mode = "k"
})
function t1.value135(p203)
    if not t1.value62 or not t1.value12(p203, "BasePart") then
        return
    end

    if t1.value134[p203] then
        for _, v in pairs(t1.value134[p203]) do
            if v then
                v:Disconnect()
            end
        end

        t1.value134[p203] = nil
    end

    local t19 = {}
    local u510 = false

    t19.cfConn = p203:GetPropertyChangedSignal("CFrame"):Connect(function()
        if not p203.Parent then
            for _, v in pairs(t19) do
                local v781 = v

                pcall(function()
                    v781:Disconnect()
                end)
            end

            return
        end

        if not u510 and (t1.value96.CFrame.Position - p203.Position).Magnitude < 5 then
            u510 = true
        end

        local v782 = t1.value22 or t1.value20

        if u510 and (v782 and (v782.Parent and t1.value63)) then
            local v783 = t1.value126(v782.Parent)
            local Parent = v782.Parent
            local v785 = t1.value37[Parent]

            if not (v785 ~= nil) then
                local v786 = t1.value10(Parent, "Torso")

                if not v786 then
                    t1.value37[Parent] = false
                    v785 = false
                else
                    v785 = not not t1.value10(v786, "LeftBooster")
                    t1.value37[Parent] = v785
                end
            end

            if t1.value64 and v783 then
                return
            end

            if t1.value65 and not v785 then
                return
            end

            local v787 = t1.value10(v782.Parent, "HumanoidRootPart") or v782

            if v787 then
                pcall(function()
                    v787.CFrame = t1.value8(p203.Position.X, v787.Position.Y, p203.Position.Z)
                end)
            end
        end
    end)
    t19.ancestryConn = p203.AncestryChanged:Connect(function(_, parent)
        if not parent then
            for _, v in pairs(t19) do
                local v792 = v

                pcall(function()
                    v792:Disconnect()
                end)
            end

            t1.value134[p203] = nil
        end
    end)
    t1.value134[p203] = t19
end
if t1.value1:FindFirstChild("Const") and t1.value1.Const:FindFirstChild("Ignore") then
    t1.value1.Const.Ignore.ChildAdded:Connect(function(child)
        local v512 = t1.value12(child, "BasePart")

        if v512 then
            v512 = child.Name == "Arrow" or (child.Name == "Bullet" or child.Name == "BulletBlue")
        end

        if v512 then
            t1.value135(child)
        end
    end)
end
t1.value5.CharacterAdded:Connect(function()
    t1.value21 = nil
end)
function t1.value136(p205, p206)
    local v531 = p206 == "Box" and p205:FindFirstChild("Body")

    if not v531 then
        v531 = p206 == "MiniBox" and p205:FindFirstChild("box") or (p206 == "Metal" and p205:FindFirstChild("default") or p206 == "Bloxy" and p205:FindFirstChild("Sign"))
    end

    if v531 and v531:IsA("BasePart") then
        t1.value42[p206][v531] = true
    end
end
function t1.value137(p207, p208)
    if p208 == "Cactus" then
        local Part = p207:FindFirstChild("Part")

        if Part and Part:IsA("BasePart") then
            t1.value44[p208][Part] = true

            return
        end
    elseif p208 == "Tree" then
        local default = p207:FindFirstChild("default")

        if default and default:IsA("BasePart") then
            t1.value44[p208][default] = true

            return
        end
    elseif p208 == "Stone" or (p208 == "Nitrate" or p208 == "Iron") then
        local Part = p207:FindFirstChild("Part")

        if Part and Part:IsA("BasePart") then
            t1.value44[p208][Part] = true
        end
    end
end
t1.value138 = {}
t1.value139 = nil
function t1.value139()
    local drawing = Drawing.new("Text")

    drawing.Visible = false
    drawing.Size = 14
    drawing.Center = true
    drawing.Outline = true
    drawing.OutlineColor = Color3.new(0, 0, 0)
    drawing.Color = Color3.new(1, 0.4, 0.4)
    drawing.Text = "CORPSE"
    drawing.Font = 2

    return drawing
end
function t1.value140()
    if not t1.value31.Enemy.Corpse then
        for k, v in pairs(t1.value138) do
            t1.value17(v)
            t1.value138[k] = nil
        end

        return
    end
    for v593, v594 in pairs(t1.value138) do

        if not v593 or (not v593.Parent or not v593.Parent.Parent) then
            t1.value17(v594)
            t1.value138[v593] = nil
        end
    end
    for _, child in ipairs(t1.value1:GetChildren()) do
        if child:IsA("Model") and child.Name == "Model" then
            local Part = child:FindFirstChild("Part")

            if Part and Part:IsA("BasePart") then
                local PartSize = Part.Size

                if math.abs(PartSize.X - 0.19) <= 0.05 and (math.abs(PartSize.Y - 0.39) <= 0.05 and math.abs(PartSize.Z - 0.19) <= 0.05) then
                    if not t1.value138[Part] then
                        t1.value138[Part] = t1.value139()
                    end

                    local v599 = t1.value138[Part]
                    local v600, v601 = t1.value96:WorldToViewportPoint(Part.Position + Vector3.new(0, 1.5, 0))

                    if v601 then
                        v599.Position = Vector2.new(v600.X, v600.Y)
                        v599.Visible = true
                    else
                        v599.Visible = false
                    end
                end
            end
        end
    end
end
t1.value141 = {}
function t1.value142()
    local drawing = Drawing.new("Text")

    drawing.Visible = false
    drawing.Size = 14
    drawing.Center = true
    drawing.Outline = true
    drawing.Color = Color3.new(1, 0, 1)
    drawing.Text = "Helicopter"

    return drawing
end
function t1.value143()
    if not t1.value32.Helicopter.Enabled then
        for _, v in pairs(t1.value141) do
            if v then
                v.Visible = false
            end
        end

        return
    end
    for v606, v607 in pairs(t1.value141) do

        if not v606 or not v606.Parent then
            v607:Remove()
            t1.value141[v606] = nil
        end
    end
    for _, child in ipairs(t1.value1:GetChildren()) do
        if child:IsA("Model") and child.Name == "Model" then
            local BodyDummy = child:FindFirstChild("BodyDummy")

            if BodyDummy and BodyDummy:IsA("BasePart") then
                if not t1.value141[BodyDummy] then
                    t1.value141[BodyDummy] = t1.value142()
                end

                local v611 = t1.value141[BodyDummy]
                local v612, v613 = t1.value96:WorldToViewportPoint(BodyDummy.Position)

                if v613 then
                    v611.Position = Vector2.new(v612.X, v612.Y)
                    v611.Visible = true
                else
                    v611.Visible = false
                end
            end
        end
    end
end
function t1.value144()
    if not t1.value67 then
        for _, v in pairs(t1.value41) do
            for _, v7 in pairs(v) do
                t1.value17(v7)
            end

            table.clear(v)
        end

        return
    end
    local CFramePosition = t1.value96.CFrame.Position
    local value24 = t1.value24
    for v622, v623 in pairs(t1.value41) do

        for k, v in pairs(v623) do
            local v626 = k

            if not v626 or not v626.Parent then
                t1.value17(v)
                v623[v626] = nil

                if t1.value40[v622][v626] then
                    t1.value40[v622][v626] = nil
                end
            end
        end
    end
    for k, v in pairs(t1.value32) do
        local v629 = k

        if v629 == "Helicopter" then
            t1.value143()
        elseif not v.Enabled then
            for _, v8 in pairs(t1.value41[v629]) do
                t1.value17(v8)
            end

            table.clear(t1.value41[v629])
        else
            for k2 in pairs(t1.value40[v629]) do
                local v633 = k2

                if v633 and v633.Parent then
                    if value24 >= (CFramePosition - v633.Position).Magnitude then
                        if not t1.value41[v629][v633] then
                            local v634 = if v629 ~= "Quad" then v629:upper() else "QUAD BIKE"
                            local v635 = t1.value41[v629]
                            local new_drawing = t1.value14.utility.new_drawing
                            local NameColor = v.NameColor

                            v635[v633] = new_drawing("Text", {
								Size = 14,
								Center = true,
								Outline = true,
								Font = 2,
								Text = v634,
								Color = NameColor
							})
                        end
                        local v638 = t1.value41[v629][v633]
                        local v640, t20Result = t1.value11(t1.value96, v633.Position)
                        if t20Result then
                            v638.Position = t1.value9(v640.X, v640.Y)
                            v638.Color = v.NameColor
                            v638.Outline = v.NameOutline
                            v638.OutlineColor = v.NameOutlineColor
                            v638.Visible = true
                        else
                            v638.Visible = false
                        end
                    elseif t1.value41[v629][v633] then
                        t1.value41[v629][v633].Visible = false
                    end
                else
                    local v641 = t1.value41[v629][v633]

                    t1.value17(v641)
                    t1.value41[v629][v633] = nil
                    t1.value40[v629][v633] = nil
                end
            end
        end
    end
end
function t1.value145()
    if not t1.value68 then
        for _, v in pairs(t1.value43) do
            for _, v9 in pairs(v) do
                t1.value17(v9)
            end

            table.clear(v)
        end

        return
    end
    local CFramePosition = t1.value96.CFrame.Position
    local value25 = t1.value25
    for v568, v569 in pairs(t1.value43) do

        for k, v in pairs(v569) do
            local v572 = k

            if not v572 or not v572.Parent then
                t1.value17(v)
                v569[v572] = nil
                t1.value42[v568][v572] = nil
            end
        end
    end
    for k, v in pairs(t1.value33) do
        local v575 = k

        if not v.Enabled then
            for _, v10 in pairs(t1.value43[v575]) do
                t1.value17(v10)
            end

            table.clear(t1.value43[v575])
        else
            for k3 in pairs(t1.value42[v575]) do
                local v579 = k3

                if v579 and v579.Parent then
                    if value25 >= (CFramePosition - v579.Position).Magnitude then
                        if not t1.value43[v575][v579] then
                            local v580 = if v575 ~= "MiniBox" then v575:upper() else "MINI BOX"

                            t1.value43[v575][v579] = t1.value14.utility.new_drawing("Text", {
								Size = 14,
								Center = true,
								Outline = true,
								Font = 2,
								Text = v580
							})
                        end
                        local v581 = t1.value43[v575][v579]
                        local v583, t21Result = t1.value11(t1.value96, v579.Position)
                        if t21Result then
                            v581.Position = t1.value9(v583.X, v583.Y)
                            v581.Color = v.NameColor
                            v581.Outline = v.NameOutline
                            v581.OutlineColor = v.NameOutlineColor
                            v581.Visible = true
                        else
                            v581.Visible = false
                        end
                    elseif t1.value43[v575][v579] then
                        t1.value43[v575][v579].Visible = false
                    end
                else
                    local v584 = t1.value43[v575][v579]

                    t1.value17(v584)
                    t1.value43[v575][v579] = nil
                    t1.value42[v575][v579] = nil
                end
            end
        end
    end
end
function t1.value146()
    if not t1.value69 then
        for _, v in pairs(t1.value45) do
            for _, v11 in pairs(v) do
                t1.value17(v11)
            end

            table.clear(v)
        end

        return
    end
    local CFramePosition = t1.value96.CFrame.Position
    local value26 = t1.value26
    for v540, v541 in pairs(t1.value45) do

        for k, v in pairs(v541) do
            local v544 = k

            if not v544 or not v544.Parent then
                t1.value17(v)
                v541[v544] = nil
                t1.value44[v540][v544] = nil
            end
        end
    end
    for k, v in pairs(t1.value34) do
        local v547 = k

        if not v.Enabled then
            for _, v12 in pairs(t1.value45[v547]) do
                t1.value17(v12)
            end

            table.clear(t1.value45[v547])
        else
            for k4 in pairs(t1.value44[v547]) do
                local v551 = k4

                if v551 and v551.Parent then
                    if value26 >= (CFramePosition - v551.Position).Magnitude then
                        if not t1.value45[v547][v551] then
                            local v552 = t1.value45[v547]
                            local new_drawing = t1.value14.utility.new_drawing
                            local v554 = v547:upper()
                            local NameColor = v.NameColor

                            v552[v551] = new_drawing("Text", {
								Size = 14,
								Center = true,
								Outline = true,
								Font = 2,
								Text = v554,
								Color = NameColor
							})
                        end
                        local v556 = t1.value45[v547][v551]
                        local v558, t22Result = t1.value11(t1.value96, v551.Position)
                        if t22Result then
                            v556.Position = t1.value9(v558.X, v558.Y)
                            v556.Color = v.NameColor
                            v556.Outline = v.NameOutline
                            v556.OutlineColor = v.NameOutlineColor
                            v556.Visible = true
                        else
                            v556.Visible = false
                        end
                    elseif t1.value45[v547][v551] then
                        t1.value45[v547][v551].Visible = false
                    end
                else
                    local v559 = t1.value45[v547][v551]

                    t1.value17(v559)
                    t1.value45[v547][v551] = nil
                    t1.value44[v547][v551] = nil
                end
            end
        end
    end
end
function t1.value147()
    local Part = Instance.new("Part")

    Part.Name = "!.!"
    Part.Size = Vector3.new(4, 0.2, 4)
    Part.Anchored = true
    Part.Color = Color3.fromRGB(255, 255, 255)
    Part.Transparency = 0
    Part.Material = Enum.Material.Neon
    Part.CanCollide = false
    Part.Parent = t1.value1

    local SpecialMesh = Instance.new("SpecialMesh")

    SpecialMesh.MeshType = Enum.MeshType.FileMesh
    SpecialMesh.Parent = Part

    return Part
end
t1.value4.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and t1.value49 then
        t1.value49.CanCollide = true
    end
end)
t1.value4.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) and t1.value49 then
        t1.value49.CanCollide = false
    end
end)
t1.value3.RenderStepped:Connect(function()
    if not t1.value82 then
        if t1.value49 then
            t1.value49:Destroy()
            t1.value49 = nil
        end

        return
    end
    local success, result = pcall(function()
        return t1.value1.Const.Ignore.LocalCharacter.Middle.Position
    end)
    if success then
        if not t1.value49 or not t1.value49.Parent then
            t1.value49 = t1.value147()
        end

        if t1.value49 then
            t1.value49.Position = result - Vector3.new(0, 3.5, 0)
        end
    end
end)
t1.value148 = {
	Enabled = true,
	Speed = 40,
	Middle = nil
}
t1.value149 = false
t1.value150 = 0
t1.value151 = false
t1.value152 = 0
t1.value153 = false
function t1.value154()
    pcall(function()
        t1.value148.Middle = t1.value1.Const.Ignore.LocalCharacter.Middle
    end)
end
t1.value154()
t1.value3.RenderStepped:Connect(function(_)
    if not t1.value72 then
        return
    end

    if not t1.value148.Middle or not t1.value148.Middle.Parent then
        t1.value154()

        return
    end

    local Middle = t1.value148.Middle
    local v670 = t1.value4:IsKeyDown(Enum.KeyCode.LeftShift)
    local v671 = t1.value4:IsKeyDown(Enum.KeyCode.C)
    local value72 = t1.value72

    if value72 then
        value72 = v670 and v671
    end

    if value72 then
        if not t1.value153 then
            t1.value153 = true
            t1.value149 = false
        end

        local vector3_4 = Vector3.new(0, 0, 0)
        local LookVector = t1.value96.CFrame.LookVector
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit

        if t1.value4:IsKeyDown(Enum.KeyCode.W) then
            vector3_4 += Unit
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.S) then
            vector3_4 -= Unit
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.D) then
            vector3_4 += Vector3.new(-Unit.Z, 0, Unit.X)
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.A) then
            vector3_4 += Vector3.new(Unit.Z, 0, -Unit.X)
        end

        if vector3_4.Magnitude > 0 then
            local Unit2 = vector3_4.Unit

            if not t1.value149 then
                t1.value150 = tick()
                t1.value152 = Middle.AssemblyLinearVelocity.Y + 4
                t1.value151 = false
            end

            if tick() - t1.value150 < 0.9 then
                if not t1.value151 then
                    Middle.AssemblyLinearVelocity = Vector3.new(Unit2.X * t1.value148.Speed, t1.value152, Unit2.Z * t1.value148.Speed)

                    return
                end

                Middle.AssemblyLinearVelocity = Vector3.new(Unit2.X * t1.value148.Speed, t1.value152, Unit2.Z * t1.value148.Speed)

                return
            end

            local AssemblyLinearVelocity = Middle.AssemblyLinearVelocity

            Middle.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X * 1, AssemblyLinearVelocity.Y, AssemblyLinearVelocity.Z * 1)

            return
        end
    elseif not t1.value153 then
    end
end)
t1.value155 = nil
t1.value156 = nil
t1.value157 = nil
t1.value158 = nil
t1.value159 = nil
function t1.value160()
    local Part = Instance.new("Part")

    Part.Name = "ArrowTrailFollow"
    Part.Anchored = true
    Part.CanCollide = false
    Part.Transparency = 1
    Part.Size = Vector3.new(1, 1, 1)
    Part.Position = Vector3.new(0, 0, 0)
    Part.Parent = t1.value1
    Part.Material = Enum.Material.ForceField
    task.wait()

    local Attachment = Instance.new("Attachment")

    Attachment.Name = "Attachment1"
    Attachment.Position = Vector3.new(0, 0, 0)
    Attachment.Parent = Part

    local Attachment2 = Instance.new("Attachment")

    Attachment2.Name = "Attachment2"
    Attachment2.Position = Vector3.new(0.586, 0, 0)
    Attachment2.Parent = Part

    local Trail = Instance.new("Trail")

    Trail.Name = "Trail"
    Trail.Lifetime = 6
    Trail.Texture = "rbxassetid://90089489358574"
    Trail.MaxLength = 0
    Trail.MinLength = 0.1
    Trail.Enabled = true
    Trail.Attachment0 = Attachment
    Trail.Attachment1 = Attachment2
    Trail.Parent = Part
    Trail.FaceCamera = true
    Trail.WidthScale = NumberSequence.new(0.2)

    return Part, Trail
end
function t1.value161()
    if t1.value156 and (t1.value155 and t1.value155.Parent) then
        t1.value156.Position = t1.value155.Position
    end
end
t1.value162 = nil
function t1.value162(p210, p211)
    if p210 then
        p210.Transparency = 0

        if p211 then
            p211.Enabled = false
        end

        task.delay(6, function()
            if p210 and p210.Parent then
                p210:Destroy()
            end
        end)
    end
end
t1.value163 = nil
function t1.value163()
    if t1.value158 then
        t1.value158:Disconnect()
        t1.value158 = nil
    end

    if t1.value159 then
        t1.value159:Disconnect()
        t1.value159 = nil
    end

    if t1.value156 then
        t1.value162(t1.value156, t1.value157)
        t1.value156 = nil
        t1.value157 = nil
    end
end
function t1.value164(p212)
    if not t1.value81 then
        return
    end

    if not p212 or not p212.Parent then
        return
    end

    if not p212.Name:upper():find("ARROW") and not p212.Name:upper():find("BULLET") then
        return
    end

    task.wait(0.03)

    local v685 = p212:IsA("BasePart") and p212 or p212:FindFirstChildWhichIsA("BasePart")

    if not v685 then
        return
    end

    local v686 = (t1.value96.CFrame.Position - v685.Position).Magnitude < 1

    if not v686 then
        v686 = (v685.Position - t1.value96.CFrame.Position).Unit:Dot(t1.value96.CFrame.LookVector) > 0.85
    end

    if not v686 then
        return
    end

    if t1.value156 then
        local value156 = t1.value156
        local value157 = t1.value157

        t1.value162(value156, value157)
    end

    local Trail = v685:FindFirstChildOfClass("Trail")

    if Trail then
        Trail.Enabled = false
    end

    local _, _ = t1.value160()

    if t1.value158 then
        t1.value158:Disconnect()
    end

    t1.value3.Heartbeat:Connect(t1.value161)

    if t1.value159 then
        t1.value159:Disconnect()
    end

    v685.AncestryChanged:Connect(function(_, parent)
        if not parent then
            t1.value163()
        end
    end)
end;
(function()
    local Const = t1.value1:FindFirstChild("Const")
    local v693 = Const and Const:FindFirstChild("Ignore")

    if v693 then
        for _, child in ipairs(v693:GetChildren()) do
            t1.value164(child)
        end

        v693.ChildAdded:Connect(t1.value164)
    end
end)()
function t1.value165(p214)
    if not p214 or not p214:IsA("Model") then
        return false
    end

    return p214:FindFirstChild("Color") and (p214:FindFirstChild("Metal") and p214:FindFirstChild("Seats"))
end
function t1.value166(p215)
    if not p215 or not p215:IsA("Model") then
        return false
    end

    local FRWheel = p215:FindFirstChild("FRWheel")

    if not FRWheel then
        FRWheel = p215:FindFirstChild("FLWheel") or (p215:FindFirstChild("BRWheel") or p215:FindFirstChild("BLWheel"))
    end

    return FRWheel and p215:FindFirstChild("Frame") or (p215:FindFirstChild("Body") or p215:FindFirstChild("Hull"))
end
t1.value167 = nil
function t1.value167(p216)
    return t1.value166(p216) or t1.value165(p216)
end
function t1.value168(p217)
    if not p217 or not p217.Parent then
        return
    end

    for _, descendant in ipairs(p217:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
            descendant.Anchored = true

            if t1.value74 then
                descendant.CanCollide = false
            else
                descendant.CanCollide = true
            end
        end
    end
end
function t1.value169()
    if t1.value53 and t1.value53.Parent then
        for _, descendant in ipairs(t1.value53:GetDescendants()) do
            if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
                descendant.Anchored = false
                descendant.CanCollide = true
            end
        end
    end

    t1.value53 = nil
    vehicleMomentum = Vector3.new(0, 0, 0)
end
function t1.value170()
    if t1.value53 and (t1.value53.Parent and tick() - t1.value54 < t1.value55) then
        return t1.value53
    end
    tick()
    local v696
    local n6 = 100
    local CFramePosition = t1.value96.CFrame.Position
    for _, child in ipairs(t1.value1:GetChildren()) do
        if child:IsA("Model") and t1.value167(child) then
            local Frame = child:FindFirstChild("Frame")

            if not Frame then
                Frame = child:FindFirstChild("Body")

                if not Frame then
                    Frame = child:FindFirstChild("BodyDummy")

                    if not Frame then
                        Frame = child:FindFirstChild("Hull") or (child:FindFirstChild("Color") or child:FindFirstChild("Metal"))
                    end
                end
            end

            if Frame then
                local Magnitude = (Frame.Position - CFramePosition).Magnitude

                if Magnitude < n6 then
                    v696 = child
                    n6 = Magnitude
                end
            end
        end
    end

    return v696
end
function t1.value171(p218)
    local raycastParams = RaycastParams.new()

    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {
		t1.value53,
		t1.value1:FindFirstChild("Const")
	}

    local raycastResult = t1.value1:Raycast(p218, Vector3.new(0, -500, 0), raycastParams)

    if raycastResult then
        return raycastResult.Position.Y
    end

    return p218.Y - 10
end
t1.value3.Heartbeat:Connect(function()
    if not t1.value73 then
        if t1.value53 then
            t1.value169()
        end

        return
    end

    if not t1.value53 or not t1.value53.Parent then
        t1.value53 = t1.value170()

        if t1.value53 then
            t1.value168(t1.value53)
        end
    end

    if not t1.value53 or not t1.value53.Parent then
        return
    end

    t1.value168(t1.value53)

    local value50 = t1.value50

    if t1.value165(t1.value53) then
        value50 *= 3
    end

    local v705 = t1.value3.Heartbeat:Wait() or 0.016
    local vector3_5 = Vector3.new()
    local v707 = false
    local v708 = t1.value4:IsKeyDown(Enum.KeyCode.Z)
    local v709 = t1.value4:IsKeyDown(Enum.KeyCode.X)
    local n7 = 0
    local value76 = t1.value76

    if value76 then
        value76 = t1.value58 and (t1.value57 and t1.value57.Parent)
    end

    if value76 then
        if tick() - t1.value60 > 0.07 then
            local Position = t1.value53:GetPivot().Position
            local value57Position = t1.value57.Position
            local v714 = t1.value7:CreatePath({
				AgentRadius = 7,
				AgentHeight = 5,
				AgentCanJump = false,
				WaypointSpacing = 10
			})

            pcall(function()
                v714:ComputeAsync(Position, value57Position)

                local Waypoints = v714:GetWaypoints()

                t1.value59 = {}

                for _, v in ipairs(Waypoints) do
                    table.insert(t1.value59, v.Position)
                end
            end)
        end

        if #t1.value59 > 1 then
            local v715 = t1.value59[1] - t1.value53:GetPivot().Position

            if v715.Magnitude < 10 then
                table.remove(t1.value59, 1)
            else
                vector3_5 = v715.Unit
                t1.value61 = vector3_5 * value50 * 1.65
                v707 = true
            end
        elseif #t1.value59 == 1 then
            t1.value61 = (t1.value59[1] - t1.value53:GetPivot().Position).Unit * value50 * 1.45
            v707 = true
        else
            t1.value61 = (t1.value57.Position - t1.value53:GetPivot().Position).Unit * value50 * 1.25

            if (t1.value57.Position - t1.value53:GetPivot().Position).Magnitude < 22 then
                t1.value58 = false
            end
        end
    else
        local LookVector = t1.value96.CFrame.LookVector
        local RightVector = t1.value96.CFrame.RightVector
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
        local Unit3 = Vector3.new(RightVector.X, 0, RightVector.Z).Unit

        if t1.value4:IsKeyDown(Enum.KeyCode.Up) then
            vector3_5 += Unit
            v707 = true
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.Down) then
            vector3_5 -= Unit
            v707 = true
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.Left) then
            vector3_5 -= Unit3
            v707 = true
        end

        if t1.value4:IsKeyDown(Enum.KeyCode.Right) then
            v707 = true
            vector3_5 += Unit3
        end

        if vector3_5.Magnitude > 0 then
            vector3_5 = vector3_5.Unit
            v707 = true
        end
    end

    if t1.value4:IsKeyDown(Enum.KeyCode.B) then
        n7 = t1.value51
    elseif t1.value4:IsKeyDown(Enum.KeyCode.N) then
        n7 = -t1.value51
    end

    if t1.value77 then
        if v707 or t1.value76 and t1.value58 then
            t1.value61 = t1.value61:Lerp(vector3_5 * value50, 0.4)
        else
            t1.value61 = t1.value61 * (1 - t1.value56 * v705 * 2.3)

            if t1.value61.Magnitude < 1 then
                t1.value61 = Vector3.new()
            end
        end
    else
        t1.value61 = vector3_5 * value50
    end

    local v720 = t1.value61 * v705 + Vector3.new(0, n7 * v705, 0)

    if vehicleReliefEnabled and v707 or t1.value76 and t1.value58 then
        local Position = t1.value53:GetPivot().Position
        local v722 = Position + v720
        local v723 = t1.value171(v722)

        v720 = Vector3.new(v720.X, v723 + reliefHeightOffset - Position.Y, v720.Z)
    end

    local Pivot = t1.value53:GetPivot()
    local v725 = Pivot.Position + v720
    local PivotRotation = Pivot.Rotation

    if v708 then
        PivotRotation *= CFrame.Angles(0, math.rad(t1.value27 * v705), 0)
    elseif v709 then
        PivotRotation *= CFrame.Angles(0, math.rad(-t1.value27 * v705), 0)
    end

    t1.value53:PivotTo(CFrame.new(v725) * PivotRotation)
end)
t1.value14.utility.new_renderstepped(function()
    t1.value95 = t1.value95 + 1

    if t1.value95 >= 100 then
        t1.value95 = 0
        v105()
        t1.value85()
    end

    t1.value94 = t1.value94 + 1

    local MouseLocation = t1.value4:GetMouseLocation()

    if t1.value87 then
        pcall(function()
            game:GetService("Lighting").ClockTime = t1.value88
        end)
    end

    t1.value90.Position = MouseLocation
    t1.value91.Position = MouseLocation
    t1.value90.Radius = t1.value18
    t1.value91.Radius = t1.value18

    if t1.value94 >= t1.value92 and t1.value66 then
        t1.value133()
    end

    if t1.value95 >= t1.value93 then
        if t1.value62 then
            v143()
        end

        if t1.value66 then
            t1.value144()
            t1.value145()
            t1.value146()
            t1.value140()
        else

            for v730, v731 in pairs(t1.value86) do

                for _, v in pairs(v731) do
                    if v then
                        v.Visible = false
                    end
                end
            end
            for _, v in pairs(t1.value41) do
                for _, v13 in pairs(v) do
                    if v13 then
                        v13.Visible = false
                    end
                end
            end
            for v740, v741 in pairs(t1.value43) do

                for _, v in pairs(v741) do
                    if v then
                        v.Visible = false
                    end
                end
            end
            for _, v in pairs(t1.value45) do
                for _, v14 in pairs(v) do
                    if v14 then
                        v14.Visible = false
                    end
                end
            end
            for v750, v751 in pairs(t1.value138) do

                if v751 then
                    v751.Visible = false
                end
            end
            for _, v in pairs(t1.value141) do
                if v then
                    v.Visible = false
                end
            end
        end
    end

    if t1.value62 and t1.value21 then
        t1.value89.Visible = true
        t1.value89.From = MouseLocation
        t1.value89.To = t1.value21

        return
    end

    t1.value89.Visible = false
end)
t1.value14.utility.new_heartbeat(function()
    for k in pairs(t1.value39) do
        local v755 = k

        if v755 and v755.Parent then
            t1.value128(v755)
        end
    end
end)
t1.value4.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end

    if input.KeyCode == Enum.KeyCode.RightShift then
        t1.value83:Toggle()
    end

    if input.KeyCode == Enum.KeyCode.End then
        t1.value14.utility.unload()

        if t1.value108 then
            t1.value108:Disconnect()
        end

        t1.value83:Unload()
    end
end)
task.spawn(function()
    local children = t1.value1:GetChildren()

    for i = 1, #children do
        local v760 = children[i]

        if v760:IsA("Model") and v760 ~= t1.value5.Character then
            task.spawn(function()
                task.wait(0.1)

                if v760:FindFirstChild("HumanoidRootPart") then
                    t1.value130(v760)
                end
            end)
        end
    end
end)
t1.value1.ChildAdded:Connect(function(child)
    task.spawn(function()
        if child:IsA("Model") and child ~= t1.value5.Character then
            task.wait(0.1)

            if child:FindFirstChild("HumanoidRootPart") then
                t1.value130(child)
            end
        end

        if child:IsA("Model") and child.Name == "Model" then
            task.wait(0.2)

            local Body = child:FindFirstChild("Body")

            if Body then
                local BodySize = Body.Size

                if math.abs(BodySize.X - 6.8) <= 0.05 then
                    local Body2 = child:FindFirstChild("Body")

                    if Body2 and Body2:IsA("BasePart") then
                        t1.value40.Car[Body2] = true

                        return
                    end
                elseif math.abs(BodySize.X - 7.76) <= 0.05 then
                    local Body3 = child:FindFirstChild("Body")

                    if Body3 and Body3:IsA("BasePart") then
                        t1.value40.Quad[Body3] = true

                        return
                    end
                else
                    if math.abs(BodySize.X - 2.63) <= 0.05 then
                        t1.value136(child, "Box")

                        return
                    end

                    if math.abs(BodySize.X - 3.59) <= 0.05 then
                        t1.value136(child, "MiniBox")

                        return
                    end

                    if math.abs(BodySize.X - 1.96) <= 0.05 then
                        t1.value136(child, "Metal")

                        return
                    end

                    if math.abs(BodySize.X - 4.83) <= 0.05 or math.abs(BodySize.X - 4.93) <= 0.05 then
                        t1.value137(child, "Cactus")

                        return
                    end
                end
            elseif child:FindFirstChild("BodyDummy") then
                local v802 = child
                local v803 = v802:FindFirstChild("BodyDummy") or v802:FindFirstChild("Body")

                if v803 and v803:IsA("BasePart") then
                    t1.value40.Helicopter[v803] = true

                    return
                end
            elseif child:FindFirstChild("Hull") then
                local v804 = child
                local v805 = v804:FindFirstChild("Hull") or v804:FindFirstChild("Body")

                if v805 and v805:IsA("BasePart") then
                    t1.value40.Boat[v805] = true

                    return
                end
            else
                if child:FindFirstChild("Sign") then
                    t1.value136(child, "Bloxy")

                    return
                end

                if child:FindFirstChild("default") then
                    t1.value137(child, "Tree")

                    return
                end

                if child:FindFirstChild("Part") then
                    local Part = child:FindFirstChild("Part")

                    if Part and Part:IsA("BasePart") then
                        local v807 = math.round(Part.Color.R * 255)
                        local v808 = math.round(Part.Color.G * 255)
                        local v809 = math.round(Part.Color.B * 255)
                        local v810 = #child:GetChildren()

                        if v807 == 72 and (v808 == 72 and (v809 == 72 and v810 == 1)) then
                            t1.value137(child, "Stone")

                            return
                        end

                        if v807 == 248 and (v808 == 248 and (v809 == 248 and v810 == 2)) then
                            t1.value137(child, "Nitrate")

                            return
                        end

                        if v807 == 199 and (v808 == 172 and (v809 == 120 and v810 == 2)) then
                            t1.value137(child, "Iron")
                        end
                    end
                end
            end
        end
    end)
end)
t1.value1.ChildRemoved:Connect(t1.value131);
(function()
    for _, child in ipairs(t1.value1:GetChildren()) do
        if child:IsA("Model") and child.Name == "Model" then
            if child:FindFirstChild("Body") then
                local BodySize = child.Body.Size

                if math.abs(BodySize.X - 6.8) <= 0.05 then
                    local Body = child:FindFirstChild("Body")

                    if Body and Body:IsA("BasePart") then
                        t1.value40.Car[Body] = true
                    end
                elseif math.abs(BodySize.X - 7.76) <= 0.05 then
                    local Body = child:FindFirstChild("Body")

                    if Body and Body:IsA("BasePart") then
                        t1.value40.Quad[Body] = true
                    end
                elseif math.abs(BodySize.X - 2.63) <= 0.05 then
                    t1.value136(child, "Box")
                elseif math.abs(BodySize.X - 3.59) <= 0.05 then
                    t1.value136(child, "MiniBox")
                elseif math.abs(BodySize.X - 1.96) <= 0.05 then
                    t1.value136(child, "Metal")
                elseif math.abs(BodySize.X - 4.83) <= 0.05 or math.abs(BodySize.X - 4.93) <= 0.05 then
                    t1.value137(child, "Cactus")
                end
            elseif child:FindFirstChild("BodyDummy") then
                local v647 = child:FindFirstChild("BodyDummy") or child:FindFirstChild("Body")

                if v647 and v647:IsA("BasePart") then
                    t1.value40.Helicopter[v647] = true
                end
            elseif child:FindFirstChild("Hull") then
                local v648 = child:FindFirstChild("Hull") or child:FindFirstChild("Body")

                if v648 and v648:IsA("BasePart") then
                    t1.value40.Boat[v648] = true
                end
            elseif child:FindFirstChild("Sign") then
                t1.value136(child, "Bloxy")
            elseif child:FindFirstChild("default") then
                t1.value137(child, "Tree")
            elseif child:FindFirstChild("Part") then
                local Part = child:FindFirstChild("Part")

                if Part and Part:IsA("BasePart") then
                    local v650 = math.round(Part.Color.R * 255)
                    local v651 = math.round(Part.Color.G * 255)
                    local v652 = math.round(Part.Color.B * 255)
                    local v653 = #child:GetChildren()

                    if v650 == 72 and (v651 == 72 and (v652 == 72 and v653 == 1)) then
                        t1.value137(child, "Stone")
                    elseif v650 == 248 and (v651 == 248 and (v652 == 248 and v653 == 2)) then
                        t1.value137(child, "Nitrate")
                    elseif v650 == 199 and (v651 == 172 and (v652 == 120 and v653 == 2)) then
                        t1.value137(child, "Iron")
                    end
                end
            end
        end
    end
end)()
