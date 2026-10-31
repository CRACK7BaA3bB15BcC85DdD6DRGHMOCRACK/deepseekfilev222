

local type_custom = typeof
if not LPH_OBFUSCATED then
    LPH_JIT = function(...) return ...; end;
    LPH_JIT_MAX = function(...) return ...; end;
    LPH_NO_VIRTUALIZE = function(...) return ...; end;
    LPH_NO_UPVALUES = function(f) return (function(...) return f(...); end); end;
    LPH_ENCSTR = function(...) return ...; end;
    LPH_ENCNUM = function(...) return ...; end;
    LPH_ENCFUNC = function(func, key1, key2)
        if key1 ~= key2 then return print("LPH_ENCFUNC mismatch") end
        return func
    end
    LPH_CRASH = function() return print(debug.traceback()); end;
    SWG_DiscordUser = "xvi"
    SWG_DiscordID = 1337
    SWG_Private = true
    SWG_Dev = false
    SWG_Version = "developer panda"
    SWG_Title = 'xvisad.xyz'
    SWG_ShortName = 'panda'
    SWG_FullName = 'in xvi'
    SWG_FFA = false
end;

local workspace = cloneref(game:GetService("Workspace"))
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local Lighting = cloneref(game:GetService("Lighting"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local GuiInset = cloneref(game:GetService("GuiService")):GetGuiInset()
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local ObsidianRepo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library      = loadstring(game:HttpGet(ObsidianRepo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(ObsidianRepo .. "addons/ThemeManager.lua"))()
local SaveManager  = loadstring(game:HttpGet(ObsidianRepo .. "addons/SaveManager.lua"))()

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local cheat = {
    Library = Library,
    Toggles = Library.Toggles,
    Options = Library.Options,
    ThemeManager = ThemeManager,
    SaveManager = SaveManager,
    connections = {
        heartbeats = {},
        renderstepped = {}
    },
    drawings = {},
    hooks = {}
}
cheat.utility = {} do
    cheat.utility.new_heartbeat = function(func)
        local obj = {}
        cheat.connections.heartbeats[func] = func
        function obj:Disconnect()
            if func then
                cheat.connections.heartbeats[func] = nil
                func = nil
            end
        end
        return obj
    end
    cheat.utility.new_renderstepped = function(func)
        local obj = {}
        cheat.connections.renderstepped[func] = func
        function obj:Disconnect()
            if func then
                cheat.connections.renderstepped[func] = nil
                func = nil
            end
        end
        return obj
    end
    cheat.utility.new_drawing = function(drawobj, args)
        local obj = Drawing.new(drawobj)
        for i, v in pairs(args) do
            obj[i] = v
        end
        cheat.drawings[obj] = obj
        return obj
    end
    cheat.utility.new_hook = function(f, newf, usecclosure) LPH_NO_VIRTUALIZE(function()
        if usecclosure then
            local old; old = hookfunction(f, newcclosure(function(...)
                return newf(old, ...)
            end))
            cheat.hooks[f] = old
            return old
        else
            local old; old = hookfunction(f, function(...)
                return newf(old, ...)
            end)
            cheat.hooks[f] = old
            return old
        end
    end)() end
    local connection; connection = RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(delta)
        for _, func in pairs(cheat.connections.heartbeats) do
            func(delta)
        end
    end))
    local connection1; connection1 = RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(delta)
        for _, func in pairs(cheat.connections.renderstepped) do
            func(delta)
        end
    end))
    cheat.utility.unload = function()
        connection:Disconnect()
        connection1:Disconnect()
        for key, _ in pairs(cheat.connections.heartbeats) do
            cheat.connections.heartbeats[key] = nil
        end
        for key, _ in pairs(cheat.connections.renderstepped) do
            cheat.connections.heartbeats[key] = nil
        end
        for _, drawing in pairs(cheat.drawings) do
            drawing:Remove()
            cheat.drawings[_] = nil
        end
        for hooked, original in pairs(cheat.hooks) do
            if type(original) == "function" then
                hookfunction(hooked, clonefunction(original))
            else
                hookmetamethod(original["instance"], original["metamethod"], clonefunction(original["func"]))
            end
        end
    end
end

local _CFramenew = CFrame.new
local _Vector2new = Vector2.new
local _Vector3new = Vector3.new
local _IsDescendantOf = game.IsDescendantOf
local _FindFirstChild = game.FindFirstChild
local _FindFirstChildOfClass = game.FindFirstChildOfClass
local _Raycast = workspace.Raycast
local _IsKeyDown = UserInputService.IsKeyDown
local _WorldToViewportPoint = Camera.WorldToViewportPoint
local _Vector3zeromin = Vector3.zero.Min
local _Vector2zeromin = Vector2.zero.Min
local _Vector3zeromax = Vector3.zero.Max
local _Vector2zeromax = Vector2.zero.Max
local _IsA = game.IsA
local tablecreate = table.create
local mathfloor = math.floor
local mathround = math.round
local mathclamp = math.clamp
local tostring = tostring
local unpack = unpack
local getupvalues = debug.getupvalues
local getupvalue = debug.getupvalue
local setupvalue = debug.setupvalue
local getconstants = debug.getconstants
local getconstant = debug.getconstant
local setconstant = debug.setconstant
local getstack = debug.getstack
local setstack = debug.setstack
local getinfo = debug.getinfo
local rawget = rawget

local trident = {
    loaded = false,
    lastpos = nil,
    middlepart = nil,
    tcp = nil,
    original_model = nil
}
local garbage = {}
local classes = nil;
local runonactorused = false

if not (hookfunction and hookmetamethod and getgc and getupvalues and getupvalue) then return print('wtf dude...') end
LPH_JIT_MAX(function()
    for i,v in pairs(getgc(true)) do
        if type(v) == "table" then
            if type(rawget(v, "Camera")) == "table" and rawget(rawget(v, "Camera"), "type") == "Camera" then
                classes = v
            end
            if type(rawget(v, "updateCharacter")) == "function" then
                garbage.character = v
            end
            if rawget(v, "SetMaxRelativeLookExtentsY") then
                garbage.maxlooky = rawget(v, "SetMaxRelativeLookExtentsY")
            end
            if rawget(v, "GetEquippedItem") then
                garbage.equippeditem = rawget(v, "GetEquippedItem")
            end
            if rawget(v, "GetEntityFromPart") then
                garbage.entitylist = rawget(v, "GetEntityFromPart")
            end
            if rawget(v, "Recoil") and getinfo(rawget(v, "Recoil")).short_src:find("Camera") then
                garbage.recoil = rawget(v, "Recoil")
            end
        end
    end
end)()
if not (classes and garbage.character and garbage.maxlooky and garbage.equippeditem and garbage.entitylist and garbage.recoil) then
    return print("Join A server.")
end

cheat.utility.new_heartbeat(function()
    local localChar = workspace:FindFirstChild("Const")
    if localChar then
        local ignore = localChar:FindFirstChild("Ignore")
        if ignore then
            local ignoreLocal = ignore:FindFirstChild("LocalCharacter")
            if ignoreLocal then
                local top = ignoreLocal:FindFirstChild("Top")
                local middle = ignoreLocal:FindFirstChild("Middle")
                if top then top.CanCollide = false end
                if middle then middle.CanCollide = false end
            end
        end
    end
end)

repeat if not pcall(function()
    trident.middlepart = workspace.Const.Ignore.LocalCharacter.Middle
    trident.original_model = game:GetService("ReplicatedStorage").Shared.entities.Player.Model
    trident.tcp = LocalPlayer.TCP
    trident.udp = LocalPlayer.UDP
    trident.valid_types = {}
    trident.valid_types["Player"] = true
    for _, v in game:GetService("ReplicatedStorage").Shared.entities.NPC:GetChildren() do
        trident.valid_types[v.Name] = true
    end
end) then task.wait(0.5) end until trident.middlepart and trident.original_model and trident.tcp

local ui = {
    window = Library:CreateWindow({
        Title = string.format(SWG_Title, SWG_Version, SWG_FullName),
        Footer = "xvisad.xyz " .. SWG_Version,
        NotifySide = "Right",
        ShowCustomCursor = true,
        Center = true,
        AutoShow = true,
    })
}

ui.tabs = {
    combat = ui.window:AddTab('Combat', 'sword'),
    visuals = ui.window:AddTab('Visuals', 'eye'),
    misc = ui.window:AddTab('Misc', 'tool'),
    tab = ui.window:AddTab('Local', 'user'),
    config = ui.window:AddTab('Config', 'settings'),
}

ui.box = {
    silentaim_group = ui.tabs.combat:AddRightGroupbox('Silent'),
    weapon_visuals = ui.tabs.visuals:AddRightGroupbox('av'),

    left_combat  = ui.tabs.combat:AddLeftTabbox(),
    right_combat = ui.tabs.combat:AddRightTabbox(),

    esp           = ui.tabs.visuals:AddLeftTabbox(),
    visuals_right = ui.tabs.visuals:AddRightTabbox(),

    left_misc  = ui.tabs.misc:AddLeftTabbox(),
    right_misc = ui.tabs.misc:AddRightTabbox(),

    themeconfig = ui.tabs.config:AddLeftGroupbox('Theme Config'),
}

local rainbow_clock = tick()
cheat.utility.new_heartbeat(function(delta)
    rainbow_clock = tick()
end)
local function rainbow_color(offset)
    offset = offset or 0
    local hue = (rainbow_clock * 0.15 + offset) % 1
    return Color3.fromHSV(hue, 1, 1)
end
cheat.utility.rainbow_color = rainbow_color

cheat.EspLibrary = {};
LPH_NO_VIRTUALIZE(function()
    local esp_table = {}
    local workspace = cloneref(game:GetService("Workspace"))
    local plrs = cloneref(game:GetService("Players"))
    local lplr = plrs.LocalPlayer
    local guiroot = gethui and gethui() or game:GetService("CoreGui").RobloxGui
    local container = Instance.new("Folder", guiroot)
    esp_table = {
        __loaded = false,
        main_settings = {
            textSize = 15,
            textFont = Drawing.Fonts.System,
            distancelimit = false,
            maxdistance = 200,
            useteamcolor = false,
            teamcheck = false,
            sleepcheck = false,
            simplecalc = false,
            rainbow = false
        },
        main_object_settings = {
            textSize = 15,
            textFont = Drawing.Fonts.System,
            distancelimit = false,
            maxdistance = 200,
            useteamcolor = false,
            teamcheck = false,
            sleepcheck = false,
            allowed = {},
            rainbow = false
        },
        settings = {
            enemy = {
                enabled = false,
                box = false,
                box_fill = false,
                realname = false,
                dist = false,
                weapon = false,
                skeleton = false,
                box_outline = false,
                realname_outline = false,
                dist_outline = false,
                weapon_outline = false,
                box_color = { Color3.new(1, 1, 1), 1 },
                box_fill_color = { Color3.new(1, 0, 0), 0.3 },
                realname_color = { Color3.new(1, 1, 1), 1 },
                dist_color = { Color3.new(1, 1, 1), 1 },
                weapon_color = { Color3.new(1, 1, 1), 1 },
                skeleton_color = { Color3.new(1, 1, 1), 1 },
                box_outline_color = { Color3.new(), 1 },
                realname_outline_color = Color3.new(),
                dist_outline_color = Color3.new(),
                weapon_outline_color = Color3.new(),
                chams = false,
                chams_visible_only = false,
                chams_fill_color = { Color3.new(1, 1, 1), 0.5 },
                chamsoutline_color = { Color3.new(1, 1, 1), 0 }
            },
            object = {
                enabled = false,
                allenabled = false,
                realname = false,
                realname_outline = false,
                realname_color = { Color3.new(1, 1, 1), 1 },
                realname_outline_color = Color3.new(),
                chams = false,
                chams_visible_only = false,
                chams_fill_color = { Color3.new(1, 1, 1), 0.5 },
                chamsoutline_color = { Color3.new(1, 1, 1), 0 }
            }
        }
    }
    local loaded_plrs = {}
    local camera = workspace.CurrentCamera
    local VERTICES = {
        _Vector3new(-1, -1, -1), _Vector3new(-1, 1, -1),
        _Vector3new(-1, 1, 1), _Vector3new(-1, -1, 1),
        _Vector3new(1, -1, -1), _Vector3new(1, 1, -1),
        _Vector3new(1, 1, 1), _Vector3new(1, -1, 1)
    }
    local skeleton_order = {
        ["LeftFoot"] = "LeftLowerLeg", ["LeftLowerLeg"] = "LeftUpperLeg", ["LeftUpperLeg"] = "LowerTorso",
        ["RightFoot"] = "RightLowerLeg", ["RightLowerLeg"] = "RightUpperLeg", ["RightUpperLeg"] = "LowerTorso",
        ["LeftHand"] = "LeftLowerArm", ["LeftLowerArm"] = "LeftUpperArm", ["LeftUpperArm"] = "Torso",
        ["RightHand"] = "RightLowerArm", ["RightLowerArm"] = "RightUpperArm", ["RightUpperArm"] = "Torso",
        ["LowerTorso"] = "Torso", ["Torso"] = "Head"
    }
    local player_memory = {}

    local function getcurrentweapon(entity)
        local gun = "None"
        if type(entity) == "table" and type(rawget(entity, "equippedItem")) == "table" then
            return rawget(rawget(entity, "equippedItem"), "type")
        end
        return gun
    end
    local esp = {}
    esp.create_obj = function(type, args)
        local obj = Drawing.new(type)
        for i, v in args do obj[i] = v end
        return obj
    end
    local function isBodyPart(name)
        return name == "Head" or name:find("Torso") or name:find("Leg") or name:find("Arm")
    end
    local function getBoundingBox(parts)
        local min, max
        for i = 1, #parts do
            local part = parts[i]
            local cframe, size = part.CFrame, part.Size
            min = _Vector3zeromin(min or cframe.Position, (cframe - size * 0.5).Position)
            max = _Vector3zeromax(max or cframe.Position, (cframe + size * 0.5).Position)
        end
        local center = (min + max) * 0.5
        local front = _Vector3new(center.X, center.Y, max.Z)
        return _CFramenew(center, front), max - min
    end
    local function worldToScreen(world)
        local screen, inBounds = _WorldToViewportPoint(camera, world)
        return _Vector2new(screen.X, screen.Y), inBounds, screen.Z
    end
    local function calculateCorners(cframe, size)
        local corners = tablecreate(#VERTICES)
        for i = 1, #VERTICES do
            corners[i] = worldToScreen((cframe + size * 0.5 * VERTICES[i]).Position)
        end
        local min = _Vector2zeromin(camera.ViewportSize, unpack(corners))
        local max = _Vector2zeromax(Vector2.zero, unpack(corners))
        return {
            corners = corners,
            topLeft = _Vector2new(mathfloor(min.X), mathfloor(min.Y)),
            topRight = _Vector2new(mathfloor(max.X), mathfloor(min.Y)),
            bottomLeft = _Vector2new(mathfloor(min.X), mathfloor(max.Y)),
            bottomRight = _Vector2new(mathfloor(max.X), mathfloor(max.Y))
        }
    end
    local function calculateCornersSimple(head, hrp)
        local head_position = worldToScreen(head.Position - Vector3.yAxis * 0.5)
        local leg_position = worldToScreen(hrp.Position - Vector3.yAxis * 3.5)
        local headx, heady = head_position.X, head_position.Y
        local legx, legy = leg_position.X, leg_position.Y
        local height = legy - heady;
        local width = height / 3.6
        return {
            topLeft = _Vector2new(headx - width, heady),
            topRight = _Vector2new(headx - width, legy),
            bottomLeft = _Vector2new(headx + width, heady),
            bottomRight = _Vector2new(headx + width, legy)
        }
    end
    local enttiyidentification = {}
    for i, v in game:GetService("ReplicatedStorage").Shared.entities:GetChildren() do
        local model = _FindFirstChild(v, "Model")
        if model and model.PrimaryPart then
            enttiyidentification[v.Name] = {
                CollisionGroup = model.PrimaryPart.CollisionGroup,
                Material = model.PrimaryPart.Material,
                Color = model.PrimaryPart.Color
            }
        end
    end
    local function identify_model(model)
        if model.ClassName ~= "Model" then return false, false end
        if _FindFirstChildOfClass(model, "MeshPart") and _FindFirstChildOfClass(model, "MeshPart").MeshId == "rbxassetid://12939036056" then
            if #model:GetChildren() == 1 then
                return "Stone", model:GetChildren()[1]
            else
                for _, part in model:GetChildren() do
                    if part.Color == Color3.fromRGB(248, 248, 248) then
                        return "Nitrate", part
                    elseif part.Color == Color3.fromRGB(199, 172, 120) then
                        return "Iron", part
                    end
                end
            end
        end
        if not model.PrimaryPart then return end
        local primpart = model.PrimaryPart
        for name, entity in enttiyidentification do
            if entity.Color == primpart.Color and entity.Material == primpart.Material and entity.CollisionGroup == primpart.CollisionGroup then
                return name, primpart
            end
        end
        return false, false
    end

    local function create_esp(model)
        if model and _FindFirstChild(model, "Head") and _FindFirstChild(model, "LowerTorso") then
            local entity;
            repeat
                for _, ent in getupvalue(garbage.entitylist, 1) do
                    if rawget(ent, "model") == model then
                        entity = ent
                        break
                    end
                end
                if not entity then task.wait(.1) end
            until entity

            local entity_type = rawget(entity, "type")
            local entity_id = rawget(entity, "id")

            local rainbow_offset = (type(entity_id) == "number" and (entity_id * 0.137) % 1) or (tick() % 1)

            loaded_plrs[model] = {
                obj = {
                    box_fill = esp.create_obj("Square", { Filled = true, Visible = false }),
                    box_outline = esp.create_obj("Square", { Filled = false, Thickness = 3, Visible = false, ZIndex = -1}),
                    box = esp.create_obj("Square", { Filled = false, Thickness = 1, Visible = false }),
                    realname = esp.create_obj("Text", { Center = true, Visible = false }),
                    dist = esp.create_obj("Text", { Center = true, Visible = false }),
                    weapon = esp.create_obj("Text", { Center = true, Visible = false }),
                },
                esp = {
                    current_gun = "",
                    corners = nil,
                    head = nil,
                    character = nil
                },
                chams_object = Instance.new("Highlight", container),
                rainbow_offset = rainbow_offset
            }
            for required, _ in next, skeleton_order do
                loaded_plrs[model].obj["skeleton_" .. required] = esp.create_obj("Line", { Visible = false })
            end

            local character = model
            local head = _FindFirstChild(character, "Head")
            local lowertorso = _FindFirstChild(character, "LowerTorso")

            local plr = loaded_plrs[model]
            local obj = plr.obj

            local cham = plr.chams_object
            local box = obj.box
            local box_outline = obj.box_outline
            local box_fill = obj.box_fill
            local realname = obj.realname
            local dist = obj.dist
            local weapon = obj.weapon

            local main_settings = esp_table.main_settings
            local settings = esp_table.settings.enemy

            local setvis_cache = false

            function plr:forceupdate()
                cham.DepthMode = settings.chams_visible_only and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                cham.FillColor = settings.chams_fill_color[1]
                cham.FillTransparency = settings.chams_fill_color[2]
                cham.OutlineColor = settings.chamsoutline_color[1]
                cham.OutlineTransparency = settings.chamsoutline_color[2]

                box.Transparency = settings.box_color[2]
                box.Color = settings.box_color[1]
                box_outline.Transparency = settings.box_outline_color[2]
                box_outline.Color = settings.box_outline_color[1]
                box_fill.Color = settings.box_fill_color[1]
                box_fill.Transparency = settings.box_fill_color[2]

                realname.Size = main_settings.textSize
                realname.Font = main_settings.textFont
                realname.Color = settings.realname_color[1]
                realname.Outline = settings.realname_outline
                realname.OutlineColor = settings.realname_outline_color
                realname.Transparency = settings.realname_color[2]

                dist.Size = main_settings.textSize
                dist.Font = main_settings.textFont
                dist.Color = settings.dist_color[1]
                dist.Outline = settings.dist_outline
                dist.OutlineColor = settings.dist_outline_color
                dist.Transparency = settings.dist_color[2]

                weapon.Size = main_settings.textSize
                weapon.Font = main_settings.textFont
                weapon.Color = settings.weapon_color[1]
                weapon.Outline = settings.weapon_outline
                weapon.OutlineColor = settings.weapon_outline_color
                weapon.Transparency = settings.weapon_color[2]

                for required, _ in next, skeleton_order do
                    local skeletonobj = obj["skeleton_" .. required]
                    if (skeletonobj) then
                        skeletonobj.Color = settings.skeleton_color[1]
                        skeletonobj.Transparency = settings.skeleton_color[2]
                    end
                end

                if setvis_cache then
                    cham.Enabled = settings.chams
                    box.Visible = settings.box
                    box_outline.Visible = settings.box_outline
                    box_fill.Visible = settings.box_fill
                    realname.Visible = settings.realname
                    dist.Visible = settings.dist
                    weapon.Visible = settings.weapon
                    for required, _ in next, skeleton_order do
                        local skeletonobj = obj["skeleton_" .. required]
                        if (skeletonobj) then
                            skeletonobj.Visible = settings.skeleton
                        end
                    end
                end
            end

            function plr:togglevis(bool)
                if setvis_cache ~= bool then
                    setvis_cache = bool
                    if not bool then
                        for _, v in obj do v.Visible = false end
                        cham.Enabled = false
                    else
                        cham.Enabled = settings.chams
                        box.Visible = settings.box
                        box_outline.Visible = settings.box_outline
                        box_fill.Visible = settings.box_fill
                        realname.Visible = settings.realname
                        dist.Visible = settings.dist
                        weapon.Visible = settings.weapon
                        for required, _ in next, skeleton_order do
                            local skeletonobj = obj["skeleton_" .. required]
                            if (skeletonobj) then
                                skeletonobj.Visible = settings.skeleton
                            end
                        end
                    end
                end
            end

            plr.connection = cheat.utility.new_renderstepped(function(delta)
                if not (
                    settings.enabled and
                    head and
                    character and
                    (
                        main_settings.sleepcheck and
                        not rawget(entity, "sleeping") or
                        not main_settings.sleepcheck
                    )
                ) then
                    return plr:togglevis(false)
                end
                local _, onScreen = worldToScreen(head.Position)
                if not onScreen then
                    return plr:togglevis(false)
                end

                local distance = (camera.CFrame.p - head.Position).Magnitude

                local corners if main_settings.simplecalc then
                    corners = calculateCornersSimple(head, lowertorso)
                else
                    local cache = {}
                    local children = character:GetChildren()
                    for i = 1, #children do
                        local part = children[i]
                        if _IsA(part, "BasePart") and isBodyPart(part.Name) then
                            cache[#cache + 1] = part
                        end
                    end
                    corners = calculateCorners(getBoundingBox(cache))
                end

                if not corners then
                    return plr:togglevis(false)
                end

                plr:togglevis(true)
                cham.Adornee = character

                local rainbow_active = main_settings.rainbow
                local rcol = rainbow_active and cheat.utility.rainbow_color(plr.rainbow_offset) or nil

                do
                    local pos = corners.topLeft
                    local size = corners.bottomRight - corners.topLeft
                    box.Position = pos
                    box.Size = size
                    if getgenv().DrawingFix then
                        box_outline.Position = pos - _Vector2new(1, 1)
                        box_outline.Size = size + _Vector2new(2, 2)
                    else
                        box_outline.Position = pos
                        box_outline.Size = size
                    end
                    box_fill.Position = pos
                    box_fill.Size = size
                    if rainbow_active then
                        box.Color = rcol
                        box_fill.Color = rcol
                        box_outline.Color = rcol
                    end
                end

                do
                    local entity_name = rawget(entity, "Name")
                    realname.Text = player_memory[entity_id] or entity_name or entity_type
                    if entity_type == "Player" and entity_name then
                        player_memory[entity_id] = entity_name
                    end
                    realname.Position = (corners.topLeft + corners.topRight) * 0.5 -
                        Vector2.yAxis * realname.TextBounds.Y - _Vector2new(0, 2)
                    if rainbow_active then realname.Color = rcol end
                end

                do
                    local bottom = (corners.bottomLeft + corners.bottomRight) * 0.5
                    dist.Text = tostring(mathround(distance)) .. " studs"
                    dist.Position = bottom
                    weapon.Text = getcurrentweapon(entity)
                    weapon.Position = bottom + (dist.Visible and Vector2.yAxis * dist.TextBounds.Y - _Vector2new(0, 2) or Vector2.zero)
                    if rainbow_active then
                        dist.Color = rcol
                        weapon.Color = rcol
                    end
                end

                if settings.skeleton then
                    for _, part in next, character:GetChildren() do
                        local part_name = part.Name
                        local skeletonobj = obj["skeleton_" .. part_name]
                        local parent_part = skeleton_order[part_name] and _FindFirstChild(character, skeleton_order[part_name])
                        if skeletonobj and parent_part then
                            local part_position, _ = _WorldToViewportPoint(camera, part.Position)
                            local parent_part_position, _ = _WorldToViewportPoint(camera, parent_part.CFrame.p)
                            skeletonobj.From = _Vector2new(part_position.X, part_position.Y)
                            skeletonobj.To = _Vector2new(parent_part_position.X, parent_part_position.Y)
                            if rainbow_active then skeletonobj.Color = rcol end
                        end
                    end
                end

                if rainbow_active then
                    cham.FillColor = rcol
                    cham.OutlineColor = rcol
                end
            end)

            plr:forceupdate()
        else
            local espname, mainpart = identify_model(model)
            if not (espname and mainpart) then return end
            local obj_offset = (tick() * 0.137) % 1
            loaded_plrs[model] = {
                obj = {
                    name = esp.create_obj("Text", { Center = true, Visible = false, Text = espname }),
                },
                rainbow_offset = obj_offset
            }
            local plr = loaded_plrs[model]
            local obj = plr.obj
            local realname = obj.name
            local main_settings = esp_table.main_object_settings
            local settings = esp_table.settings.object
            local allowedobjs = main_settings.allowed
            local setvis_cache = false

            function plr:forceupdate()
                realname.Size = main_settings.textSize
                realname.Font = main_settings.textFont
                realname.Color = settings.realname_color[1]
                realname.Outline = settings.realname_outline
                realname.OutlineColor = settings.realname_outline_color
                realname.Transparency = settings.realname_color[2]
            end

            function plr:togglevis(bool)
                if setvis_cache ~= bool then
                    for _, v in obj do v.Visible = bool end
                    setvis_cache = bool
                end
            end

            plr.connection = cheat.utility.new_heartbeat(function(delta)
                local plr = loaded_plrs[model]
                if not (settings.enabled and mainpart and (settings.allenabled or allowedobjs[espname])) then
                    return plr:togglevis(false)
                end
                local position, onscreen = worldToScreen(mainpart.Position)
                if not onscreen then return plr:togglevis(false) end
                plr:togglevis(true)
                realname.Position = position
                if main_settings.rainbow then
                    realname.Color = cheat.utility.rainbow_color(plr.rainbow_offset)
                end
            end)

            plr:forceupdate()
        end
    end
    local function destroy_esp(model)
        local plr_object = loaded_plrs[model]
        if not plr_object then return end
        plr_object.connection:Disconnect()
        for i, v in plr_object.obj do v:Remove() end
        if plr_object.chams_object then plr_object.chams_object:Destroy() end
        loaded_plrs[model] = nil
    end

    function esp_table.load()
        for i, v in next, workspace:GetChildren() do create_esp(v) end
        esp_table.playerAdded = workspace.ChildAdded:Connect(create_esp);
        esp_table.playerRemoving = workspace.ChildRemoved:Connect(destroy_esp);
        esp_table.__loaded = true;
    end

    function esp_table.unload()
        for i, v in next, workspace:GetChildren() do destroy_esp(v) end
        esp_table.playerAdded:Disconnect();
        esp_table.playerRemoving:Disconnect();
        esp_table.__loaded = false;
    end

    function esp_table.icaca()
        for _, v in loaded_plrs do
            task.spawn(function() v:forceupdate() end)
        end
    end

    cheat.EspLibrary = esp_table
end)();

local vischeck_params = RaycastParams.new()
vischeck_params.FilterDescendantsInstances = { workspace.Const.Ignore }
vischeck_params.FilterType = Enum.RaycastFilterType.Exclude
vischeck_params.CollisionGroup = "WeaponRaycast"
vischeck_params.IgnoreWater = true

local function is_visible(position, target, target_part)
    if not (target and target_part and position) then return false end
    local castresults = _Raycast(workspace, position, target_part.CFrame.p - position, vischeck_params)
    return castresults and castresults.Instance and castresults.Instance.Parent == target
end

local function is_position_visible(pos_from, pos_to)
    if not (pos_to and pos_from) then return false end
    local castresults = _Raycast(workspace, pos_from, pos_to - pos_from, vischeck_params)
    return not castresults
end

local function get_closest_target(usefov, fov_size, aimpart, sleep, team)
    local part, entity = nil, nil
    local maximum_distance = usefov and fov_size or math.huge
    local mousepos = _Vector2new(Mouse.X, Mouse.Y)
    local valid_types = trident.valid_types
    LPH_JIT_MAX(function()
        for _, tbl in getupvalue(garbage.entitylist, 1) do
            local model = rawget(tbl, "model")
            local enttype = rawget(tbl, "type")
            local sleeping = rawget(tbl, "sleeping")
            local hitpart = model and _FindFirstChild(model, aimpart)
            if (hitpart and valid_types[enttype]) and (sleep and not sleeping or not sleep) then
                local position, onscreen = _WorldToViewportPoint(Camera, hitpart.Position)
                local distance = (_Vector2new(position.X, position.Y - GuiInset.Y) - mousepos).Magnitude
                if (usefov and onscreen or not usefov) and distance < maximum_distance then
                    part = hitpart
                    entity = tbl
                    maximum_distance = distance
                end
            end
        end
    end)()
    return part, entity
end

local modulecomm = {
    enabled = false,
    resolver = false,
    camera = false,
    silent = false,
    sleep_check = false,
    team_check = false,
    part = "Torso",
    fov = false,
    fov_show = false,
    fov_color = Color3.new(1, 1, 1),
    fov_outline = false,
    fov_outline_color = Color3.new(0, 0, 0),
    fov_size = 100,
    fov_rainbow = false,
    indicator = false,
    indicator_text = "",
    godmode = false,
    snaplines = false,
    snaplines_color = Color3.new(1, 1, 1),
    snaplines_from = "center",
    jumpshoot = false,
    noslowdown = false,
    nospread = false,
    forcehead = false,
    invis = false,
    hitboxes = false,
    multipoint = false,
    multipoint_part = "Torso",
    hitbox_size = _Vector3new(0.5, 1, 0.5),
    silentwalk = false,
    velobreak = false,
    velobreakstrenght = 6,
    infiniteregister = false,
    target = {},
    antiaim = {
        antiaim = false,
        antiaimyaw = "none",
        antiaimpitch = "none",
        spinspeed = 0.1,
        backwards = false,
        yawoffset = 0,
        yawjittersize = 0,
        pitchjittersize = 0,
        pitchcustom = 0,
        yawrandomspeed = 1,
        pitchrandomspeed = 1,
        car = false,
        cartripmode = "side",
        caryaw = "none",
        carspinspeed = 0.1,
        cartriprandomspeed = 1,
        caryawrandomspeed = 1,
    },
}

cheat.utility.get_multipoint = LPH_JIT_MAX(function(model, aimpart)
    if not model then return nil end
    local part = _FindFirstChild(model, aimpart or "Head") or _FindFirstChild(model, "Head")
    if not (part and part:IsA("BasePart")) then return nil end
    local hs = modulecomm and modulecomm.hitbox_size
    local sx, sy, sz = part.Size.X, part.Size.Y, part.Size.Z
    if hs and type(hs.X) == "number" and hs.X > 0 and hs.X <= 1000
       and type(hs.Y) == "number" and hs.Y > 0 and hs.Y <= 1000 then
        sy = hs.Y
        sz = type(hs.Z) == "number" and hs.Z > 0 and hs.Z <= 1000 and hs.Z or hs.X
        sx = hs.X
    end
    local hx, hy, hz = sx * 0.5, sy * 0.5, sz * 0.5
    local rot = part.CFrame - part.CFrame.Position
    local camPos = Camera.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local filt = { model }
    local char = LocalPlayer.Character
    if char then filt[#filt + 1] = char end
    local ignore = workspace:FindFirstChild("Const") and workspace.Const:FindFirstChild("Ignore")
    if ignore then filt[#filt + 1] = ignore end
    params.FilterDescendantsInstances = filt
    local function isVis(p)
        local dir = p - camPos
        if dir.Magnitude < 1 then return true end
        local r = _Raycast(workspace, camPos, dir, params)
        return (not r) or (r.Instance and _IsDescendantOf(r.Instance, model))
    end
    local center = part.Position
    if isVis(center) then return center end
    local points = {
        _Vector3new( hx,  hy,  hz), _Vector3new(-hx,  hy,  hz),
        _Vector3new( hx,  hy, -hz), _Vector3new(-hx,  hy, -hz),
        _Vector3new(  0,  hy,  hz), _Vector3new( hx,  hy,   0),
        _Vector3new(-hx,  hy,   0), _Vector3new(  0,  hy, -hz),
        _Vector3new( hx,   0,  hz), _Vector3new(-hx,   0,  hz),
        _Vector3new( hx,   0, -hz), _Vector3new(-hx,   0, -hz),
        _Vector3new(  0,   0,  hz), _Vector3new(  0,   0, -hz),
        _Vector3new( hx,   0,   0), _Vector3new(-hx,   0,   0),
        _Vector3new( hx, -hy,  hz), _Vector3new(-hx, -hy,  hz),
        _Vector3new( hx, -hy, -hz), _Vector3new(-hx, -hy, -hz),
    }
    local best, bestd = nil, math.huge
    for i = 1, #points do
        local p = center + (rot * points[i])
        if isVis(p) then
            local d = (p - center).Magnitude
            if d < bestd then bestd = d; best = p end
        end
    end
    return best
end)

do
    cheat.utility.new_renderstepped(LPH_JIT_MAX(function()
        if modulecomm.noslowdown then
            rawset(garbage.character, "sprintBlocked", false)
        end
    end))
end

do
    local function findIsGrounded()
        for _, obj in ipairs(getgc(true)) do
            if type(obj) == "table" then
                local hasIsGrounded = false
                for k, v in pairs(obj) do
                    if k == "IsGrounded" and type(v) == "function" then
                        hasIsGrounded = true
                        break
                    end
                end
                if hasIsGrounded then return obj end
            end
        end
        return nil
    end
    local characterTable = findIsGrounded()
    if characterTable then
        local originalIsGrounded = characterTable.IsGrounded
        characterTable.IsGrounded = function(...)
            if modulecomm and modulecomm.jumpshoot then
                return true
            end
            return originalIsGrounded(...)
        end
    end

    local entlist = getupvalue(garbage.entitylist, 1)
    RunService:BindToRenderStep(tostring(math.random()), 0, LPH_NO_VIRTUALIZE(function()
        if modulecomm.resolver then
            for id, entity in entlist do
                if rawget(entity, "startAngleY") and rawget(entity, "startAngleX") then
                    rawset(entity, "startAngleY", 0)
                    rawset(entity, "goalAngleY", 0)
                    rawset(entity, "startAngleX", 0)
                    rawset(entity, "goalAngleX", 0)
                    rawset(entity, "rot", Vector3.zero)
                end
            end
        end

        local equippeditem = getupvalue(garbage.equippeditem, 1)
        trident.guninfo = classes and equippeditem and rawget(classes, rawget(equippeditem, "type"))

        if modulecomm.enabled and modulecomm.camera and modulecomm.target[1] and modulecomm.target[2]
           and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local target_part = modulecomm.target[1]
            local target_entity = modulecomm.target[2]
            local guninfo = trident.guninfo
            local proj_speed = guninfo and rawget(guninfo, "ProjectileSpeed")
            local proj_drop = guninfo and rawget(guninfo, "ProjectileDrop") or 0
            local campos = Camera.CFrame.p

            local aimPos = target_part.CFrame.p
            if modulecomm.multipoint then
                local mp_model = target_entity and rawget(target_entity, "model") or target_part.Parent
                aimPos = cheat.utility.get_multipoint(mp_model, modulecomm.multipoint_part) or aimPos
            end
            if guninfo and proj_speed and proj_drop then
                local goalpos, startpos = rawget(target_entity, "goalPosition"), rawget(target_entity, "startPosition")
                local velocity = (goalpos and startpos and (goalpos - startpos) or Vector3.zero) / 0.15 * _Vector3new(1, 0, 1)
                local distance = (campos - target_part.CFrame.p).Magnitude
                local time_to_hit = distance / proj_speed
                local predicted = target_part.CFrame.p + (velocity * time_to_hit)
                local delta = (predicted - target_part.CFrame.p).Magnitude
                time_to_hit = time_to_hit + (delta / proj_speed)
                aimPos = predicted + Vector3.yAxis * (proj_drop ^ (time_to_hit * proj_drop) - 1)
            end

            local pitch, yaw = CFrame.lookAt(campos, aimPos):ToOrientation()
            setupvalue(garbage.recoil, 13, _Vector3new(pitch, yaw, 0))
        end
    end))
end

do
    local validcharacters = {}
    local hbc, original_size = nil, trident.original_model.Torso.Size
    local hbsize = _Vector3new(0.5, 1, 0.5)
    local hitboxheadsizex, hitboxheadsizey, hitboxheadtransparency, cancollide = 10, 10, 0.5, false

    local function addtovc(obj)
        if not obj then return end
        if not obj:FindFirstChild("Head") and not obj:FindFirstChild("LowerTorso") then return end
        validcharacters[obj] = obj
    end
    local function removefromvc(obj)
        if not validcharacters[obj] then return end
        validcharacters[obj] = nil
    end
    for i, v in next, workspace:GetChildren() do addtovc(v) end
    workspace.ChildAdded:Connect(addtovc);
    workspace.ChildRemoved:Connect(removefromvc);

    local hbb = ui.box.left_combat:AddTab("Hitbox")
    hbb:AddToggle('hitbox_enabled', {
        Text = 'hitbox', Default = false,
        Callback = function(value)
            modulecomm.hitboxes = value
            if hbc then hbc:Disconnect() end
            if value then
                modulecomm.hitbox_size = hbsize
                hbc = cheat.utility.new_heartbeat(function()
                    local trans = hitboxheadtransparency
                    for _, model in pairs(validcharacters) do
                        local primpart = model and _FindFirstChild(model, 'Torso')
                        local sleeping = false
                        for _, entity in pairs(getupvalue(garbage.entitylist, 1)) do
                            if rawget(entity, "model") == model and rawget(entity, "sleeping") then
                                sleeping = true
                                break
                            end
                        end
                        if primpart and not sleeping then
                            primpart.Size = hbsize
                            primpart.Transparency = trans
                            primpart.CanCollide = cancollide
                        end
                    end
                    modulecomm.hitbox_size = hbsize
                end)
            else
                if hbc then hbc:Disconnect() end
                for _, model in pairs(validcharacters) do
                    local primpart = model and _FindFirstChild(model, 'Torso')
                    if primpart then
                        primpart.Size = original_size
                        primpart.Transparency = 0
                        primpart.CanCollide = true
                    end
                end
            end
        end
    })
    hbb:AddToggle('hitbox_cancollide', {
        Text = 'can collide', Default = false,
        Callback = function(v) cancollide = v end
    })
    hbb:AddSlider('hitbox_head_transparency', {
        Text = 'transparency', Default = 0.5, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) hitboxheadtransparency = State end)
    hbb:AddSlider('hitbox_head_size_x', {
        Text = 'size x', Default = 10, Min = 1, Max = 1000, Rounding = 1, Compact = false
    }):OnChanged(function(State)
        hitboxheadsizex = State
        hbsize = _Vector3new(hitboxheadsizex, hitboxheadsizey, hitboxheadsizex)
        modulecomm.hitbox_size = hbsize
    end)
    hbb:AddSlider('hitbox_head_size_y', {
        Text = 'size y', Default = 10, Min = 1, Max = 25, Rounding = 1, Compact = false
    }):OnChanged(function(State)
        hitboxheadsizey = State
        hbsize = _Vector3new(hitboxheadsizex, hitboxheadsizey, hitboxheadsizex)
        modulecomm.hitbox_size = hbsize
    end)
end

do
    local WeaponCooldown = {}
    local originalValues = {}
    local weaponTypes = {
        "UZI", "USP9", "PumpShotgun", "PipeSMG", "PipePistol", "LeverActionRifle",
        "GaussRifle", "M4A1", "SCAR", "SVD", "AR15", "C9", "Magnum"
    }
    local function initDefaults()
        for _, typeName in ipairs(weaponTypes) do
            for _, v in getgc(true) do
                if typeof(v) == "table" and rawget(v, "AttackCooldown") and tostring(rawget(v, "type")) == typeName then
                    originalValues[typeName] = v.AttackCooldown
                    break
                end
            end
        end
    end
    local function applyToType(typeName, value)
        for _, v in getgc(true) do
            if typeof(v) == "table" and rawget(v, "AttackCooldown") and tostring(rawget(v, "type")) == typeName then
                v.AttackCooldown = (value / 100) * 10
            end
        end
    end
    local function restoreType(typeName)
        for _, v in getgc(true) do
            if typeof(v) == "table" and rawget(v, "AttackCooldown") and tostring(rawget(v, "type")) == typeName then
                if originalValues[typeName] then v.AttackCooldown = originalValues[typeName] end
            end
        end
    end
    for _, weapon in ipairs(weaponTypes) do
        WeaponCooldown["Apply_" .. weapon] = function(value) applyToType(weapon, value) end
        WeaponCooldown["Restore_" .. weapon] = function() restoreType(weapon) end
    end
    local mvb = ui.box.left_combat:AddTab("Rapid fire")
    for _, weapon in ipairs(weaponTypes) do
        mvb:AddSlider("cooldown_" .. weapon, {
            Text = weapon .. " Cooldown",
            Default = 1, Min = 0, Max = 10, Rounding = 1, Compact = false,
            Callback = function(val) WeaponCooldown["Apply_" .. weapon](val) end
        })
    end
    initDefaults()
end

do
    local aabox = ui.box.right_combat:AddTab('antiaim')
    local aaset = modulecomm.antiaim
    aabox:AddToggle('antiaim_enabled', {
        Text = 'antiaim', Default = false,
        Callback = function(first) aaset.antiaim = first end
    }):AddKeyPicker('antiaimbind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'antiaim', NoUI = false})

    aabox:AddDropdown('antiaim_yaw', {
        Values = {"none", "spin", "static", "jitter", "invisible", "invisible2", "random", "custom"},
        Default = 1, Multi = false, Text = 'yaw modifier',
        Callback = function(Value) aaset.antiaimyaw = Value end
    })
    aabox:AddDropdown('antiaim_pitch', {
        Values = {"none", "down", "up", "jitter", "random", "custom"},
        Default = 1, Multi = false, Text = 'pitch modifier',
        Callback = function(Value) aaset.antiaimpitch = Value end
    })
    aabox:AddSlider('antiaim_spinspeed', {
        Text = 'spin speed (rpm)', Default = 60, Min = 60, Max = 360, Rounding = 0, Compact = true,
        Callback = function(State) aaset.spinspeed = State end
    })
    aabox:AddSlider('antiaim_jittersize', {
        Text = 'yaw jitter (d)', Default = 45, Min = 0, Max = 180, Rounding = 0, Compact = true,
        Callback = function(State) aaset.yawjittersize = State end
    })
    aabox:AddToggle('antiaim_backwards', {
        Text = 'backwards', Default = false,
        Callback = function(Value) aaset.backwards = Value end
    })
    aabox:AddSlider('antiaim_yawoffset', {
        Text = 'yaw offset', Default = 0, Min = -90, Max = 90, Rounding = 0, Compact = true,
        Callback = function(State) aaset.yawoffset = State end
    })
    aabox:AddSlider('antiaim_customyaw', {
        Text = 'custom yaw', Default = 0, Min = -360, Max = 360, Rounding = 0, Compact = true,
        Callback = function(State) aaset.customyaw = State end
    })
    aabox:AddSlider('antiaim_pitchjittersize', {
        Text = 'pitch jitter', Default = 90, Min = 0, Max = 90, Rounding = 0, Compact = true,
        Callback = function(State) aaset.pitchjittersize = State end
    })
    aabox:AddSlider('antiaim_custompitch', {
        Text = 'pitch custom', Default = 0, Min = -90, Max = 90, Rounding = 0, Compact = true,
        Callback = function(State) aaset.pitchcustom = State end
    })
    aabox:AddSlider('antiaim_yaw_random_speed', {
        Text = 'yaw random speed', Default = 1, Min = 0.1, Max = 50, Rounding = 1, Compact = true,
        Callback = function(State) aaset.yawrandomspeed = State end
    })
    aabox:AddSlider('antiaim_pitch_random_speed', {
        Text = 'pitch random speed', Default = 1, Min = 0.1, Max = 50, Rounding = 1, Compact = true,
        Callback = function(State) aaset.pitchrandomspeed = State end
    })
end

do
    local gunmodbox = ui.box.right_combat:AddTab('gun mods')

    gunmodbox:AddToggle('gunmods_norecoil', {
        Text = 'no recoil', Default = false,
        Callback = function(state)
            for _, v in ipairs(getgc(true)) do
                if typeof(v) == 'table' then
                    if rawget(v, 'recoilOffset') then
                        v.recoilOffset = CFrame.new()
                        v.recoilLerpSpeed = 0
                        v.recoilReturnSpeed = 0
                    end
                    if rawget(v, 'AimRecoil') then for k in pairs(v.AimRecoil) do v.AimRecoil[k] = 0 end end
                    if rawget(v, 'HipRecoil') then for k in pairs(v.HipRecoil) do v.HipRecoil[k] = 0 end end
                    if rawget(v, 'RecoilData') then for k in pairs(v.RecoilData) do v.RecoilData[k] = 0 end end
                end
            end
        end
    })
    gunmodbox:AddToggle('gunmods_jumpshoot', {
        Text = 'jump shoot', Default = false,
        Tooltip = 'Allows shooting while jumping',
        Callback = function(first) modulecomm.jumpshoot = first end
    })

    local originalAutoShootValues = {}
    gunmodbox:AddToggle('gunmods_autoshoot', {
        Text = 'auto shoot', Default = false,
        Tooltip = 'Enables auto shoot',
        Callback = function(first)
            for i, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Damage") then
                    local fireActionKey = nil
                    for key, value in pairs(v) do
                        if string.find(string.lower(tostring(key)), "fire") and
                           (string.find(string.lower(tostring(key)), "action") or
                            string.find(string.lower(tostring(key)), "mode")) then
                            fireActionKey = key
                        end
                    end
                    if fireActionKey then
                        if first then
                            if not originalAutoShootValues[v] then originalAutoShootValues[v] = {} end
                            if originalAutoShootValues[v][fireActionKey] == nil then
                                originalAutoShootValues[v][fireActionKey] = rawget(v, fireActionKey)
                            end
                            rawset(v, fireActionKey, "auto")
                        else
                            if originalAutoShootValues[v] and originalAutoShootValues[v][fireActionKey] ~= nil then
                                rawset(v, fireActionKey, originalAutoShootValues[v][fireActionKey])
                                originalAutoShootValues[v][fireActionKey] = nil
                            end
                        end
                    end
                end
            end
        end
    })

    local originalSpreadValues = {}
    gunmodbox:AddToggle('gunmods_nospread', {
        Text = 'no spread', Default = false,
        Tooltip = 'Removes spread',
        Callback = function(first)
            for i, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "Damage") then
                    local accuracyKey = nil
                    for key, value in pairs(v) do
                        if string.find(string.lower(tostring(key)), "accuracy") then
                            accuracyKey = key
                        end
                    end
                    if accuracyKey then
                        if first then
                            if not originalSpreadValues[v] then originalSpreadValues[v] = {} end
                            if originalSpreadValues[v][accuracyKey] == nil then
                                originalSpreadValues[v][accuracyKey] = rawget(v, accuracyKey)
                            end
                            rawset(v, accuracyKey, math.huge)
                        else
                            if originalSpreadValues[v] and originalSpreadValues[v][accuracyKey] ~= nil then
                                rawset(v, accuracyKey, originalSpreadValues[v][accuracyKey])
                                originalSpreadValues[v][accuracyKey] = nil
                            end
                        end
                    end
                end
            end
        end
    })

    gunmodbox:AddToggle('gunmods_noslowdown', {
        Text = 'no slowdown', Default = false,
        Tooltip = 'Removes movement slowdown while shooting or aiming',
        Callback = function(first) modulecomm.noslowdown = first end
    })
    gunmodbox:AddToggle('gunmods_forcehead', {
        Text = 'force head', Default = false,
        Callback = function(first) modulecomm.forcehead = first end
    })
end

do
    local Classes = nil
    local Init_Attempt = 0
    local Init_Max_Attempts = 100

    repeat
        local success, result = pcall(function()
            return getrenv()._G.classes
        end)
        if success and result then Classes = result end
        task.wait(0.25)
        Init_Attempt = Init_Attempt + 1
    until Classes or (Init_Attempt >= Init_Max_Attempts)

    if not Classes then
        warn("SilentAim: classes not found in _G.classes")
    end

    local CameraClient = Classes and Classes.Camera or nil
    local FPSClient    = Classes and Classes.FPS or nil
    local EntityMap    = Classes and Classes.Player and Classes.Player.EntityMap or nil

    local VALID_GUNS = {
        "AR15", "C9", "Crossbow", "Bow", "EnergyRifle", "GaussRifle",
        "HMAR", "KABAR", "LeverActionRifle", "M4A1", "Magnum", "PipePistol",
        "PipeSMG", "PumpShotgun", "SCAR", "SVD", "USP9", "UZI", "Blunderbuss"
    }

    local SilentAim = {
        Settings = {
            enabled       = false,
            prediction    = false,
            fovEnabled    = false,
            fovFill       = false,
            fovFillTransparency = 0.3,
            fovSize       = 150,
            fovColor      = Color3.fromRGB(255, 255, 255),
            fovRainbow    = false,
            showSnapLine  = false,
            snapLineColor = Color3.fromRGB(255, 255, 255),
            snapLineThickness = 1.5,
            showVisibleText = false,
            visibleColor    = Color3.fromRGB(0, 255, 0),
            notVisibleColor = Color3.fromRGB(255, 0, 0),
            sleeperCheck  = false,
            aiCheck       = false,
            teamCheck     = false,
        },
    }

    local FOV_Circle = Drawing.new("Circle")
    FOV_Circle.Thickness = 1.5
    FOV_Circle.NumSides = 100
    FOV_Circle.Filled = false
    FOV_Circle.Transparency = 1
    FOV_Circle.Visible = false
    FOV_Circle.ZIndex = 999

    local FOV_Fill = Drawing.new("Circle")
    FOV_Fill.Thickness = 0
    FOV_Fill.NumSides = 100
    FOV_Fill.Filled = true
    FOV_Fill.Transparency = 0.7
    FOV_Fill.Visible = false
    FOV_Fill.ZIndex = 998

    local SnapLine = Drawing.new("Line")
    SnapLine.Thickness = 1.5
    SnapLine.Transparency = 0.5
    SnapLine.Visible = false
    SnapLine.ZIndex = 1000
    SnapLine.Color = Color3.fromRGB(255, 255, 255)

    local VisibleText = Drawing.new("Text")
    VisibleText.Center = false
    VisibleText.Outline = true
    VisibleText.OutlineColor = Color3.new(0, 0, 0)
    VisibleText.Size = 13
    VisibleText.Font = Drawing.Fonts.Monospace
    VisibleText.Visible = false
    VisibleText.ZIndex = 1001
    VisibleText.Color = Color3.fromRGB(0, 255, 0)

    local function updateFovPos()
        local s = Camera.ViewportSize
        local center = Vector2.new(s.X / 2, s.Y / 2)
        FOV_Circle.Position = center
        FOV_Fill.Position = center
    end
    updateFovPos()
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateFovPos)

    local function CalculateBallistics(targetPos, targetVel, camPos, projSpeed, projDrop)
        targetPos = targetPos or camPos
        targetVel = targetVel or Vector3.zero
        local distance = (targetPos - camPos).Magnitude
        local timeToTarget = distance / projSpeed
        local adjustedHorizontal = Vector3.new(targetVel.X, 0, targetVel.Z) * 7
        local adjustedVertical   = Vector3.new(0, targetVel.Y, 0) * 2
        local predictedWorldPos = targetPos + ((adjustedHorizontal + adjustedVertical) * timeToTarget)
        local verticalDrop = -projDrop ^ (timeToTarget * projDrop) + 1
        local finalAimPosition = predictedWorldPos - Vector3.new(0, verticalDrop, 0)
        return finalAimPosition, timeToTarget
    end

    local sa_sleep_cache = setmetatable({}, {__mode = "k"})
    local function sa_is_sleeper(model)
        if not model then return false end
        local cached = sa_sleep_cache[model]
        if cached and tick() - cached.t < 1 then return cached.v end
        local lt = _FindFirstChild(model, "LowerTorso")
        local result = false
        if lt then
            local rr = _FindFirstChild(lt, "RootRig")
            if rr then
                local ok, angle = pcall(function() return rr.CurrentAngle end)
                result = ok and type(angle) == "number" and angle ~= 0 or false
            end
        end
        sa_sleep_cache[model] = { v = result, t = tick() }
        return result
    end
    local function sa_is_team(model)
        if not model then return false end
        local h = _FindFirstChild(model, "Head")
        if h then
            local d = _FindFirstChild(h, "Dot")
            if d and d.Enabled then return true end
        end
        return false
    end
    local function sa_is_ai(model)
        local t = _FindFirstChild(model, "Torso") or _FindFirstChild(model, "HumanoidRootPart")
        return t and t.CollisionGroup == "NPC" or false
    end

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true

    local function IsTargetVisible(model)
        if not model then return false end
        local head = _FindFirstChild(model, "Head")
        if not head then return false end
        local filter = { model }
        if LocalPlayer.Character then table.insert(filter, LocalPlayer.Character) end
        raycastParams.FilterDescendantsInstances = filter
        local origin = Camera.CFrame.Position
        local direction = (head.Position - origin)
        local result = workspace:Raycast(origin, direction, raycastParams)
        if not result then return true end
        if result.Instance and result.Instance:IsDescendantOf(model) then return true end
        return false
    end

    local function GetOptimalTarget()
        if not EntityMap then return nil, nil end
        local bestTarget, bestVelocity, minMagnitude = nil, nil, SilentAim.Settings.fovSize
        local viewportCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

        for entityIndex, entityData in next, EntityMap do
            local model = entityData.model
            if model and _FindFirstChild(model, "HumanoidRootPart") then
                local skip = false
                if SilentAim.Settings.sleeperCheck and sa_is_sleeper(model) then skip = true end
                if SilentAim.Settings.aiCheck and sa_is_ai(model) then skip = true end
                if SilentAim.Settings.teamCheck and sa_is_team(model) then skip = true end
                if not skip then
                    local head = _FindFirstChild(model, "Head")
                    if head then
                        local screenPosition, isOnScreen = Camera:WorldToViewportPoint(head.Position)
                        if isOnScreen then
                            local mouseDistance = (Vector2.new(screenPosition.X, screenPosition.Y) - viewportCenter).Magnitude
                            if mouseDistance < minMagnitude then
                                minMagnitude = mouseDistance
                                bestTarget = model
                                bestVelocity = entityData.velocityVector or Vector3.zero
                            end
                        end
                    end
                end
            end
        end
        return bestTarget, bestVelocity
    end

    if CameraClient then
        local oldCFrameHook = CameraClient.GetCFrame
        CameraClient.GetCFrame = function(...)
            if SilentAim.Settings.enabled then
                local ok, result = pcall(function()
                    local aimTarget, targetVel = GetOptimalTarget()
                    local currentItem = FPSClient and FPSClient.GetEquippedItem and FPSClient.GetEquippedItem() or nil
                    if aimTarget and currentItem and table.find(VALID_GUNS, currentItem.type) then
                        local ballisticData = Classes[currentItem.type]
                        if ballisticData then
                            local saAimPos = aimTarget.Head.Position
                            if modulecomm.multipoint then
                                saAimPos = cheat.utility.get_multipoint(aimTarget, modulecomm.multipoint_part) or saAimPos
                            end
                            local finalAimPos, _ = CalculateBallistics(
                                saAimPos,
                                targetVel,
                                Camera.CFrame.Position,
                                ballisticData.ProjectileSpeed,
                                ballisticData.ProjectileDrop
                            )
                            return CFrame.new(Camera.CFrame.Position, finalAimPos)
                        end
                    end
                    return nil
                end)
                if ok and result then return result end
            end
            return oldCFrameHook(...)
        end
    end

    cheat.utility.new_renderstepped(function()
        if not SilentAim.Settings.enabled then
            FOV_Circle.Visible = false
            FOV_Fill.Visible = false
            SnapLine.Visible = false
            VisibleText.Visible = false
            return
        end

        local fov_color = SilentAim.Settings.fovRainbow
            and cheat.utility.rainbow_color(0)
            or SilentAim.Settings.fovColor

        FOV_Circle.Visible = SilentAim.Settings.fovEnabled
        FOV_Fill.Visible = SilentAim.Settings.fovEnabled and SilentAim.Settings.fovFill
        FOV_Circle.Radius = SilentAim.Settings.fovSize
        FOV_Fill.Radius = SilentAim.Settings.fovSize
        FOV_Circle.Color = fov_color
        FOV_Fill.Color = fov_color
        FOV_Fill.Transparency = 1 - SilentAim.Settings.fovFillTransparency

        local center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        FOV_Circle.Position = center
        FOV_Fill.Position = center

        if SilentAim.Settings.showSnapLine or SilentAim.Settings.showVisibleText then
            local aimTarget = GetOptimalTarget()
            if aimTarget then
                local head = _FindFirstChild(aimTarget, "Head")
                if head then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                    if onScreen then
                        local pos = Vector2.new(screenPos.X, screenPos.Y)

                        if SilentAim.Settings.showSnapLine then
                            SnapLine.From = center
                            SnapLine.To = pos
                            SnapLine.Color = SilentAim.Settings.snapLineColor
                            SnapLine.Thickness = SilentAim.Settings.snapLineThickness
                            SnapLine.Visible = true
                        else
                            SnapLine.Visible = false
                        end

                        if SilentAim.Settings.showVisibleText then
                            local visible = IsTargetVisible(aimTarget)
                            VisibleText.Text = visible and "visible" or "not visible"
                            VisibleText.Color = visible and SilentAim.Settings.visibleColor or SilentAim.Settings.notVisibleColor
                            VisibleText.Position = Vector2.new(pos.X + 10, pos.Y - 20)
                            VisibleText.Visible = true
                        else
                            VisibleText.Visible = false
                        end
                    else
                        SnapLine.Visible = false
                        VisibleText.Visible = false
                    end
                else
                    SnapLine.Visible = false
                    VisibleText.Visible = false
                end
            else
                SnapLine.Visible = false
                VisibleText.Visible = false
            end
        else
            SnapLine.Visible = false
            VisibleText.Visible = false
        end
    end)

    local sa_box = ui.box.silentaim_group

    sa_box:AddToggle("sa_Enable", {
        Text = "Enable Silent Aim", Default = false,
        Callback = function(v) SilentAim.Settings.enabled = v end
    })
    sa_box:AddToggle("sa_Prediction", {
        Text = "Enable Prediction", Default = false,
        Callback = function(v) SilentAim.Settings.prediction = v end
    })
    sa_box:AddToggle("sa_SleeperCheck", {
        Text = "Sleeper Check", Default = false,
        Callback = function(v) SilentAim.Settings.sleeperCheck = v end
    })
    sa_box:AddToggle("sa_AICheck", {
        Text = "AI Check", Default = false,
        Callback = function(v) SilentAim.Settings.aiCheck = v end
    })
    sa_box:AddToggle("sa_TeamCheck", {
        Text = "Team Check", Default = false,
        Callback = function(v) SilentAim.Settings.teamCheck = v end
    })

    sa_box:AddToggle("sa_Multipoint", {
        Text = "Multipoint", Default = false,
        Tooltip = "Aims at visible surface points, scales to hitbox size",
        Callback = function(v) modulecomm.multipoint = v end
    })
    sa_box:AddDropdown("sa_MultipointPart", {
        Text = "Multipoint Part",
        Values = {"Head", "Torso"}, Default = 2, Multi = false,
        Tooltip = "Which part the multipoint box is built on",
        Callback = function(v) modulecomm.multipoint_part = v end
    })

    sa_box:AddToggle("sa_ShowSnapLine", {
        Text = "Show Snap Line", Default = false,
        Callback = function(v) SilentAim.Settings.showSnapLine = v end
    }):AddColorPicker("sa_SnapLineColor", {
        Title = "SnapLine Color",
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(v) SilentAim.Settings.snapLineColor = v end
    })
    sa_box:AddSlider("sa_SnapLineThickness", {
        Text = "SnapLine Thickness",
        Default = 1.5, Min = 0.5, Max = 5, Rounding = 1, Compact = true,
        Callback = function(v) SilentAim.Settings.snapLineThickness = v end
    })

    sa_box:AddToggle("sa_ShowVisibleText", {
        Text = "Show Visible Text", Default = false,
        Callback = function(v) SilentAim.Settings.showVisibleText = v end
    }):AddColorPicker("sa_VisibleColor", {
        Title = "Visible Color",
        Default = Color3.fromRGB(0, 255, 0),
        Callback = function(v) SilentAim.Settings.visibleColor = v end
    }):AddColorPicker("sa_NotVisibleColor", {
        Title = "Not Visible Color",
        Default = Color3.fromRGB(255, 0, 0),
        Callback = function(v) SilentAim.Settings.notVisibleColor = v end
    })

    local fovToggle = sa_box:AddToggle("sa_FovEnable", {
        Text = "Show FOV Circle", Default = false,
        Callback = function(v)
            SilentAim.Settings.fovEnabled = v
            FOV_Circle.Visible = v and SilentAim.Settings.enabled
            FOV_Fill.Visible = v and SilentAim.Settings.fovFill and SilentAim.Settings.enabled
        end
    })
    fovToggle:AddColorPicker("sa_FovColor", {
        Title = "FOV Color",
        Default = Color3.fromRGB(255, 255, 255),
        Callback = function(v) SilentAim.Settings.fovColor = v end
    })


    sa_box:AddToggle("sa_FovFill", {
        Text = "FOV Fill", Default = false,
        Callback = function(v)
            SilentAim.Settings.fovFill = v
            FOV_Fill.Visible = v and SilentAim.Settings.fovEnabled and SilentAim.Settings.enabled
        end
    })
    sa_box:AddSlider("sa_FovFillTransparency", {
        Text = "Fill Transparency",
        Default = 0.3, Min = 0, Max = 1, Rounding = 2, Suffix = "%",
        Callback = function(v)
            SilentAim.Settings.fovFillTransparency = v
            FOV_Fill.Transparency = 1 - v
        end
    })
    sa_box:AddSlider("sa_FovSize", {
        Text = "FOV Size",
        Default = 150, Min = 50, Max = 500, Rounding = 0, Suffix = "px",
        Callback = function(v)
            SilentAim.Settings.fovSize = v
            FOV_Circle.Radius = v
            FOV_Fill.Radius = v
        end
    })
end

do
    local mvb = ui.box.left_misc:AddTab('speedhack')
    local bhop_enabled, bhop_silent, speed = false, false, 55
    local downcliff_mode = false
    local downcliff_speed, downcliff_accel, downcliff_fall, downcliff_up = 150, 50, 50, 50
    local jetpackabuse, abuseupspeed, abusedownspeed = false, 55, 0
    local forcesprint = false
    local tp_up_studs = 6

    mvb:AddToggle('speedhack_forcesprint', {
        Text = 'forcesprint', Default = false,
        Callback = function(first) forcesprint = first end
    })
    if SWG_Private then
        local jpToggle = mvb:AddToggle('jetpackabuse', {
            Text = 'jetpack abuse', Default = false,
            Callback = function(first) jetpackabuse = first end
        })
        jpToggle:AddKeyPicker('jetpackabuse_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'jetpack abuse', NoUI = false})
        mvb:AddSlider('jetpackabuse_upspeed', {
            Text = 'up speed', Default = 55, Min = 10, Max = 500, Rounding = 0, Suffix = "sps", Compact = false
        }):OnChanged(function(State) abuseupspeed = State end)
        mvb:AddSlider('jetpackabuse_downspeed', {
            Text = 'down speed', Default = 55, Min = 10, Max = 500, Rounding = 0, Suffix = "sps", Compact = false
        }):OnChanged(function(State) abusedownspeed = State end)
        mvb:AddLabel("hold space to go up")
        mvb:AddLabel("hold shift to go down")
    else
        mvb:AddLabel("jetpack abuse: private only")
    end
    mvb:AddToggle('speedhack_enabled', {
        Text = 'speedhack enabled', Default = false,
        Callback = function(first) bhop_enabled = first end
    })
    mvb:AddSlider('speedhack_speed', {
        Text = 'speed', Default = 55, Min = 55, Max = 70, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) speed = State end)
    mvb:AddSlider('speedhack_tp_up', {
        Text = 'tp up studs', Default = 6, Min = 0, Max = 6, Rounding = 0, Compact = false
    }):OnChanged(function(State) tp_up_studs = State end)
    mvb:AddLabel("hold shift and C to speed")
    mvb:AddToggle('downcliff_mode', {
        Text = 'downcliff mode', Default = false,
        Callback = function(first) downcliff_mode = first end
    })
    mvb:AddSlider('downcliff_accel', {
        Text = 'acceleration', Default = 55, Min = 1, Max = 300, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) downcliff_accel = State end)
    mvb:AddSlider('downcliff_fall', {
        Text = 'fall speed', Default = 55, Min = 10, Max = 200, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) downcliff_fall = State end)
    mvb:AddSlider('downcliff_up', {
        Text = 'up speed', Default = 55, Min = 10, Max = 200, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) downcliff_up = State end)
    mvb:AddLabel("hold space to go up")

    local middle = workspace.Const.Ignore.LocalCharacter.Middle
    local bottom = workspace.Const.Ignore.LocalCharacter.Bottom
    local top    = workspace.Const.Ignore.LocalCharacter.Top
    local characterparams = RaycastParams.new()
    characterparams.IgnoreWater = true
    characterparams.FilterDescendantsInstances = { workspace.Const.Ignore }
    characterparams.FilterType = Enum.RaycastFilterType.Exclude
    characterparams.RespectCanCollide = true

    local niga, wtf = speed, 0
    local dc_buildup, dc_oldpos = downcliff_speed, middle.Position

    cheat.utility.new_renderstepped(LPH_JIT_MAX(function(delta)
        local shiftpressed = _IsKeyDown(UserInputService, Enum.KeyCode.LeftShift)
        local cpressed = _IsKeyDown(UserInputService, Enum.KeyCode.C)
        local spacedown = _IsKeyDown(UserInputService, Enum.KeyCode.Space)
        local cameralook = Camera.CFrame.LookVector
        local direction
        if middle and (cpressed or spacedown or shiftpressed or forcesprint or jetpackabuse) then
            local neutralized_look = _Vector3new(cameralook.X, 0, cameralook.Z).Unit
            direction = Vector3.zero
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + neutralized_look or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - neutralized_look or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-neutralized_look.Z, 0, neutralized_look.X) or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(neutralized_look.Z, 0, -neutralized_look.X) or direction;
        end
        if bhop_silent then return end
        wait()
        if bhop_enabled and not downcliff_mode and middle and cpressed and shiftpressed then
            if not (direction == Vector3.zero) then direction = direction.Unit end
            niga = math.clamp(niga - delta * 20, 17, speed)
            if wtf == 0 then
                local tpcf, mdcf, bmcf = top.CFrame, middle.CFrame, bottom.CFrame
                middle.CFrame = mdcf + _Vector3new(0, tp_up_studs, 0)
                bottom.CFrame = bmcf + _Vector3new(0, tp_up_studs, 0)
                top.CFrame = tpcf + _Vector3new(0, tp_up_studs, 0)
            end
            middle.AssemblyLinearVelocity = (direction * niga) + (Vector3.yAxis * (wtf < 0.85 and 0 or -7))
            bottom.AssemblyLinearVelocity = (direction * niga) + (Vector3.yAxis * (wtf < 0.85 and 0 or -7))
            top.AssemblyLinearVelocity = (direction * niga) + (Vector3.yAxis * (wtf < 0.85 and 0 or -7))
            wtf = wtf + delta
        elseif bhop_enabled and downcliff_mode and middle and cpressed and shiftpressed then
            if not (direction == Vector3.zero) then direction = direction.Unit end
            local wattasigma = middle.Position
            local speed_dir = direction * dc_buildup * delta
            local verticalrc = _Raycast(workspace, wattasigma, -Vector3.yAxis * 20, characterparams)
            local horizontalrc = _Raycast(workspace, verticalrc and verticalrc.Position or wattasigma, speed_dir, characterparams)
            dc_buildup = math.clamp(verticalrc and dc_buildup + downcliff_accel * math.abs(wattasigma.Y - verticalrc.Position.Y) or dc_buildup - delta * 30, 17, 250)
            if horizontalrc or verticalrc then
                local middle_pos = (horizontalrc or verticalrc).Position + Vector3.yAxis * 1.5
                local bottom_offset = bottom.Position - middle_pos
                local top_offset = top.Position - middle_pos
                middle.CFrame = _CFramenew(middle_pos)
                bottom.CFrame = _CFramenew(middle_pos + bottom_offset)
                top.CFrame = _CFramenew(middle_pos + top_offset)
                middle.AssemblyLinearVelocity = Vector3.zero
                bottom.AssemblyLinearVelocity = Vector3.zero
                top.AssemblyLinearVelocity = Vector3.zero
            else
                middle.AssemblyLinearVelocity = (direction * dc_buildup) + (Vector3.yAxis * -7)
                bottom.AssemblyLinearVelocity = (direction * dc_buildup) + (Vector3.yAxis * -7)
                top.AssemblyLinearVelocity = (direction * dc_buildup) + (Vector3.yAxis * -7)
            end
        elseif jetpackabuse and middle then
            if not (direction == Vector3.zero) then direction = direction.Unit end
            local yvelo = spacedown and abuseupspeed or shiftpressed and -abusedownspeed or (not shiftpressed and not spacedown) and 0
            middle.AssemblyLinearVelocity = _Vector3new(direction.X * 18, yvelo, direction.Z * 18)
            top.AssemblyLinearVelocity = _Vector3new(direction.X * 18, yvelo, direction.Z * 18)
            bottom.AssemblyLinearVelocity = _Vector3new(direction.X * 18, yvelo, direction.Z * 18)
        else
            if forcesprint and middle then
                if not (direction == Vector3.zero) then direction = direction.Unit end
                middle.AssemblyLinearVelocity = _Vector3new(direction.X * 18, middle.AssemblyLinearVelocity.Y, direction.Z * 18)
            end
            niga = speed
            dc_buildup = 55
            dc_oldpos = middle.Position
            wtf = 0
        end
    end))
end

do
    local mvb = ui.box.left_misc:AddTab('exploits')
    local desyncToggle = mvb:AddToggle('desync_enabled', {
        Text = 'desync enabled', Default = false,
        Tooltip = 'Desync works best in jump — breaks prediction.',
        Callback = function(first) modulecomm.invis = first end
    })
    desyncToggle:AddKeyPicker('desyncbind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'desync', NoUI = false})

    local semiToggle = mvb:AddToggle('seminoclip_enabled', {
        Text = 'seminoclip enabled', Default = false,
        Tooltip = 'semi noclip?',
        Callback = function(first) modulecomm.seminoclip = first end
    })
    semiToggle:AddKeyPicker('seminoclipbind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'seminoclip', NoUI = false})

    local godToggle = mvb:AddToggle('godmode', {
        Text = 'untrusted angle', Default = false,
        Callback = function(first) modulecomm.godmode = first end
    })
    godToggle:AddKeyPicker('godmodebind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'untrusted angle', NoUI = false})
    mvb:AddSlider('godmode_strenght', {
        Text = 'strenght', Default = 6, Min = 0, Max = 20, Rounding = 1, Suffix = "s", Compact = false
    }):OnChanged(function(State) modulecomm.godmode_strenght = State end)

    local spiderToggle = mvb:AddToggle('spider', {
        Text = 'spider', Default = false,
        Callback = function(first) modulecomm.spider = first end
    })
    spiderToggle:AddKeyPicker('spiderbind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'spider', NoUI = false})

    local vbToggle = mvb:AddToggle('velocitybreaker', {
        Text = 'velocity breaker', Default = false,
        Callback = function(first) modulecomm.velobreak = first end
    })
    vbToggle:AddKeyPicker('velocitybreakerbind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'velocity breaker', NoUI = false})
    mvb:AddSlider('velocitybreaker_strenght', {
        Text = 'strenght', Default = 6, Min = 0, Max = 20, Rounding = 1, Suffix = "s", Compact = false
    }):OnChanged(function(State) modulecomm.velobreakstrenght = State end)

    local swToggle = mvb:AddToggle('silentwalk_enabled', {
        Text = 'silent walking', Default = false,
        Callback = function(first)
            modulecomm.silentwalk = first
            if first then trident.tcp:FireServer(2, true) end
        end
    })
    swToggle:AddKeyPicker('silentwalk_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'silent walk', NoUI = false})

    local freecamoffset = Vector3.zero
    local middle = workspace.Const.Ignore.LocalCharacter.Middle
    local bottom = workspace.Const.Ignore.LocalCharacter.Bottom
    local top    = workspace.Const.Ignore.LocalCharacter.Top
    local mdpos, bmpos, tppos = middle.CFrame, bottom.CFrame, top.CFrame
    local enabled, speed, part = false, 10, "middle"

    local fcToggle = mvb:AddToggle('freecam_enabled', {
        Text = 'freecam enabled', Default = false,
        Callback = function(first)
            enabled = first
            modulecomm.invis2 = first
            middle.CanCollide = not first
            bottom.CanCollide = not first
            top.CanCollide = not first
        end
    })
    fcToggle:AddKeyPicker('freecam_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'freecam', NoUI = false})
    mvb:AddSlider('freecam_speed', {
        Text = 'speed', Default = 10, Min = 1, Max = 150, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) speed = State end)
    mvb:AddDropdown('freecam_part', {
        Values = {"middle", "bottom", "top"}, Default = 1, Multi = false, Text = 'freecam part',
        Callback = function(Value) part = Value end
    })
    mvb:AddToggle('infiniteunregtechnique', {
        Text = 'infinite register technique', Default = false,
        Callback = function(first) modulecomm.infiniteregister = first end
    })

    cheat.utility.new_heartbeat(LPH_JIT_MAX(function(delta)
        if enabled and middle then
            if part == "middle" then middle.CFrame = mdpos end
            if part == "bottom" then bottom.CFrame = bmpos end
            if part == "top" then top.CFrame = tppos end
            RunService.RenderStepped:Wait()
            if middle then
                local cameralook = Camera.CFrame.LookVector
                local direction = Vector3.zero
                direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + cameralook or direction;
                direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - cameralook or direction;
                direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
                direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
                if not direction == Vector3.zero then direction = direction.Unit end
                freecamoffset = freecamoffset + (direction * delta * speed)
                if part == "middle" then middle.CFrame = mdpos + freecamoffset end
                if part == "bottom" then bottom.CFrame = bmpos + freecamoffset end
                if part == "top" then top.CFrame = tppos + freecamoffset end
                middle.AssemblyLinearVelocity = Vector3.zero
                bottom.AssemblyLinearVelocity = Vector3.zero
                top.AssemblyLinearVelocity = Vector3.zero
            end
        elseif middle then
            freecamoffset = Vector3.zero
            mdpos, bmpos, tppos = middle.CFrame, bottom.CFrame, top.CFrame
        end
    end))
end

cheat.utility.new_heartbeat(function()
    if modulecomm.seminoclip then
        workspace.Const.Ignore.LocalCharacter.Bottom.Size = Vector3.new(0.15, 0.15, 0.15)
        modulecomm.forseminoclip = true
    end
    if not modulecomm.seminoclip then
        modulecomm.forseminoclip = false
    end
end)
cheat.utility.new_heartbeat(function()
    if not modulecomm.seminoclip then
        workspace.Const.Ignore.LocalCharacter.Bottom.Size = Vector3.new(3, 3, 3)
    end
end)

cheat.utility.new_heartbeat(function(delta)
    if modulecomm.spider then
        local function rotateVector(v, axis, angle)
            local cos = math.cos(angle)
            local sin = math.sin(angle)
            local dot = axis:Dot(v)
            local cross = axis:Cross(v)
            return v * cos + cross * sin + axis * dot * (1 - cos)
        end
        local radius = 40
        local length = 2
        local num_rays = math.max(1, math.floor(radius / 3))
        local angle_step = num_rays > 1 and (2 * math.pi / num_rays) or 0
        local parts = {
            workspace.Const.Ignore.LocalCharacter.Middle,
            workspace.Const.Ignore.LocalCharacter.Bottom,
            workspace.Const.Ignore.LocalCharacter.Top
        }
        for _, part in ipairs(parts) do
            if part then
                local original_dir = part.CFrame.LookVector * length
                local axis = part.CFrame.UpVector
                local should_apply = false
                for i = 1, num_rays do
                    local angle = i * angle_step
                    local dir = rotateVector(original_dir, axis, angle)
                    local ray = Ray.new(part.Position, dir)
                    local hit, _ = workspace:FindPartOnRay(ray, workspace.Const.Ignore.LocalCharacter.Top)
                    local hit2, _ = workspace:FindPartOnRay(ray, workspace.Const.Ignore.LocalCharacter.Middle)
                    if hit and hit2 then should_apply = true; break end
                end
                if should_apply then
                    part.AssemblyLinearVelocity = Vector3.new(part.AssemblyLinearVelocity.X, 10, part.AssemblyLinearVelocity.Z)
                end
            end
        end
    end
end)

do
    local mvb = ui.box.left_misc:AddTab('atv fly')
    local carfly_enabled, speed, accel, upspeed = false, 55, 100, 200
    local cfToggle = mvb:AddToggle('carfly_enabled', {
        Text = 'car fly enabled', Default = false,
        Callback = function(first) carfly_enabled = first end
    })
    cfToggle:AddKeyPicker('carfly_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'car fly bind', NoUI = false})
    mvb:AddSlider('carfly_speed', {
        Text = 'speed', Default = 150, Min = 50, Max = 300, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) speed = State end)
    mvb:AddSlider('carfly_upspeed', {
        Text = 'up speed', Default = 15, Min = 5, Max = 30, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) upspeed = State end)
    mvb:AddSlider('carfly_accel', {
        Text = 'acceleration', Default = 100, Min = 10, Max = 300, Rounding = 0, Suffix = "sps", Compact = false
    }):OnChanged(function(State) accel = State end)
    mvb:AddLabel("hold V to go up")
    mvb:AddLabel("hold B to go down")
    local car, dist = nil, 50
    local findcar = function()
        car, dist = nil, 50
        for i, v in pairs(workspace:GetChildren()) do
            if _FindFirstChild(v, "Seat") and _FindFirstChild(v, "Frame") then
                if (v.Frame.Position - trident.middlepart.Position).Magnitude < dist then
                    car = v
                    dist = (v.Frame.Position - trident.middlepart.Position).Magnitude
                end
            end
        end
    end
    findcar()
    local buildup = 0
    local lastdir = _Vector3new(1, 0, 0)
    cheat.utility.new_renderstepped(LPH_JIT_MAX(function(delta)
        if carfly_enabled and car and _FindFirstChild(car, "Frame") and (car.Frame.CFrame.p - Camera.CFrame.p).Magnitude <= 50 then
            local cameralook = Camera.CFrame.LookVector
            cameralook = _Vector3new(cameralook.X, 0, cameralook.Z)
            local direction = Vector3.zero
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + cameralook or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - cameralook or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.V) and direction + Vector3.yAxis or direction;
            direction = _IsKeyDown(UserInputService, Enum.KeyCode.B) and direction - Vector3.yAxis or direction;
            if direction ~= Vector3.zero then
                direction = direction.Unit
                if direction ~= _Vector3new(0, 1, 0) then
                    buildup = math.clamp(buildup + delta * accel, 0, speed)
                    lastdir = direction
                end
            else
                direction = lastdir
                buildup = math.clamp(buildup - delta * 100, 0, speed)
            end
            for i, v in pairs(car:GetChildren()) do
                v.AssemblyLinearVelocity = _Vector3new(direction.X * buildup, direction.Y * upspeed, direction.Z * buildup)
            end
        elseif not car or car and car:FindFirstChild("Frame") and (car.Frame.CFrame.p - Camera.CFrame.p).Magnitude > 50 then
            findcar()
            buildup = 0
        else
            buildup = 0
        end
    end))

    local noatvrestriction = false
    local charactermod = ui.box.right_misc:AddTab("atv mods")
    charactermod:AddToggle('noatvrestriction', {
        Text = 'no atv restriction', Default = false,
        Callback = function(first) noatvrestriction = first end
    })
    local aaset = modulecomm.antiaim
    charactermod:AddToggle('antiaim_carenabled', {
        Text = 'car antiaim', Default = false,
        Callback = function(first) aaset.car = first end
    })
    charactermod:AddDropdown('antiaim_cartrip', {
        Values = {"none", "zero", "random", "pizdec"}, Default = 1, Multi = false, Text = 'trip mode',
        Callback = function(Value) aaset.cartripmode = Value end
    })
    charactermod:AddSlider('antiaim_cartriprandomspeed', {
        Text = 'trip random speed', Default = 1, Min = 0.1, Max = 50, Rounding = 1, Compact = true,
        Callback = function(State) aaset.cartriprandomspeed = State end
    })
    charactermod:AddDropdown('antiaim_caryaw', {
        Values = {"none", "spin", "random", "pizdec"}, Default = 1, Multi = false, Text = 'car yaw',
        Callback = function(Value) aaset.caryaw = Value end
    })
    charactermod:AddSlider('antiaim_carspinspeed', {
        Text = 'spin speed (rpm)', Default = 60, Min = 60, Max = 360, Rounding = 0, Compact = true,
        Callback = function(State) aaset.carspinspeed = State end
    })
    task.spawn(function()
        while wait() do
            if noatvrestriction then
                setupvalue(garbage.maxlooky, 1, 10000)
            end
        end
    end)
end

do
    local WorldTab = ui.box.visuals_right:AddTab("world visuals")
    local original_time = Lighting.ClockTime
    local time = original_time
    local timechanger = false
    local noshadows = false
    local timeToggle = WorldTab:AddToggle('enabletimechanger', {
        Text = 'enable time changer', Default = false,
        Callback = function(first)
            timechanger = first
            if first then
                Lighting.ClockTime = time
            else
                pcall(function() Lighting.ClockTime = original_time end)
            end
        end
    })
    timeToggle:AddKeyPicker('timechanger_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'time changer', NoUI = false})
    WorldTab:AddSlider('timechanger', {
        Text = 'time changer', Default = mathround(original_time), Min = 0, Max = 24, Rounding = 1, Compact = false
    }):OnChanged(function(State)
        time = State
        if timechanger then Lighting.ClockTime = time end
    end)
    WorldTab:AddToggle('grassswitch', {
        Text = 'no grass', Default = false,
        Callback = function(first)
            pcall(function()
                sethiddenproperty(_FindFirstChildOfClass(workspace, "Terrain"), "Decoration", not first)
            end)
        end
    })
    WorldTab:AddToggle('shadowswitch', {
        Text = 'no shadows', Default = false,
        Callback = function(first) noshadows = first end
    })
    cheat.utility.new_heartbeat(function()
        Lighting.GlobalShadows = not noshadows
        if timechanger then Lighting.ClockTime = time end
    end)
end

do
    local cursor = {
        Enabled = false,
        CustomPos = false,
        Position = _Vector2new(0, 0),
        Speed = 5,
        Radius = 25,
        Color = Color3.fromRGB(180, 50, 255),
        Thickness = 1.7,
        Outline = false,
        Resize = false,
        Dot = false,
        Gap = 10,
        TheGap = false,
        Font = Drawing.Fonts.System,
        rainbow = false,
        sussy = false,
        Text = {
            Logo = false,
            LogoColor = Color3.new(1, 1, 1),
            Name = false,
            NameColor = Color3.new(1, 1, 1),
            LogoFadingOffset = 0,
        }
    }
    local CrosshairTab = ui.box.visuals_right:AddTab("crosshair")
    CrosshairTab:AddDropdown('crosshair_font', {
        Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'crosshair font',
        Tooltip = 'select font',
        Callback = function(Value) cursor.Font = Drawing.Fonts[Value] end
    })
    CrosshairTab:AddToggle('crosshairenable', {
        Text = 'enable crosshair', Default = false,
        Callback = function(first) cursor.Enabled = first end
    }):AddColorPicker('crosshaircolor', {
        Default = Color3.new(1, 1, 1), Title = 'crosshair color', Transparency = 0,
        Callback = function(Value) cursor.Color = Value end
    })
    CrosshairTab:AddSlider('crosshairspeed', {
        Text = 'speed', Default = 0, Min = 0, Max = 15, Rounding = 1, Compact = true
    }):OnChanged(function(State) cursor.Speed = State / 10 end)
    CrosshairTab:AddSlider('crosshairradius', {
        Text = 'radius', Default = 25, Min = 0.1, Max = 100, Rounding = 1, Compact = true
    }):OnChanged(function(State) cursor.Radius = State end)
    CrosshairTab:AddSlider('crosshairthickness', {
        Text = 'thickness', Default = 1.5, Min = 0.1, Max = 10, Rounding = 1, Compact = true
    }):OnChanged(function(State) cursor.Thickness = State end)
    CrosshairTab:AddSlider('crosshairgapsize', {
        Text = 'gap', Default = 5, Min = 0, Max = 50, Rounding = 1, Compact = true
    }):OnChanged(function(State) cursor.Gap = State end)
    CrosshairTab:AddToggle('crosshairenablegap', {
        Text = 'math divide gap', Default = false,
        Callback = function(first) cursor.TheGap = first end
    })
    CrosshairTab:AddToggle('crosshairenableoutline', {
        Text = 'outline', Default = false,
        Callback = function(first) cursor.Outline = first end
    })
    CrosshairTab:AddToggle('crosshairenableresize', {
        Text = 'resize animation', Default = false,
        Callback = function(first) cursor.Resize = first end
    })
    CrosshairTab:AddToggle('crosshairenabledot', {
        Text = 'dot', Default = false,
        Callback = function(first) cursor.Dot = first end
    })
    CrosshairTab:AddToggle('crosshairenablenazi', {
        Text = 'sussy', Default = false,
        Callback = function(first) cursor.sussy = first end
    })
    CrosshairTab:AddToggle('crosshairenablefaggot', {
        Text = 'rainbow', Default = false,
        Callback = function(first) cursor.rainbow = first end
    })
    CrosshairTab:AddToggle('crosshairtextLogo', {
        Text = 'text logo', Default = false,
        Callback = function(first) cursor.Text.Logo = first end
    }):AddColorPicker('crosshairlogocolor', {
        Default = Color3.new(1, 1, 1), Title = 'logo color', Transparency = 0,
        Callback = function(Value) cursor.Text.LogoColor = Value end
    })
    CrosshairTab:AddToggle('crosshairtextName', {
        Text = 'text name', Default = false,
        Callback = function(first) cursor.Text.Name = first end
    }):AddColorPicker('crosshairtextcolor', {
        Default = Color3.new(1, 1, 1), Title = 'text color', Transparency = 0,
        Callback = function(Value) cursor.Text.NameColor = Value end
    })
    CrosshairTab:AddSlider('crosshairlogooffset', {
        Text = 'logo fade offset', Default = 0, Min = 0, Max = 5, Rounding = 1, Compact = true
    }):OnChanged(function(State) cursor.Text.LogoFadingOffset = State end)

    local lines = {}
    local outline = cheat.utility.new_drawing("Square", {
        Visible = true, Size = _Vector2new(4, 4), Color = Color3.fromRGB(0, 0, 0),
        Filled = true, ZIndex = 1, Transparency = 1
    })
    local dot = cheat.utility.new_drawing("Square", {
        Visible = true, Size = _Vector2new(2, 2), Color = cursor.Color,
        Filled = true, ZIndex = 2, Transparency = 1
    })
    local logotext = cheat.utility.new_drawing("Text", {
        Visible = false, Font = cursor.Font, Size = 13, Color = Color3.fromRGB(138, 128, 255),
        ZIndex = 3, Transparency = 1, Text = "swimhub.xyz", Center = true, Outline = true,
    })
    local indicatortext = cheat.utility.new_drawing("Text", {
        Visible = false, Font = cursor.Font, Size = 13, Color = Color3.new(1, 1, 1),
        ZIndex = 3, Transparency = 1, Text = "", Center = true, Outline = true,
    })
    for i = 1, 4 do
        local line_outline = cheat.utility.new_drawing("Line", {
            Visible = true, From = _Vector2new(200, 500), To = _Vector2new(200, 500),
            Color = Color3.fromRGB(0, 0, 0), Thickness = cursor.Thickness + 2.5, ZIndex = 1, Transparency = 1
        })
        local line = cheat.utility.new_drawing("Line", {
            Visible = true, From = _Vector2new(200, 500), To = _Vector2new(200, 500),
            Color = cursor.Color, Thickness = cursor.Thickness, ZIndex = 2, Transparency = 1
        })
        local naziline = cheat.utility.new_drawing("Line", {
            Visible = true, From = _Vector2new(200, 500), To = _Vector2new(200, 500),
            Color = cursor.Color, Thickness = cursor.Thickness, ZIndex = 2, Transparency = 1
        })
        lines[i] = { line, line_outline, naziline }
    end
    local angle, transp, reverse = 0, 0, false
    local pos, rainbow, rotationdegree, color = Vector2.zero, 0, 0, Color3.new()
    local math_cos, math_atan, math_pi, math_sin = math.cos, math.atan, math.pi, math.sin
    local function DEG2RAD(x) return x * math_pi / 180 end
    local function RAD2DEG(x) return x * 180 / math_pi end
    cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
        if cursor.Enabled then
            rainbow = rainbow + (delta * 0.5)
            if rainbow > 1.0 then rainbow = 0.0 end
            color = Color3.fromHSV(rainbow, 1, 1)
            if cursor.CustomPos then pos = cursor.Position else pos = _Vector2new(Mouse.X, Mouse.Y + GuiInset.Y) end
            if cursor.rainbow then color = Color3.fromHSV(rainbow, 1, 1) else color = cursor.Color end
            if transp <= 1.5 + cursor.Text.LogoFadingOffset and not reverse then
                transp = transp + (((cursor.Speed == 0 and 1 or cursor.Speed) * 10) * delta)
                if transp >= 1.5 + cursor.Text.LogoFadingOffset then reverse = true end
            elseif reverse then
                transp = transp - (((cursor.Speed == 0 and 1 or cursor.Speed) * 10) * delta)
                if transp <= 0 - cursor.Text.LogoFadingOffset then reverse = false end
            end
            logotext.Position = _Vector2new(pos.X, (pos + _Vector2new(0, cursor.Radius + 5)).Y)
            logotext.Transparency = transp
            logotext.Visible = cursor.Text.Logo
            logotext.Color = cursor.Text.LogoColor
            logotext.Font = cursor.Font
            indicatortext.Position = _Vector2new(pos.X, (pos + _Vector2new(0, cursor.Radius + (cursor.Text.Logo and 19 or 5))).Y)
            indicatortext.Visible = modulecomm.indicator
            indicatortext.Color = cursor.Text.NameColor
            indicatortext.Font = cursor.Font
            indicatortext.Text = modulecomm.indicator_text

            if cursor.sussy then
                local frametime = delta
                local a = cursor.Radius - 10
                local gamma = math_atan(a / a)
                if rotationdegree >= 90 then rotationdegree = 0 end
                for i = 1, 4 do
                    local p_0 = (a * math_sin(DEG2RAD(rotationdegree + (i * 90))))
                    local p_1 = (a * math_cos(DEG2RAD(rotationdegree + (i * 90))))
                    local p_2 = ((a / math_cos(gamma)) * math_sin(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))
                    local p_3 = ((a / math_cos(gamma)) * math_cos(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))
                    lines[i][1].From = _Vector2new(pos.X, pos.Y)
                    lines[i][1].To = _Vector2new(pos.X + p_0, pos.Y - p_1)
                    lines[i][1].Color = color
                    lines[i][1].Thickness = cursor.Thickness
                    lines[i][1].Visible = true
                    lines[i][3].From = _Vector2new(pos.X + p_0, pos.Y - p_1)
                    lines[i][3].To = _Vector2new(pos.X + p_2, pos.Y - p_3)
                    lines[i][3].Color = color
                    lines[i][3].Thickness = cursor.Thickness
                    lines[i][3].Visible = true
                end
                rotationdegree = rotationdegree + ((cursor.Speed * frametime) * 1000)
            else
                angle = (cursor.Speed == 0 and 0 or angle + ((cursor.Speed * 10) * delta))
                if angle >= 90 then angle = 0 end
                dot.Visible = cursor.Dot
                dot.Color = color
                dot.Position = _Vector2new(pos.X - 1, pos.Y - 1)
                outline.Visible = cursor.Outline and cursor.Dot
                outline.Position = _Vector2new(pos.X - 2, pos.Y - 2)
                for index, line in pairs(lines) do
                    index = index
                    local x, y = {}, {}
                    local x1, y1 = {}, {}
                    if cursor.Resize then
                        x = { pos.X + (math.cos(angle + (index * (math.pi / 2))) * (cursor.Radius + ((cursor.Radius * math.sin(angle)) / 9))),
                              pos.X + (math.cos(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20) - (cursor.TheGap and (((cursor.Radius - 20) * math.cos(angle)) / 4) or (((cursor.Radius - 20) * math.cos(angle)) - 4)))) }
                        y = { pos.Y + (math.sin(angle + (index * (math.pi / 2))) * (cursor.Radius + ((cursor.Radius * math.sin(angle)) / 9))),
                              pos.Y + (math.sin(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20) - (cursor.TheGap and (((cursor.Radius - 20) * math.cos(angle)) / 4) or (((cursor.Radius - 20) * math.cos(angle)) - 4)))) }
                        x1 = { pos.X + (math.cos(angle + (index * (math.pi / 2))) * (cursor.Radius + 1)),
                               pos.X + (math.cos(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20 + 1) - (cursor.TheGap and ((cursor.Radius - 20 + 1) / cursor.Gap) or ((cursor.Radius - 20 + 1) - cursor.Gap)))) }
                        y1 = { pos.Y + (math.sin(angle + (index * (math.pi / 2))) * (cursor.Radius + 1)),
                               pos.Y + (math.sin(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20 + 1) - (cursor.TheGap and ((cursor.Radius - 20 + 1) / cursor.Gap) or ((cursor.Radius - 20 + 1) - cursor.Gap)))) }
                    else
                        x = { pos.X + (math.cos(angle + (index * (math.pi / 2))) * (cursor.Radius)),
                              pos.X + (math.cos(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20) - (cursor.TheGap and ((cursor.Radius - 20) / cursor.Gap) or ((cursor.Radius - 20) - cursor.Gap)))) }
                        y = { pos.Y + (math.sin(angle + (index * (math.pi / 2))) * (cursor.Radius)),
                              pos.Y + (math.sin(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20) - (cursor.TheGap and ((cursor.Radius - 20) / cursor.Gap) or ((cursor.Radius - 20) - cursor.Gap)))) }
                        x1 = { pos.X + (math.cos(angle + (index * (math.pi / 2))) * (cursor.Radius + 1)),
                               pos.X + (math.cos(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20 + 1) - (cursor.TheGap and ((cursor.Radius - 20 + 1) / cursor.Gap) or ((cursor.Radius - 20 + 1) - cursor.Gap)))) }
                        y1 = { pos.Y + (math.sin(angle + (index * (math.pi / 2))) * (cursor.Radius + 1)),
                               pos.Y + (math.sin(angle + (index * (math.pi / 2))) * ((cursor.Radius - 20 + 1) - (cursor.TheGap and ((cursor.Radius - 20 + 1) / cursor.Gap) or ((cursor.Radius - 20 + 1) - cursor.Gap)))) }
                    end
                    line[1].Visible = true
                    line[1].Color = color
                    line[1].From = _Vector2new(x[2], y[2])
                    line[1].To = _Vector2new(x[1], y[1])
                    line[1].Thickness = cursor.Thickness
                    line[2].Visible = cursor.Outline
                    line[2].From = _Vector2new(x1[2], y1[2])
                    line[2].To = _Vector2new(x1[1], y1[1])
                    line[2].Thickness = cursor.Thickness + 2.5
                    line[3].Visible = false
                end
            end
        else
            dot.Visible = false
            outline.Visible = false
            logotext.Visible = false
            indicatortext.Visible = false
            for index, line in pairs(lines) do
                line[1].Visible = false
                line[2].Visible = false
                line[3].Visible = false
            end
        end
    end))
end

do
    local enabled, dynamic = false, false;
    local color1, color2 = Color3.new(1, 1, 1), Color3.new();
    local watermarktab = ui.box.visuals_right:AddTab("watermark")
    local watermarktoggle = watermarktab:AddToggle('watermark_enabled', {
        Text = 'enabled', Default = false,
        Callback = function(first) enabled = first end
    })
    watermarktoggle:AddColorPicker('watermark_color1', {
        Default = Color3.new(), Title = 'color', Transparency = 0,
        Callback = function(Value)
            color1 = Value
            color2 = Value
        end
    })
    watermarktab:AddToggle('watermark_rainbowcolor', {
        Text = 'rainbow', Default = false,
        Callback = function(first) dynamic = first end
    })
    local leftcolor, rightcolor, watertext =
        Color3.new(0, 0.666667, 0.333333),
        Color3.new(0.349020, 0, 1),
        "swimhub.xyz canary | fps: 63 "
    local waterpos = Vector2.new(10, 10);
    local text = cheat.utility.new_drawing("Text", {
        ZIndex = 4, Visible = true, Transparency = 1,
        Position = waterpos + Vector2.new(6, 5),
        Color = Color3.new(1, 1, 1), Outline = true, OutlineColor = Color3.new(),
        Font = 1, Size = 14, Text = watertext
    });
    local gradr = cheat.utility.new_drawing("Square", {
        ZIndex = 2, Visible = true, Transparency = 1, Position = waterpos,
        Size = Vector2.new(text.TextBounds.X + 10, text.TextBounds.Y + 10), Color = rightcolor
    })
    local gradl = cheat.utility.new_drawing("Square", {
        ZIndex = 2, Visible = true, Transparency = 1, Position = waterpos,
        Size = Vector2.new(text.TextBounds.X + 10, text.TextBounds.Y + 10), Color = leftcolor
    })
    local gradbackground = cheat.utility.new_drawing("Square", {
        ZIndex = 1, Visible = true, Transparency = 1, Position = waterpos,
        Size = Vector2.new(text.TextBounds.X + 10, text.TextBounds.Y + 10),
        Color = leftcolor:Lerp(rightcolor, 0.5), Filled = true
    })
    local textbackground = cheat.utility.new_drawing("Square", {
        ZIndex = 3, Visible = true, Transparency = 0.337,
        Position = waterpos + Vector2.new(2, 2),
        Size = Vector2.new(text.TextBounds.X + 6, text.TextBounds.Y + 6),
        Color = Color3.new(0, 0, 0), Filled = true, Thickness = 1e-20,
    })
    local hue1, hue2, fpstimer, fps, finalfps = 0, 0.15, tick(), 0, 60;
    cheat.utility.new_renderstepped(LPH_JIT_MAX(function(delta)
        fps = fps + 1;
        if fpstimer + 1 <= tick() then fpstimer = tick(); finalfps = fps; fps = 0; end;
        hue1, hue2 = tick() % 1, tick() % 1 + 0.15;
        if hue1 >= 1 then hue1 = 0 end
        if hue2 >= 1 then hue2 = 0 end
        rightcolor = dynamic and Color3.fromHSV(hue1, 1, 1) or color2;
        leftcolor = dynamic and Color3.fromHSV(hue2, 1, 1) or color1;
        watertext = ("swimhub %s | %s | %s fps"):format(SWG_Version, SWG_ShortName, tostring(finalfps));
        gradr.Color = rightcolor;
        gradl.Color = leftcolor;
        gradbackground.Color = gradr.Color:Lerp(gradl.Color, 0.5);
        textbackground.Size = Vector2.new(text.TextBounds.X + 7, text.TextBounds.Y + 6);
        textbackground.Position = waterpos + Vector2.new(2, 2);
        gradbackground.Size = Vector2.new(text.TextBounds.X + 11, text.TextBounds.Y + 10);
        gradbackground.Position = waterpos;
        gradl.Position = waterpos;
        gradl.Size = Vector2.new(text.TextBounds.X + 11, text.TextBounds.Y + 10);
        gradr.Position = waterpos;
        gradr.Size = Vector2.new(text.TextBounds.X + 11, text.TextBounds.Y + 10);
        text.Position = waterpos + Vector2.new(6, 5);
        text.Text = watertext;
        text.Visible = enabled;
        gradl.Visible = enabled;
        gradr.Visible = enabled;
        gradbackground.Visible = enabled;
        textbackground.Visible = enabled;
    end))
end

do
    local sounds = {
        ["Default Headshot"] = "rbxassetid://9119561046",
        ["Default Body"]    = "rbxassetid://9114487369",
        Neverlose = "rbxassetid://8726881116",
        Gamesense = "rbxassetid://4817809188",
        One = "rbxassetid://7380502345",
        Bell = "rbxassetid://6534947240",
        Rust = "rbxassetid://1255040462",
        TF2 = "rbxassetid://2868331684",
        Slime = "rbxassetid://6916371803",
        ["Among Us"] = "rbxassetid://5700183626",
        Minecraft = "rbxassetid://4018616850",
        ["CS:GO"] = "rbxassetid://6937353691",
        Saber = "rbxassetid://8415678813",
        Baimware = "rbxassetid://3124331820",
        Osu = "rbxassetid://7149255551",
        ["TF2 Critical"] = "rbxassetid://296102734",
        Bat = "rbxassetid://3333907347",
        ["Call of Duty"] = "rbxassetid://5952120301",
        Bubble = "rbxassetid://6534947588",
        Pick = "rbxassetid://1347140027",
        Pop = "rbxassetid://198598793",
        Bruh = "rbxassetid://4275842574",
        Bamboo = "rbxassetid://3769434519",
        Crowbar = "rbxassetid://546410481",
        Weeb = "rbxassetid://6442965016",
        Beep = "rbxassetid://8177256015",
        Bambi = "rbxassetid://8437203821",
        Stone = "rbxassetid://3581383408",
        ["Old Fatality"] = "rbxassetid://6607142036",
        Click = "rbxassetid://8053704437",
        Ding = "rbxassetid://7149516994",
        Snow = "rbxassetid://6455527632",
        Laser = "rbxassetid://7837461331",
        Mario = "rbxassetid://2815207981",
        Steve = "rbxassetid://4965083997",
        ["Rust Custom"] = "rbxassetid://138750331387064",
        ["Neverlose Custom"] = "rbxassetid://139452805868562"
    }
    local soundKeys = {}
    for name in pairs(sounds) do table.insert(soundKeys, name) end
    table.sort(soundKeys)

    local function ensureSound(name)
        local s = game:GetService("SoundService"):FindFirstChild(name)
        if not s then
            s = Instance.new("Sound")
            s.Name = name
            s.Parent = game:GetService("SoundService")
        end
        return s
    end

    local sHead = ensureSound("PlayerHitHeadshot")
    local sBody = ensureSound("PlayerHit2")

    local HitsoundsTab = ui.tabs.tab:AddLeftTabbox():AddTab('hitsounds')

    HitsoundsTab:AddToggle('hitsound_head_enabled', {
        Text = 'headshot enabled', Default = false
    }):OnChanged(function(state) sHead.Playing = state and sHead.SoundId ~= "" end)
    HitsoundsTab:AddDropdown('hitsound_head_dropdown', {
        Values = soundKeys, Default = 1, Multi = false, Text = 'Head Hitsound:'
    }):OnChanged(function(val)
        sHead.SoundId = sounds[val] or sHead.SoundId
        sHead.Playing = true
    end)
    HitsoundsTab:AddSlider('hitsound_head_volume', {
        Text = 'volume', Default = 5, Min = 0, Max = 10, Rounding = 0
    }):OnChanged(function(vol) sHead.Volume = vol end)
    HitsoundsTab:AddSlider('hitsound_head_pitch', {
        Text = 'pitch', Default = 1, Min = 0, Max = 2, Rounding = 2
    }):OnChanged(function(p) sHead.Pitch = p end)
    HitsoundsTab:AddInput('hitsound_head_custom', {
        Default = "rbxassetid://9119561046", Numeric = false, Finished = true,
        Text = 'custom sound:', Placeholder = "rbxassetid://9119561046"
    }):OnChanged(function(id) sHead.SoundId = id end)

    HitsoundsTab:AddToggle('hitsound_body_enabled', {
        Text = 'body enabled', Default = false
    }):OnChanged(function(state) sBody.Playing = state and sBody.SoundId ~= "" end)
    HitsoundsTab:AddDropdown('hitsound_body_dropdown', {
        Values = soundKeys, Default = 1, Multi = false, Text = 'Body Hitsound:'
    }):OnChanged(function(val)
        sBody.SoundId = sounds[val] or sBody.SoundId
        sBody.Playing = true
    end)
    HitsoundsTab:AddSlider('hitsound_body_volume', {
        Text = 'volume', Default = 5, Min = 0, Max = 10, Rounding = 0
    }):OnChanged(function(vol) sBody.Volume = vol end)
    HitsoundsTab:AddSlider('hitsound_body_pitch', {
        Text = 'pitch', Default = 1, Min = 0, Max = 2, Rounding = 2
    }):OnChanged(function(p) sBody.Pitch = p end)
    HitsoundsTab:AddInput('hitsound_body_custom', {
        Default = "rbxassetid://9114487369", Numeric = false, Finished = true,
        Text = 'custom sound:', Placeholder = "rbxassetid://9114487369"
    }):OnChanged(function(id) sBody.SoundId = id end)
end

do
    local LocalTab = ui.tabs.tab
    local GravityEnabled = false
    local GravityValue = 1
    local OriginalGravity = workspace.Gravity
    local GravityTab = LocalTab:AddLeftTabbox():AddTab('gravity')
    local gravToggle = GravityTab:AddToggle('gravity_enabled', {
        Text = 'enabled', Default = false
    })
    gravToggle:AddKeyPicker('gravityabuse_bind', {Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'gravity abuse', NoUI = false})
    gravToggle:OnChanged(function(state)
        GravityEnabled = state
        if GravityEnabled then
            OriginalGravity = workspace.Gravity
            if not (modulecomm and modulecomm.speedhack) then
                workspace.Gravity = GravityValue * 196.2
            end
        else
            workspace.Gravity = OriginalGravity
        end
    end)
    GravityTab:AddSlider('gravity_value', {
        Text = 'gravity:', Suffix = '%', Default = GravityValue * 100, Min = 0, Max = 200, Rounding = 0
    }):OnChanged(function(val)
        GravityValue = val / 100
        if GravityEnabled and not (modulecomm and modulecomm.speedhack) then
            workspace.Gravity = GravityValue * 196.2
        end
    end)
end

do
    local LocalTab = ui.tabs.tab
    local AspectRatioEnabled = false
    local StretchValue = 100
    local Cam = workspace.CurrentCamera
    local OldNewIndex
    OldNewIndex = hookmetamethod(game, "__newindex", function(self, Key, Value)
        if self == Cam and Key == "CFrame" and AspectRatioEnabled then
            local X, Y, Z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = Value:GetComponents()
            Value = CFrame.new(
                X, Y, Z,
                R00, R01 * StretchValue / 100, R02,
                R10, R11 * StretchValue / 100, R12,
                R20, R21 * StretchValue / 100, R22
            )
        end
        return OldNewIndex(self, Key, Value)
    end)
    local AspectTab = LocalTab:AddLeftTabbox():AddTab('aspect ratio')
    AspectTab:AddToggle('aspectratio_enabled', {
        Text = 'aspect ratio', Default = false
    }):OnChanged(function(state) AspectRatioEnabled = state end)
    AspectTab:AddSlider('aspectratio_value', {
        Text = 'ratio', Suffix = '%', Default = 100, Min = 1, Max = 200, Rounding = 0
    }):OnChanged(function(val) StretchValue = val end)
end

do
    local function findPath(root, paths)
        local cur = root
        for _, p in ipairs(paths) do
            cur = cur:FindFirstChild(p)
            if not cur then return nil end
        end
        return cur
    end

    local armPartNames = {
        {"Const","Ignore","FPSArms","RightHand"},
        {"Const","Ignore","FPSArms","RightLowerArm"},
        {"Const","Ignore","FPSArms","LeftLowerArm"},
        {"Const","Ignore","FPSArms","LeftHand"},
        {"Const","Ignore","FPSArms","Fake","c_RightLowerArm"},
        {"Const","Ignore","FPSArms","Fake","c_LeftLowerArm"},
    }

    local function getArmParts()
        local parts = {}
        for _, paths in ipairs(armPartNames) do
            local ok, p = pcall(findPath, workspace, paths)
            if ok and p and p:IsA("BasePart") then
                table.insert(parts, p)
            end
        end
        return parts
    end

    local Visuals = {
        Chams = {
            WeaponChams          = false,
            WeaponChams_Color    = Color3.fromRGB(0, 120, 255),
            WeaponChams_Material = "ForceField",

            ArmChams             = false,
            ArmChams_Color       = Color3.fromRGB(0, 120, 255),
            ArmChams_Material    = "ForceField",

            Cache = {
                WeaponMaterial = setmetatable({}, {__mode = "kv"}),
                WeaponColor    = setmetatable({}, {__mode = "kv"}),
                ArmMaterial    = setmetatable({}, {__mode = "kv"}),
                ArmColor       = setmetatable({}, {__mode = "kv"}),
            }
        },
        Tracers = {
            enabled    = false,
            color      = Color3.fromRGB(0, 120, 255),
            thickness  = 0.1,
            lifetime   = 1.5,
            rainbow    = false,
        }
    }

    local Viewmodel = game:GetService("ReplicatedStorage"):FindFirstChild("HandModels")

    local function recacheWeapon()
        Visuals.Chams.Cache.WeaponMaterial = setmetatable({}, {__mode = "kv"})
        Visuals.Chams.Cache.WeaponColor    = setmetatable({}, {__mode = "kv"})
        if not Viewmodel then return end
        local ok, children = pcall(function() return Viewmodel:GetChildren() end)
        if not ok or not children then return end
        for _, Child in pairs(children) do
            if Child and Child:IsA("Model") then
                local ok2, descendants = pcall(function() return Child:GetDescendants() end)
                if ok2 and descendants then
                    for _, Part in pairs(descendants) do
                        if Part and Part:IsA("BasePart") then
                            Visuals.Chams.Cache.WeaponMaterial[Part] = Part.Material
                            Visuals.Chams.Cache.WeaponColor[Part]    = Part.Color
                        end
                    end
                end
            end
        end
    end
    recacheWeapon()

    local function recacheArms()
        Visuals.Chams.Cache.ArmMaterial = setmetatable({}, {__mode = "kv"})
        Visuals.Chams.Cache.ArmColor    = setmetatable({}, {__mode = "kv"})
        for _, p in ipairs(getArmParts()) do
            if p then
                pcall(function()
                    Visuals.Chams.Cache.ArmMaterial[p] = p.Material
                    Visuals.Chams.Cache.ArmColor[p]    = p.Color
                end)
            end
        end
    end
    recacheArms()

    local fpsArms = findPath(workspace, {"Const","Ignore","FPSArms"})
    if fpsArms then
        fpsArms.ChildAdded:Connect(function()
            task.wait(0.2); recacheArms()
        end)
        fpsArms.ChildRemoved:Connect(function()
            task.wait(0.1); recacheArms()
        end)
    end

    function Visuals.Chams.Update()
        if Viewmodel then
            local ok1, children = pcall(function() return Viewmodel:GetChildren() end)
            if ok1 and children then
                for _, Child in pairs(children) do
                    if Child and Child:IsA("Model") then
                        local ok2, descendants = pcall(function() return Child:GetDescendants() end)
                        if ok2 and descendants then
                            for _, Part in pairs(descendants) do
                                if Part and Part:IsA("BasePart") then
                                    if Visuals.Chams.WeaponChams then
                                        pcall(function()
                                            Part.Material = Enum.Material[Visuals.Chams.WeaponChams_Material]
                                        end)
                                        pcall(function()
                                            Part.Color = Visuals.Chams.WeaponChams_Color
                                        end)
                                    else
                                        local origMat = Visuals.Chams.Cache.WeaponMaterial[Part]
                                        local origCol = Visuals.Chams.Cache.WeaponColor[Part]
                                        if origMat then pcall(function() Part.Material = origMat end) end
                                        if origCol then pcall(function() Part.Color = origCol end) end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        local armParts = getArmParts()
        for _, part in ipairs(armParts) do
            if part and part.Parent then
                if Visuals.Chams.ArmChams then
                    pcall(function()
                        part.Material = Enum.Material[Visuals.Chams.ArmChams_Material]
                    end)
                    pcall(function()
                        part.Color = Visuals.Chams.ArmChams_Color
                    end)
                else
                    local origMat = Visuals.Chams.Cache.ArmMaterial[part]
                    local origCol = Visuals.Chams.Cache.ArmColor[part]
                    if origMat then pcall(function() part.Material = origMat end) end
                    if origCol then pcall(function() part.Color = origCol end) end
                end
            end
        end
    end

    cheat.utility.new_heartbeat(function()
        if Visuals.Chams.ArmChams or Visuals.Chams.WeaponChams then
            pcall(Visuals.Chams.Update)
        end
    end)

    local bulletNames = {"Bullet","BlueBullet","Projectile","Rocket","Missile","Grenade"}

    local function isLocalArrow(obj)
        local ok, res = pcall(function()
            local fps = workspace:FindFirstChild("Const")
                and workspace.Const:FindFirstChild("Ignore")
                and workspace.Const.Ignore:FindFirstChild("FPSArms")
            if fps then
                local hm = fps:FindFirstChild("HandModel")
                return hm and hm:FindFirstChild("Arrow") == obj
            end
            return false
        end)
        return ok and res
    end

    local function createTracer(proj)
        if not proj then return end
        if proj.Name == "Arrow" and isLocalArrow(proj) then return end

        local ok0, startPos = pcall(function()
            return proj.Position or (proj.CFrame and proj.CFrame.Position)
        end)
        if not ok0 or not startPos then return end
        local lastPos = startPos

        local conn
        conn = cheat.utility.new_renderstepped(function()
            if not Visuals.Tracers.enabled or not proj or not proj.Parent then
                if conn then conn:Disconnect() end
                return
            end

            if proj.Name == "Arrow" and isLocalArrow(proj) then
                if conn then conn:Disconnect() end
                return
            end

            local ok, currentPos = pcall(function()
                return proj.Position or (proj.CFrame and proj.CFrame.Position)
            end)
            if not ok or not currentPos then
                if conn then conn:Disconnect() end
                return
            end

            local distance = (currentPos - lastPos).Magnitude
            if distance > 0.5 and distance < 500 then
                local tracer = Instance.new("Part")
                tracer.Anchored = true
                tracer.CanCollide = false
                tracer.CanQuery = false
                tracer.CanTouch = false
                tracer.Size = Vector3.new(Visuals.Tracers.thickness, Visuals.Tracers.thickness, distance)
                pcall(function()
                    tracer.CFrame = CFrame.new(lastPos, currentPos) * CFrame.new(0, 0, -distance/2)
                end)
                tracer.Color = Visuals.Tracers.rainbow and cheat.utility.rainbow_color(0) or Visuals.Tracers.color
                tracer.Material = Enum.Material.Neon
                tracer.Transparency = 0
                tracer.Parent = workspace
                pcall(function()
                    game:GetService("Debris"):AddItem(tracer, Visuals.Tracers.lifetime)
                end)
            end
            lastPos = currentPos
        end)
    end

    workspace.DescendantAdded:Connect(function(obj)
        if not obj then return end
        pcall(function()
            if obj:IsDescendantOf(game:GetService("ReplicatedStorage")) then return end
        end)
        task.wait()
        if not Visuals.Tracers.enabled then return end
        for _, name in ipairs(bulletNames) do
            if obj.Name == name then
                task.spawn(createTracer, obj)
                return
            end
        end
        if obj.Name == "Arrow" and not isLocalArrow(obj) then
            task.spawn(createTracer, obj)
        end
    end)

    local VisualsGroup = ui.box.weapon_visuals

    local wpnToggle = VisualsGroup:AddToggle('weapon_chams', {
        Text = 'weapon chams', Default = false,
        Callback = function(v)
            Visuals.Chams.WeaponChams = v
            pcall(Visuals.Chams.Update)
        end
    })
    wpnToggle:AddColorPicker('weapon_chams_color', {
        Default = Visuals.Chams.WeaponChams_Color,
        Title = 'weapon color',
        Transparency = 0,
        Callback = function(c)
            Visuals.Chams.WeaponChams_Color = c
            if Visuals.Chams.WeaponChams then pcall(Visuals.Chams.Update) end
        end
    })
    VisualsGroup:AddDropdown('weapon_chams_material', {
        Text = 'weapon material',
        Values = {"Neon","ForceField"}, Default = 1, Multi = false,
        Callback = function(v)
            Visuals.Chams.WeaponChams_Material = v
            if Visuals.Chams.WeaponChams then pcall(Visuals.Chams.Update) end
        end
    })

    local armToggle = VisualsGroup:AddToggle('arm_chams', {
        Text = 'arm chams', Default = false,
        Callback = function(v)
            Visuals.Chams.ArmChams = v
            pcall(Visuals.Chams.Update)
        end
    })
    armToggle:AddColorPicker('arm_chams_color', {
        Default = Visuals.Chams.ArmChams_Color,
        Title = 'arm color',
        Transparency = 0,
        Callback = function(c)
            Visuals.Chams.ArmChams_Color = c
            if Visuals.Chams.ArmChams then pcall(Visuals.Chams.Update) end
        end
    })
    VisualsGroup:AddDropdown('arm_chams_material', {
        Text = 'arm material',
        Values = {"Neon","ForceField"}, Default = 1, Multi = false,
        Callback = function(v)
            Visuals.Chams.ArmChams_Material = v
            if Visuals.Chams.ArmChams then pcall(Visuals.Chams.Update) end
        end
    })

    local tracerToggle = VisualsGroup:AddToggle('bullet_tracers', {
        Text = 'bullet tracers', Default = false,
        Callback = function(v) Visuals.Tracers.enabled = v end
    })
    tracerToggle:AddColorPicker('bullet_tracers_color', {
        Default = Visuals.Tracers.color,
        Title = 'tracer color',
        Transparency = 0,
        Callback = function(v) Visuals.Tracers.color = v end
    })

    VisualsGroup:AddSlider('bullet_tracers_thickness', {
        Text = 'tracer thickness', Default = 0.1, Min = 0.05, Max = 0.5, Rounding = 2, Suffix = 'st',
        Callback = function(v) Visuals.Tracers.thickness = v end
    })
    VisualsGroup:AddSlider('bullet_tracers_lifetime', {
        Text = 'tracer lifetime', Default = 1.5, Min = 0.5, Max = 5, Rounding = 1, Suffix = 's',
        Callback = function(v) Visuals.Tracers.lifetime = v end
    })
end

do
    local Hitmarker = {
        enabled      = false,
        color        = Color3.fromRGB(255, 255, 255),
        outlineColor = Color3.fromRGB(0, 0, 0),
        thickness    = 2,
        size         = 12,
        lifetime     = 0.7,
        speed        = 180,
        outline      = true,
        active       = {},
        cache        = {},
    }

    local function createHitmarker(pos2d)
        local entry = {
            born     = tick(),
            rot      = 0,
            pos      = pos2d,
            lines    = {},
            outlines = {},
        }

        for i = 1, 4 do
            local ol = Drawing.new("Line")
            ol.Thickness = Hitmarker.thickness + 2
            ol.Color = Hitmarker.outlineColor
            ol.Transparency = 1
            ol.Visible = false
            ol.ZIndex = 100

            local ln = Drawing.new("Line")
            ln.Thickness = Hitmarker.thickness
            ln.Color = Hitmarker.color
            ln.Transparency = 1
            ln.Visible = false
            ln.ZIndex = 101

            table.insert(entry.outlines, ol)
            table.insert(entry.lines, ln)
        end

        table.insert(Hitmarker.active, entry)
    end

    local function updateHitmarkers(delta)
        for i = #Hitmarker.active, 1, -1 do
            local hm = Hitmarker.active[i]
            local elapsed = tick() - hm.born
            local alpha = 1 - (elapsed / Hitmarker.lifetime)

            if alpha <= 0 then
                for _, ln in ipairs(hm.lines) do pcall(function() ln:Remove() end) end
                for _, ol in ipairs(hm.outlines) do pcall(function() ol:Remove() end) end
                table.remove(Hitmarker.active, i)
            else
                hm.rot = hm.rot + (Hitmarker.speed * delta)

                for idx = 1, 4 do
                    local angle = math.rad(hm.rot + (idx - 1) * 90)
                    local size = Hitmarker.size
                    local x1 = hm.pos.X + math.cos(angle) * (size * 0.4)
                    local y1 = hm.pos.Y + math.sin(angle) * (size * 0.4)
                    local x2 = hm.pos.X + math.cos(angle) * size
                    local y2 = hm.pos.Y + math.sin(angle) * size

                    local ln = hm.lines[idx]
                    ln.From = Vector2.new(x1, y1)
                    ln.To   = Vector2.new(x2, y2)
                    ln.Color = Hitmarker.color
                    ln.Transparency = alpha
                    ln.Visible = true

                    local ol = hm.outlines[idx]
                    ol.From = Vector2.new(x1, y1)
                    ol.To   = Vector2.new(x2, y2)
                    ol.Color = Hitmarker.outlineColor
                    ol.Transparency = alpha
                    ol.Visible = Hitmarker.outline
                end
            end
        end
    end

    cheat.utility.new_renderstepped(updateHitmarkers)

    local function hookProjectile(proj)
        if not proj then return end
        if Hitmarker.cache[proj] then return end
        Hitmarker.cache[proj] = true

        local lastPos = proj.Position or (proj.CFrame and proj.CFrame.Position)
        if not lastPos then return end
        local lastTick = tick()
        local conn
        conn = cheat.utility.new_heartbeat(function(delta)
            if not Hitmarker.enabled or not proj or not proj.Parent then
                if conn then conn:Disconnect() end
                Hitmarker.cache[proj] = nil
                return
            end

            local ok, currentPos = pcall(function()
                return proj.Position or proj.CFrame.Position
            end)
            if not ok or not currentPos then
                if conn then conn:Disconnect() end
                Hitmarker.cache[proj] = nil
                return
            end

            local distance = (currentPos - lastPos).Magnitude
            local timeDelta = tick() - lastTick
            lastTick = tick()

            if distance < 0.5 and timeDelta > 0.05 then
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(currentPos)
                if onScreen then
                    createHitmarker(Vector2.new(screenPos.X, screenPos.Y))
                end
                if conn then conn:Disconnect() end
                Hitmarker.cache[proj] = nil
                return
            end

            lastPos = currentPos
        end)
    end

    local bulletNames = {"Bullet","BlueBullet","Projectile","Rocket","Missile","Grenade","Arrow"}
    workspace.DescendantAdded:Connect(function(obj)
        if not obj then return end
        if obj:IsDescendantOf(game:GetService("ReplicatedStorage")) then return end
        task.wait()
        if not Hitmarker.enabled then return end
        for _, name in ipairs(bulletNames) do
            if obj.Name == name then
                task.spawn(hookProjectile, obj)
                return
            end
        end
    end)

    local HitmarkerTab = ui.box.visuals_right:AddTab("hitmarker")

    HitmarkerTab:AddToggle('hitmarker_enabled', {
        Text = 'enable hitmarker', Default = false,
        Callback = function(v) Hitmarker.enabled = v end
    }):AddColorPicker('hitmarker_color', {
        Default = Color3.fromRGB(255, 255, 255),
        Title = 'hitmarker color',
        Transparency = 0,
        Callback = function(c) Hitmarker.color = c end
    }):AddColorPicker('hitmarker_outline_color', {
        Default = Color3.fromRGB(0, 0, 0),
        Title = 'outline color',
        Transparency = 0,
        Callback = function(c) Hitmarker.outlineColor = c end
    })

    HitmarkerTab:AddToggle('hitmarker_outline', {
        Text = 'show outline', Default = true,
        Callback = function(v) Hitmarker.outline = v end
    })

    HitmarkerTab:AddSlider('hitmarker_thickness', {
        Text = 'thickness', Default = 2, Min = 1, Max = 8, Rounding = 1, Compact = true,
        Callback = function(v) Hitmarker.thickness = v end
    })

    HitmarkerTab:AddSlider('hitmarker_size', {
        Text = 'size', Default = 12, Min = 4, Max = 40, Rounding = 0, Compact = true,
        Callback = function(v) Hitmarker.size = v end
    })

    HitmarkerTab:AddSlider('hitmarker_lifetime', {
        Text = 'lifetime', Default = 0.7, Min = 0.1, Max = 3, Rounding = 2, Suffix = 's', Compact = true,
        Callback = function(v) Hitmarker.lifetime = v end
    })

    HitmarkerTab:AddSlider('hitmarker_speed', {
        Text = 'spin speed', Default = 180, Min = 0, Max = 720, Rounding = 0, Compact = true,
        Callback = function(v) Hitmarker.speed = v end
    })
end

do
    local FovChanger = {
        enabled = false,
        add = 120,
        oldFov = workspace.CurrentCamera.FieldOfView,
    }

    local ZoomControl = {
        enabled = false,
        amount = 5,
        oldFov = workspace.CurrentCamera.FieldOfView,
    }

    local cam = workspace.CurrentCamera

    local function applyFov()
        if FovChanger.enabled then
            cam.FieldOfView = FovChanger.oldFov + FovChanger.add
        else
            cam.FieldOfView = FovChanger.oldFov
        end
    end

    local function applyZoom()
        if ZoomControl.enabled then
            local z = math.clamp(ZoomControl.amount, 1, 10)
            cam.FieldOfView = ZoomControl.oldFov / z
        else
            cam.FieldOfView = ZoomControl.oldFov
        end
    end

    cheat.utility.new_renderstepped(function()
        if FovChanger.enabled then
            applyFov()
        elseif ZoomControl.enabled then
            applyZoom()
        end
    end)

    local FovTab = ui.box.visuals_right:AddTab("fov / zoom")

    FovTab:AddToggle('fovchanger_enabled', {
        Text = 'fov changer', Default = false,
        Callback = function(v)
            FovChanger.enabled = v
            if v then
                FovChanger.oldFov = cam.FieldOfView
                ZoomControl.enabled = false
                if cheat.Toggles and cheat.Toggles.zoom_enabled then
                    cheat.Toggles.zoom_enabled:SetValue(false)
                end
            end
        end
    })

    FovTab:AddSlider('fovchanger_add', {
        Text = 'fov add', Default = 120, Min = 10, Max = 150, Rounding = 0, Compact = true,
        Callback = function(v)
            FovChanger.add = v
            if FovChanger.enabled then applyFov() end
        end
    })

    local ZoomToggle = FovTab:AddToggle('zoom_enabled', {
        Text = 'zoom', Default = false,
        Callback = function(v)
            ZoomControl.enabled = v
            if v then
                ZoomControl.oldFov = cam.FieldOfView
                FovChanger.enabled = false
                if cheat.Toggles and cheat.Toggles.fovchanger_enabled then
                    cheat.Toggles.fovchanger_enabled:SetValue(false)
                end
            end
        end
    })
    ZoomToggle:AddKeyPicker('zoom_bind', {
        Default = 'None', SyncToggleState = true, Mode = 'Toggle', Text = 'zoom key', NoUI = false
    })

    FovTab:AddSlider('zoom_amount', {
        Text = 'zoom amount (x)', Default = 5, Min = 1, Max = 10, Rounding = 1, Compact = true,
        Callback = function(v)
            ZoomControl.amount = v
            if ZoomControl.enabled then applyZoom() end
        end
    })
end

do
    local Shoulders = {
        enabled = false,
        originalSize = {},
    }

    local function findShoulderParts()
        local parts = {}
        local char = workspace:FindFirstChild("Const")
            and workspace.Const:FindFirstChild("Ignore")
            and workspace.Const.Ignore:FindFirstChild("LocalCharacter")
        if not char then return parts end
        for _, name in ipairs({"LeftShoulder", "RightShoulder", "ShoulderL", "ShoulderR"}) do
            local p = char:FindFirstChild(name, true)
            if p and p:IsA("BasePart") then
                table.insert(parts, p)
            end
        end
        return parts
    end

    local function restoreShoulders()
        for part, size in pairs(Shoulders.originalSize) do
            if part and part.Parent then
                part.Size = size
                part.Transparency = 0
                part.LocalTransparencyModifier = 0
            end
        end
        Shoulders.originalSize = {}
    end

    local function enableShoulders()
        local parts = findShoulderParts()
        for _, part in ipairs(parts) do
            if not Shoulders.originalSize[part] then
                Shoulders.originalSize[part] = part.Size
            end
            part.Transparency = 0
            part.LocalTransparencyModifier = 0
            part.CanCollide = false
        end
    end

    local ShouldersTab = ui.box.right_misc:AddTab("shoulders")

    ShouldersTab:AddToggle('shoulders_enabled', {
        Text = 'show shoulders', Default = false,
        Callback = function(v)
            Shoulders.enabled = v
            if v then
                enableShoulders()
            else
                restoreShoulders()
            end
        end
    })

    ShouldersTab:AddSlider('shoulders_size', {
        Text = 'size multiplier', Default = 1, Min = 0.5, Max = 3, Rounding = 2, Compact = true,
        Callback = function(v)
            local parts = findShoulderParts()
            for _, part in ipairs(parts) do
                if not Shoulders.originalSize[part] then
                    Shoulders.originalSize[part] = part.Size
                end
                local orig = Shoulders.originalSize[part]
                part.Size = orig * v
            end
        end
    })

    cheat.utility.new_heartbeat(function()
        if Shoulders.enabled then
            local parts = findShoulderParts()
            for _, part in ipairs(parts) do
                if part and part.Parent then
                    part.Transparency = 0
                    part.LocalTransparencyModifier = 0
                end
            end
        end
    end)
end

do
    local espb = ui.box.esp:AddTab("player esp")
    local es = cheat.EspLibrary.settings.enemy
    espb:AddDropdown('espfont', {
        Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'esp font',
        Tooltip = 'select font',
        Callback = function(Value)
            cheat.EspLibrary.main_settings.textFont = Drawing.Fonts[Value]
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddSlider('espfontsize', {
        Text = 'esp font size', Default = 13, Min = 1, Max = 30, Rounding = 0, Compact = true
    }):OnChanged(function(State)
        cheat.EspLibrary.main_settings.textSize = State
        cheat.EspLibrary.icaca()
    end)
    espb:AddToggle('espsimplecalc', {
        Text = 'simpler corner calc (fps)', Default = false,
        Callback = function(first)
            cheat.EspLibrary.main_settings.simplecalc = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('espswitch', {
        Text = 'enable esp', Default = false,
        Callback = function(first)
            es.enabled = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('esp_rainbow', {
        Text = 'rainbow esp (everyone has own hue)', Default = false,
        Callback = function(first)
            cheat.EspLibrary.main_settings.rainbow = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('espteamswitch', {
        Text = 'team/ai check', Default = false,
        Callback = function(first)
            cheat.EspLibrary.main_settings.teamcheck = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('espsleeperswitch', {
        Text = 'sleeper check', Default = false,
        Callback = function(first)
            cheat.EspLibrary.main_settings.sleepcheck = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('espbox', {
        Text = 'box esp', Default = false,
        Callback = function(first) es.box = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espboxcolor', {
        Default = Color3.new(1, 1, 1), Title = 'box color', Transparency = 0,
        Callback = function(Value) es.box_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espboxfill', {
        Text = 'box fill', Default = false,
        Callback = function(first) es.box_fill = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espboxfillcolor', {
        Default = Color3.new(1, 1, 1), Title = 'box fill color', Transparency = 0,
        Callback = function(Value) es.box_fill_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espoutlinebox', {
        Text = 'box outline', Default = false,
        Callback = function(first) es.box_outline = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espboxoutlinecolor', {
        Default = Color3.new(), Title = 'box outline color', Transparency = 0,
        Callback = function(Value) es.box_outline_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('espboxtransparency', {
        Text = 'box transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.box_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddSlider('espoutlineboxtransparency', {
        Text = 'box outline transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.box_outline_color[2] = State; cheat.EspLibrary.icaca() end)
    espb:AddSlider('espboxfilltransparency', {
        Text = 'box fill transparency', Default = 0.5, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.box_fill_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('esprealname', {
        Text = 'name esp', Default = false,
        Callback = function(first) es.realname = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('esprealnamecolor', {
        Default = Color3.new(1, 1, 1), Title = 'name color', Transparency = 0,
        Callback = function(Value) es.realname_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('esprealnametransparency', {
        Text = 'name transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.realname_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('esprealnameoutline', {
        Text = 'name outline', Default = false,
        Callback = function(first) es.realname_outline = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('esprealnameoutlinecolor', {
        Default = Color3.new(), Title = 'name outline color', Transparency = 0,
        Callback = function(Value) es.realname_outline_color = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espdistance', {
        Text = 'distance esp', Default = false,
        Callback = function(first) es.dist = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espdistancecolor', {
        Default = Color3.new(1, 1, 1), Title = 'distance color', Transparency = 0,
        Callback = function(Value) es.dist_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('espdistancetransparency', {
        Text = 'distance transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.dist_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('espdistanceoutline', {
        Text = 'distance outline', Default = false,
        Callback = function(first) es.dist_outline = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espdistanceoutlinecolor', {
        Default = Color3.new(), Title = 'distance outline color', Transparency = 0,
        Callback = function(Value) es.dist_outline_color = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espweapon', {
        Text = 'weapon esp', Default = false,
        Callback = function(first) es.weapon = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espweaponcolor', {
        Default = Color3.new(1, 1, 1), Title = 'weapon color', Transparency = 0,
        Callback = function(Value) es.weapon_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('espweapontransparency', {
        Text = 'weapon transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.weapon_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('espweaponoutline', {
        Text = 'weapon outline', Default = false,
        Callback = function(first) es.weapon_outline = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espweaponoutlinecolor', {
        Default = Color3.new(), Title = 'weapon outline color', Transparency = 0,
        Callback = function(Value) es.weapon_outline_color = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espskeleton', {
        Text = 'skeleton esp', Default = false,
        Callback = function(first) es.skeleton = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('espskeletoncolor', {
        Default = Color3.new(1, 1, 1), Title = 'skeleton color', Transparency = 0,
        Callback = function(Value) es.skeleton_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('espskeletontransparency', {
        Text = 'skeleton transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.skeleton_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('espchams', {
        Text = 'chams', Default = false,
        Callback = function(first) es.chams = first; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('espchamsvisibleonly', {
        Text = 'chams visible only', Default = false,
        Callback = function(first) es.chams_visible_only = first; cheat.EspLibrary.icaca() end
    })
    espb:AddLabel("chams fill color"):AddColorPicker('espchamsfillcolor', {
        Default = Color3.new(), Title = 'chams fill color', Transparency = 0,
        Callback = function(Value) es.chams_fill_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddLabel("chams outline color"):AddColorPicker('espchamsoutlinecolor', {
        Default = Color3.new(), Title = 'chams outline color', Transparency = 0,
        Callback = function(Value) es.chamsoutline_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('espchamsfilltransparency', {
        Text = 'fill transparency', Default = 0.5, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.chams_fill_color[2] = State; cheat.EspLibrary.icaca() end)
    espb:AddSlider('espchamsoutlinetransparency', {
        Text = 'outline transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.chamsoutline_color[2] = State; cheat.EspLibrary.icaca() end)
end

do
    local espb = ui.box.esp:AddTab("object esp")
    local es = cheat.EspLibrary.settings.object
    espb:AddDropdown('objectespfont', {
        Values = {'UI', 'System', 'Plex', 'Monospace'}, Default = 2, Multi = false, Text = 'esp font',
        Tooltip = 'select font',
        Callback = function(Value)
            cheat.EspLibrary.main_object_settings.textFont = Drawing.Fonts[Value]
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddSlider('objectespfontsize', {
        Text = 'esp font size', Default = 13, Min = 1, Max = 30, Rounding = 0, Compact = true
    }):OnChanged(function(State)
        cheat.EspLibrary.main_object_settings.textSize = State
        cheat.EspLibrary.icaca()
    end)
    espb:AddDropdown('objectespallowed', {
        Values = {'ATV', 'Stone', 'Nitrate', 'Iron', 'Backpack', 'Tree1', 'Tree2', 'Tree3', 'Tree4', 'TeslaPylon', 'GasTrap', 'ClaimTotem'},
        Default = 0, Multi = true, Text = 'objects', Tooltip = 'select objects thats gonna show up',
        Callback = function(Value)
            cheat.EspLibrary.main_object_settings.allowed = Value
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('objectespswitch', {
        Text = 'enable esp', Default = false,
        Callback = function(first) es.enabled = first; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('object_esp_rainbow', {
        Text = 'rainbow (each object own hue)', Default = false,
        Callback = function(first)
            cheat.EspLibrary.main_object_settings.rainbow = first
            cheat.EspLibrary.icaca()
        end
    })
    espb:AddToggle('objectespallswitch', {
        Text = 'esp on everything', Default = false,
        Callback = function(first) es.allenabled = first; cheat.EspLibrary.icaca() end
    })
    espb:AddToggle('objectesprealname', {
        Text = 'name esp', Default = false,
        Callback = function(first) es.realname = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('objectesprealnamecolor', {
        Default = Color3.new(1, 1, 1), Title = 'name color', Transparency = 0,
        Callback = function(Value) es.realname_color[1] = Value; cheat.EspLibrary.icaca() end
    })
    espb:AddSlider('objectesprealnametransparency', {
        Text = 'name transparency', Default = 0, Min = 0, Max = 1, Rounding = 1, Compact = false
    }):OnChanged(function(State) es.realname_color[2] = 1 - State; cheat.EspLibrary.icaca() end)
    espb:AddToggle('objectesprealnameoutline', {
        Text = 'name outline', Default = false,
        Callback = function(first) es.realname_outline = first; cheat.EspLibrary.icaca() end
    }):AddColorPicker('objectesprealnameoutlinecolor', {
        Default = Color3.new(), Title = 'name outline color', Transparency = 0,
        Callback = function(Value) es.realname_outline_color = Value; cheat.EspLibrary.icaca() end
    })
end

local real_extended = 0
local game_Lighting = game:GetService("Lighting")
local torso_spoofed_index = {
    ["Transparency"] = trident.original_model["Torso"]["Transparency"],
    ["CanCollide"]   = trident.original_model["Torso"]["CanCollide"],
    ["Size"]         = trident.original_model["Torso"]["Size"]
}
local lighting_oldvalues = {
    ["Ambient"]        = game_Lighting.Ambient,
    ["OutdoorAmbient"] = game_Lighting.OutdoorAmbient,
    ["FogStart"]       = game_Lighting.FogStart,
    ["FogEnd"]         = game_Lighting.FogEnd,
    ["GlobalShadows"]  = game_Lighting.GlobalShadows,
    ["ClockTime"]      = game_Lighting.ClockTime,
    ["TimeOfDay"]      = game_Lighting.TimeOfDay
}

local __gameindex; __gameindex = hookmetamethod(game, "__index", newcclosure(LPH_NO_VIRTUALIZE(function(self, idx)
    if typeof(self) ~= "Instance" then return __gameindex(self, idx) end
    if (idx == "CanCollide" or idx == "Size" or idx == "Transparency") and self.Name == "Torso" and torso_spoofed_index[idx] then
        return torso_spoofed_index[idx]
    end
    if self == game_Lighting and lighting_oldvalues[idx] then
        return lighting_oldvalues[idx]
    end
    return __gameindex(self, idx)
end)))

local __gamenewindex; __gamenewindex = hookmetamethod(game, "__newindex", newcclosure(LPH_NO_VIRTUALIZE(function(self, idx, val)
    if typeof(self) ~= "Instance" then return __gamenewindex(self, idx, val) end
    if self == game_Lighting then
        lighting_oldvalues[idx] = val
    end
    return __gamenewindex(self, idx, val)
end)))

local __gamenamecall; __gamenamecall = hookmetamethod(game, "__namecall", newcclosure(LPH_NO_VIRTUALIZE(function(self, ...)
    if typeof(self) ~= "Instance" then return __gamenamecall(self, ...) end

    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and (self == trident.tcp or self == trident.udp) then
        if args[1] == 46 then
            if typeof(args[3]) == "Vector3" and modulecomm.antiaim.car then
                local aaset = modulecomm.antiaim
                local pitch, roll
                do
                    local tripmode = aaset.cartripmode
                    pitch = (
                        tripmode == "none" and args[4].X or
                        tripmode == "zero" and 0 or
                        tripmode == "random" and math.sin(tick() * aaset.cartriprandomspeed) * math.rad(70) or
                        tripmode == "pizdec" and math.sin(tick() * 360) * math.rad(80) or
                        args[4].Y or 0
                    )
                    roll = (
                        tripmode == "none" and args[4].Z or
                        tripmode == "zero" and 0 or
                        tripmode == "random" and math.cos(tick() * aaset.cartriprandomspeed) * math.rad(70) or
                        tripmode == "pizdec" and math.cos(tick() * 360) * math.rad(80) or
                        args[4].Z or 0
                    )
                end
                local yaw
                do
                    local yawset = aaset.antiaimyaw
                    yaw = (
                        (yawset == "static" or yawset == "jitter") and
                        (args[3].X + (math.rad(aaset.yawoffset) - (aaset.backwards and math.pi or 0)))
                    ) or 0
                    yaw = (
                        yawset == "none" and args[3].Y or
                        yawset == "spin" and (tick() % 1) * ((aaset.spinspeed / 360) * math.pi) or
                        yawset == "invisible" and math.huge or
                        yawset == "jitter" and math.rad((real_extended % 2 == 0 and 1 or -1) * (aaset.yawjittersize / 2)) or
                        yaw or 0
                    )
                end
                args[4] = _Vector3new(pitch, yaw, roll)
            end
        end

        if args[1] == 1 then
            real_extended = real_extended + 1

            if modulecomm.velobreak then
                if real_extended % 4 == 0 or real_extended % 4 == 2 then
                    args[5] = nil
                end
                args[2] = args[2] + (real_extended % 4 == 1 and Vector3.zero or Vector3.yAxis * modulecomm.velobreakstrenght)
                return __gamenamecall(self, unpack(args))
            end

            if modulecomm.invis then
                args[5] = nil
                return __gamenamecall(self, unpack(args))
            end
            if modulecomm.invis2 then
                args[5] = nil
                return __gamenamecall(self, unpack(args))
            end

            trident.lastpos = args[2] + _Vector3new(0, 3, 0)

            if typeof(args[3]) == "Vector3" and modulecomm.antiaim.antiaim then
                local aaset = modulecomm.antiaim
                if aaset.antiaimyaw == "invisible" then
                    args[3] = Vector3int16.new(0, math.huge, 0)
                    return __gamenamecall(self, unpack(args))
                elseif aaset.antiaimyaw == "invisible2" then
                    args[3] = Vector3int16.new(math.huge, 0, 0)
                    return __gamenamecall(self, unpack(args))
                end
                local pitch
                do
                    local pitchset = aaset.antiaimpitch
                    pitch = (
                        pitchset == "none" and args[3].Y or
                        pitchset == "down" and -1.5 or
                        pitchset == "up" and 1.5 or
                        pitchset == "jitter" and (real_extended % 2 == 0 and -1.5 or 1.5) * (aaset.pitchjittersize / 90) or
                        pitchset == "random" and math.sin(tick() * aaset.pitchrandomspeed) * math.rad(90) or
                        pitchset == "custom" and 1.5 * (aaset.pitchcustom / 90) or
                        args[3].Y or 0
                    )
                end
                local yaw
                do
                    local yawset = aaset.antiaimyaw
                    yaw = (
                        (yawset == "static" or yawset == "jitter") and
                        (args[3].X + math.rad(aaset.yawoffset + (aaset.backwards and 180 or 0)))
                    ) or 0
                    yaw = (
                        yawset == "none" and args[3].Y or
                        yawset == "spin" and ((args[3].X - (aaset.backwards and math.pi or 0) + math.rad(aaset.yawoffset)) + ((tick() * ((aaset.spinspeed / 60) * (2 * math.pi))) % (2 * math.pi))) or
                        yawset == "invisible" and math.huge or
                        yawset == "random" and math.sin(tick() * aaset.yawrandomspeed) * math.pi or
                        yawset == "jitter" and math.rad((real_extended % 2 == 0 and 1 or -1) * aaset.yawjittersize) or
                        yawset == "custom" and math.rad(aaset.yawcustom + 360 + args[3].X - (aaset.backwards and 180 or 0)) or
                        yaw or 0
                    )
                end
                args[3] = _Vector3new(pitch, yaw, 0)
            end
        end

        if args[1] == 1 and modulecomm.godmode then
            args[2] = Vector3.new(args[2].X, args[2].Y + modulecomm.godmode_strenght, args[2].Z)
        end
        if args[1] == 1 and modulecomm.forseminoclip then
            args[2] = Vector3.new(args[2].X, args[2].Y + 1.5, args[2].Z)
        end

        if args[1] == 2 and modulecomm.silentwalk then
            return __gamenamecall(self, 2, true)
        end

        if args[1] == 10 then
            if args[2] == "Hit" and type(args[5]) == "number" and type(args[6]) == "string" and typeof(args[7]) == "Vector3" then
                local entity = rawget(getupvalue(garbage.entitylist, 1), args[5])
                local entitymodel = entity and rawget(entity, "model")
                local entityhead = entitymodel and _FindFirstChild(entitymodel, "Head")
                if entityhead then
                    if modulecomm.forcehead then args[6] = "Head" end
                    local part = _FindFirstChild(entitymodel, args[6])
                    local originalpart = _FindFirstChild(trident.original_model, args[6])
                    if not (part and originalpart) then return __gamenamecall(self, unpack(args)) end

                    if modulecomm.hitboxes then
                        local primarypart = entitymodel.PrimaryPart
                        local partoffset = part.Position - primarypart.Position
                        args[7] = _Vector3new(
                            math.random(-originalpart.Size.X, originalpart.Size.X),
                            math.random(-originalpart.Size.Y, originalpart.Size.Y),
                            math.random(-originalpart.Size.Z, originalpart.Size.Z)
                        ) + partoffset
                    end
                end
            end
        end
        return __gamenamecall(self, unpack(args))
    end

    return __gamenamecall(self, ...)
end)))

ui.box.themeconfig:AddToggle('keybindshoww', {
    Text = 'show keybinds',
    Default = false,
    Callback = function(first)
        if cheat.Library and cheat.Library.KeybindFrame then
            cheat.Library.KeybindFrame.Visible = first
        end
    end
})

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "keybindshoww" })
ThemeManager:SetFolder("swimhub")
SaveManager:SetFolder("swimhub")

ThemeManager:ApplyToGroupbox(ui.box.themeconfig)
SaveManager:BuildConfigSection(ui.tabs.config)

cheat.EspLibrary.load()

pcall(function()
    SaveManager:LoadAutoloadConfig()
end)

pcall(function()
    local FIXED_FONT = Enum.Font.Gotham
    local function fixFontAnywhere(obj)
        if typeof(obj) ~= "Instance" then return end
        pcall(function() obj.Font = FIXED_FONT end)
        for _, child in pairs(obj:GetChildren()) do
            fixFontAnywhere(child)
        end
    end
    local guiroot = gethui and gethui() or game:GetService("CoreGui")
    fixFontAnywhere(guiroot)
end)

pcall(function()
    Library.ToggleKeybind = Options.MenuKeybind
end)



local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local Workspace         = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera


local Config = {
    enabled       = true,
    visible       = false,
    max_logs      = 8,
    lifetime      = 6.0,
    position      = Vector2.new(20, 300),
    width         = 380,
    line_height   = 22,
    font          = Drawing.Fonts.System,
    title         = "xvisad.xyz",
    title_color   = Color3.fromRGB(138, 128, 255),
    bg_color      = Color3.fromRGB(15, 15, 20),
    bg_alpha      = 0.35,
    accent_color  = Color3.fromRGB(138, 128, 255),
    kill_color    = Color3.fromRGB(255, 90, 90),
    hit_color     = Color3.fromRGB(255, 220, 90),
    text_color    = Color3.fromRGB(230, 230, 230),
    time_color    = Color3.fromRGB(140, 140, 150),
}

local Logs       = {}
local EntityList = nil
local KillCache  = {}

local function findEntityList()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and type(rawget(v, "GetEntityFromPart")) == "function" then
            return rawget(v, "GetEntityFromPart")
        end
    end
    return nil
end

task.spawn(function()
    repeat
        task.wait(0.5)
        EntityList = findEntityList()
    until EntityList
end)

local function getEntityByID(id)
    if not EntityList then return nil end
    local ok, list = pcall(function() return getupvalue(EntityList, 1) end)
    if not ok or not list then return nil end
    return list[id]
end

local function getEntityName(entity)
    if not entity then return "Unknown" end
    local name = rawget(entity, "Name")
    if name and name ~= "" then return name end
    local t = rawget(entity, "type")
    return t or "Unknown"
end

local Drawings = {
    bg           = Drawing.new("Square"),
    bg_outline   = Drawing.new("Square"),
    title        = Drawing.new("Text"),
    title_line   = Drawing.new("Line"),
    lines        = {},
}

local function setupDrawing()
    Drawings.bg.Filled       = true
    Drawings.bg.Color        = Config.bg_color
    Drawings.bg.Transparency = Config.bg_alpha
    Drawings.bg.ZIndex       = 90

    Drawings.bg_outline.Filled       = false
    Drawings.bg_outline.Thickness    = 1
    Drawings.bg_outline.Color        = Config.accent_color
    Drawings.bg_outline.Transparency = 0.7
    Drawings.bg_outline.ZIndex       = 91

    Drawings.title.Center       = false
    Drawings.title.Outline      = true
    Drawings.title.OutlineColor = Color3.new(0, 0, 0)
    Drawings.title.Font         = Config.font
    Drawings.title.Size         = 14
    Drawings.title.Color        = Config.title_color
    Drawings.title.Text         = Config.title
    Drawings.title.ZIndex       = 92

    Drawings.title_line.Thickness    = 1
    Drawings.title_line.Color        = Config.accent_color
    Drawings.title_line.Transparency = 0.4
    Drawings.title_line.ZIndex       = 92
end
setupDrawing()

local function ensureLine(idx)
    if Drawings.lines[idx] then return Drawings.lines[idx] end
    local t = Drawing.new("Text")
    t.Center       = false
    t.Outline      = true
    t.OutlineColor = Color3.new(0, 0, 0)
    t.Font         = Config.font
    t.Size         = 13
    t.ZIndex       = 93
    Drawings.lines[idx] = t
    return t
end

local function addLog(text, color)
    table.insert(Logs, 1, {
        text  = text,
        color = color or Config.text_color,
        born  = tick(),
    })
    while #Logs > Config.max_logs do
        table.remove(Logs)
    end
end


local function render()
    local now = tick()
    for i = #Logs, 1, -1 do
        if now - Logs[i].born > Config.lifetime then
            table.remove(Logs, i)
        end
    end

    local pos = Config.position
    local w   = Config.width

    if not Config.visible or not Config.enabled or #Logs == 0 then
        Drawings.bg.Visible         = false
        Drawings.bg_outline.Visible = false
        Drawings.title.Visible      = false
        Drawings.title_line.Visible = false
        for _, ln in pairs(Drawings.lines) do ln.Visible = false end
        return
    end

    local title_h = 26
    local total_h = title_h + (#Logs * Config.line_height) + 6

    Drawings.bg.Position         = pos
    Drawings.bg.Size             = Vector2.new(w, total_h)
    Drawings.bg.Visible          = true

    Drawings.bg_outline.Position = pos
    Drawings.bg_outline.Size     = Vector2.new(w, total_h)
    Drawings.bg_outline.Visible  = true

    Drawings.title.Position = pos + Vector2.new(10, 6)
    Drawings.title.Text     = Config.title .. "  " .. os.date("%H:%M:%S")
    Drawings.title.Visible  = true

    Drawings.title_line.From    = pos + Vector2.new(6, title_h - 2)
    Drawings.title_line.To      = pos + Vector2.new(w - 6, title_h - 2)
    Drawings.title_line.Visible = true

    for i = 1, Config.max_logs do
        local t   = ensureLine(i)
        local log = Logs[i]
        if log then
            local age   = now - log.born
            local fade  = math.clamp(1 - (age / Config.lifetime), 0, 1)
            local alpha = math.min(age / 0.2, 1) * fade
            if alpha <= 0.01 then
                t.Visible = false
            else
                t.Text         = string.format("[%s] %s", os.date("%H:%M:%S", math.floor(log.born)), log.text)
                t.Position     = pos + Vector2.new(10, title_h + ((i - 1) * Config.line_height) + 2)
                t.Color        = log.color
                t.Transparency = alpha
                t.Visible      = true
            end
        else
            t.Visible = false
        end
    end
end

RunService.RenderStepped:Connect(function() pcall(render) end)


UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F9 then
        Config.visible = not Config.visible
    end
end)


local originalNamecall
originalNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args   = {...}

    if method == "FireServer" and (self == LocalPlayer.TCP or self == LocalPlayer.UDP) then
        if args[1] == 10 and args[2] == "Hit" then
            local entity_id = args[5]
            local part_name = args[6]

            if type(entity_id) == "number" then
                local entity = getEntityByID(entity_id)
                local name   = getEntityName(entity)
                local is_head = part_name == "Head"

                local tag = is_head and "HEADSHOT" or "HIT"
                addLog(string.format("> %s %s", tag, name), Config.hit_color)

                task.spawn(function()
                    if KillCache[entity_id] then return end
                    KillCache[entity_id] = true
                    task.wait(0.3)
                    local still = getEntityByID(entity_id)
                    if still and rawget(still, "sleeping") ~= true then
                        task.wait(0.4)
                        local still2 = getEntityByID(entity_id)
                        if still2 and rawget(still2, "sleeping") ~= true then
                            KillCache[entity_id] = nil
                            return
                        end
                    end

                    addLog(string.format("+ Killed %s%s", name, is_head and " (HS)" or ""), Config.kill_color)
                    KillCache[entity_id] = nil
                end)
            end
        end
    end

    return originalNamecall(self, ...)
end)
