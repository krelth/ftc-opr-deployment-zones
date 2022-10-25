function frontLine(bw, bh, bx, bz, _)
    local deploymentZones = {}
    local cw = bw
    local ch = (bh - 24) / 2
    local c1x = bx
    local c1z = bz - 12 - ch / 2
    deploymentZones[1] = {
        scale = { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color= 1,
        shape= "SQUARE"
    }
    local c2x = bx
    local c2z = bz + 12 + ch / 2
    deploymentZones[2] = {
        scale = { cw, 0.01, ch },
        position = { c2x, 0, c2z },
        color= 2,
        shape= "SQUARE",
    }
    return deploymentZones
end
