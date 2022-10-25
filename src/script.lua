local deploymentZoneTag = "DZ_DEPLOYMENT_ZONE"
local color1 = { r = 0, g = 0, b = 1, a = 0.25 }
local color2 = { r = 1, g = 0, b = 0, a = 0.25 }
local cubeUrl = "http://cloud-3.steamusercontent.com/ugc/1852693384849628572/894F8B1FBBC6A865898917BB469F9C73C72844EF/"
local triangleUrl = "http://cloud-3.steamusercontent.com/ugc/1933758449803795830/703CFBA3D54F91BF69CF6EACFC5E72140548C61E/"

local state = {
    boardSizeIdx = 1,
    gameTypeIdx = 1,
    rotation = 1,
    selected = nil,
}

local boardSizes = {
    { name = "6'x4'", 72, 48 },
    { name = "2'x2'", 24, 24 },
    { name = "3'x2'", 36, 24 },
    { name = "3'x3'", 36, 36 },
    { name = "4'x4'", 48, 48 },
}

local rotations = {
    Ambush = 2,
    Cornered = 4,
    FlankAssault = 2,
    FlankAssaultGff = 2,
    KitchenSideBattle = 2,
    KitchenFlankAssault = 2,
    SideBattle = 2,
}

local deploymentZoneGroups = {
    {
        name = "Regular",
        deploymentZones = { "FrontLine", "LongHaul", "SideBattle", "Ambush", "Spearhead", "FlankAssault", },
    },
    {
        name = "Skirmish",
        deploymentZones = { "FrontLine", "SideBattle", "Ambush", "SpearheadGff", "FlankAssaultGff", "Cornered", },
    },
    {
        name = "Kitchen Table",
        deploymentZones = { "KitchenFrontline", "KitchenSideBattle", "KitchenFlankAssault", },
    },
    {
        name = "Any",
        deploymentZones = {},
    }
}
--TODO: refactor
local allDeploymentZones = {}
local acc = {}
for i=1, #deploymentZoneGroups-1 do
    for _, key in pairs(deploymentZoneGroups[i].deploymentZones) do
        acc[key] = true
    end
end
for key, _ in pairs(acc) do
    allDeploymentZones[#allDeploymentZones+1] = key
end
deploymentZoneGroups[#deploymentZoneGroups].deploymentZones = allDeploymentZones

-- ###############################################################################################

function clearClicked(_, _, _)
    state.selected = nil
    clearDeploymentZones()
end

function applyClicked(_, _, id)
    state.selected = id
    state.rotation = 1
    updateRotateBtnUi()
    applyDeploymentZones(state.selected, state.rotation)
end

function randomClicked(_, _, _)
    local availableOptions = deploymentZoneGroups[state.gameTypeIdx].deploymentZones
    local selection = availableOptions[math.random(#availableOptions)]
    applyClicked(nil, nil, selection)
end

function boardSizeClicked(_, _, _)
    state.boardSizeIdx = state.boardSizeIdx % #boardSizes + 1
    updateBoardSizeBtnUi()
end

function rotateClicked(_, _, _)
    if state.selected == nil then
        return
    end
    local possibleRotations = rotations[state.selected]
    if possibleRotations == nil then
        return
    end
    state.rotation =  state.rotation % possibleRotations + 1
    applyDeploymentZones(state.selected, state.rotation)
end

function gameTypeClicked(_, _, _)
    state.gameTypeIdx = state.gameTypeIdx % #deploymentZoneGroups + 1
    updateGameTypeUi()
end

function onSave()
    return JSON.encode(state)
end

function onLoad(script_state)
    local decoded = JSON.decode(script_state)
    if decoded ~= nil then
        for k,v in pairs(decoded) do
            state[k] = v
        end
    end
    updateBoardSizeBtnUi()
    updateGameTypeUi()
    updateGameTypeUi()
    return script_state
end

-- ###############################################################################################

function updateRotateBtnUi()
    self.UI.setAttribute("rotateBtn", "interactable", rotations[state.selected] ~= nil)
end

function updateBoardSizeBtnUi()
    self.UI.setAttribute("boardSizeBtn", "text", "Board size:\n" .. boardSizes[state.boardSizeIdx].name)
end

function updateGameTypeUi()
    self.UI.setAttribute("gameTypeBtn", "text", "Game type:\n" .. deploymentZoneGroups[state.gameTypeIdx].name)
    -- TODO: calculate based on number of elements
    local cellHeight = 100
    if state.gameTypeIdx == 3 then
        cellHeight = 200
    elseif state.gameTypeIdx == 4 then
        cellHeight = 50
    end
    self.UI.setAttribute("grid", "cellSize", "252 ".. cellHeight)
    local toEnable = toSet(deploymentZoneGroups[state.gameTypeIdx].deploymentZones)
    for _, key in ipairs(allDeploymentZones) do
        local enabled = toEnable[key] ~= nil
        self.UI.setAttribute(key, "active", enabled)
    end
end

function clearDeploymentZones()
    for _, object in pairs(getObjectsWithTag(deploymentZoneTag)) do
        destroyObject(object)
    end
end

function applyDeploymentZones(key, rotation)
    clearDeploymentZones()
    local bw = boardSizes[state.boardSizeIdx][1]
    local bh = boardSizes[state.boardSizeIdx][2]
    local bx = 0
    local bz = 0
    local dzy = findTopOfTheBoard()
    local spawnFunction = ({
        Ambush = ambush,
        Cornered = cornered,
        FlankAssault = flankAssault,
        FlankAssaultGff = flankAssaultGff,
        FrontLine = frontLine,
        KitchenFlankAssault = kitchenFlankAssault,
        KitchenFrontline = kitchenFrontline,
        KitchenSideBattle = kitchenSideBattle,
        LongHaul = longHaul,
        SideBattle = sideBattle,
        Spearhead = spearhead,
        SpearheadGff = spearheadGff,
    })[key]
    local deploymentZones = spawnFunction(bw, bh, bx, bz, rotation)
    for _, deploymentZone in pairs(deploymentZones) do
        local rotation = nil
        if deploymentZone.rotation ~= nil then
            rotation = Vector(deploymentZone.rotation[1], deploymentZone.rotation[2], deploymentZone.rotation[3])
        end
        local o = spawnObject({
            type = "Custom_Model",
            scale = deploymentZone.scale,
            position = Vector(deploymentZone.position[1], dzy, deploymentZone.position[3]),
            rotation = rotation,
        })
        o.setCustomObject({
            mesh = ({ SQUARE = cubeUrl, TRIANGLE = triangleUrl })[deploymentZone.shape],
            type = 4,
            material = 3,
            cast_shadows = false,
        })
        o.setColorTint(({ color1, color2 })[deploymentZone.color])
        o.setLock(true)
        o.addTag(deploymentZoneTag)
        o.reload()
    end
end

function findTopOfTheBoard()
    local board = getObjectFromGUID("4ee1f2")
    if board ~= nil then
        local bounds = board.getBounds()
        return bounds.offset.y - board.getPosition()[2] - bounds.center.y
    end
    return 0.9
end

function addSets(set1, set2)
    local acc = {}
    for key, _ in pairs(set1) do
        acc[key] = true
    end
    for key, _ in pairs(set2) do
        acc[key] = true
    end
    return acc
end

function toSet(list)
    local acc = {}
    for _, value in ipairs(list) do
            acc[value] = true
    end
    return acc
end

{{> ambush }}
{{> cornered }}
{{> flankAssault }}
{{> flankAssaultGff }}
{{> frontLine }}
{{> kitchenFlankAssault }}
{{> kitchenFrontline }}
{{> kitchenSideBattle }}
{{> longHaul }}
{{> sideBattle }}
{{> spearhead }}
{{> spearheadGff }}
