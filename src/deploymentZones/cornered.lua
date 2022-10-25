function cornered(bw, bh, bx, bz, rotation)
    if rotation == 1 then
        return cornered1(bw, bh, bx, bz, false)
    elseif rotation == 2 then
            return cornered1(bw, bh, bx, bz, true)
    elseif rotation == 3 then
        return cornered2(bw, bh, bx, bz, true)
    elseif rotation == 4 then
        return cornered2(bw, bh, bx, bz, false)
    end
end

function cornered1(bw, bh, bx, bz, mirror)
    local deploymentZones = {}
    local mirrorAdj = 1
    if mirror then
        mirrorAdj = -1
    end

    local cw = (bw - 24) / 2
    local ch = (bh - 24) / 2
    local c1x = bx + mirrorAdj * (12 + cw * 0.5)
    local c1z = bz + 12 + ch/2
    deploymentZones[1] = {
        scale = { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color= 2,
        shape= "SQUARE",
    }
    local c2w = bw
    local c2h = bh / 2 - 12
    local c2x = bx
    local c2z = bz - 12 - c2h /2
    deploymentZones[2] = {
        scale = { c2w, 0.01, c2h },
        position = { c2x, 0, c2z },
        color= 1,
        shape= "SQUARE",
    }
    local c3w = bw/2 - 12
    local c3h = bh - ch
    local c3x = bx -  mirrorAdj * (12 + c3w/2)
    local c3z = bz + ch/2
    deploymentZones[3] = {
        scale = { c3w, 0.01, c3h },
        position = { c3x, 0, c3z },
        color= 1,
        shape= "SQUARE",
    }
    return deploymentZones
end

function cornered2(bw, bh, bx, bz, mirror)
    local deploymentZones = {}
    local mirrorAdj = 1
    if mirror then
        mirrorAdj = -1
    end
    local cw = (bw - 24) / 2
    local ch = (bh - 24) / 2
    local c1x = bx + mirrorAdj * (12 + cw * 0.5)
    local c1z = bz - 12 - ch/2
    deploymentZones[1] = {
        scale = Vector(cw, 0.01, ch),
        position = Vector(c1x, 0, c1z),
        color= 1,
        shape= "SQUARE",
    }
    local c2w = bw
    local c2h = bh / 2 - 12
    local c2x = bx
    local c2z = bz + 12 + c2h /2
    deploymentZones[2] = {
        scale = { c2w, 0.01, c2h },
        position = { c2x, 0, c2z },
        color= 2,
        shape= "SQUARE",
    }
    local c3w = bw/2 - 12
    local c3h = bh - ch
    local c3x = bx -  mirrorAdj * (12 + c3w/2)
    local c3z = bz - ch/2
    deploymentZones[3] = {
        scale = { c3w, 0.01, c3h },
        position = { c3x, 0, c3z },
        color= 2,
        shape= "SQUARE",
    }
    return deploymentZones
end
