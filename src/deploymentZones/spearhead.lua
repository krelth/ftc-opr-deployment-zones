function spearhead(bw, bh, bx, bz, _)
    local deploymentZones = {}
    local cw = bw/2 - 12
    local ch = bh/2
    local c1x = bx - (12 + cw/2)
    local c1z = bz - bh/4
    local r1x = 180
    local r1z = 180
    local r1y = 0
    deploymentZones[1] = {
        scale = { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color = 1,
        shape = "TRIANGLE",
        rotation= {  r1x, r1y, r1z }
    }
    local c2x = c1x
    local c2z = bz + bh/4
    local r2x = 180
    local r2y = 180
    local r2z = 0
    deploymentZones[2] = {
        scale = { cw, 0.01, ch },
        position = { c2x, 0, c2z },
        color = 1,
        shape = "TRIANGLE",
        rotation = { r2x, r2y, r2z }
    }
    local c3x = bx + (12 + cw/2)
    local c3z = bz - bh/4
    local r3x = 0
    local r3y = 180
    local r3z = 180
    deploymentZones[3] = {
        scale = { cw, 0.01, ch },
        position = { c3x, 0, c3z },
        color = 2,
        shape = "TRIANGLE",
        rotation = { r3x, r3y, r3z }
    }
    local c4x = c3x
    local c4z = bz + bh/4
    local r4x = 0
    local r4y = 0
    local r4z = 0
    deploymentZones[4] = {
        scale = { cw, 0.01, ch },
        position = { c4x, 0, c4z },
        color= 2,
        shape= "TRIANGLE",
        rotation={ r4x, r4y, r4z }
    }
    return deploymentZones
end
