
function longHaul(bw, bh, bx, bz, _)
    local deploymentZones = {}
    local cw = (bw - 24) / 2
    local ch = bh
    local c1x = bx - 12 - cw / 2
    local c1z = bz
    deploymentZones[1] = {
        scale =  { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color= 1,
        shape= "SQUARE",
    }
    local c2x = bx + 12 + cw / 2
    local c2z = bz
    deploymentZones[2] = {
        scale = { cw, 0.01, ch },
        position = { c2x, 0, c2z },
        color= 2,
        shape= "SQUARE",
    }
    return deploymentZones
end
