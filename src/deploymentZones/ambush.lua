
function ambush(bw, bh, bx, bz, mirror)
    local deploymentZones = {}
    local mirrorAdj = 1
    if mirror == 2 then
        mirrorAdj = -1
    end
    local dz = 30 / math.sqrt(1 + bw * bw / (bh * bh))
    local dx = bw/bh * dz

    local d = math.sqrt(bw * bw + bh * bh)
    local d1 = d/2 - 30
    local cw = d1 / (d/2) * bw
    local ch = d1 / (d/2) * bh
    local c1x = bx - mirrorAdj * dx
    local c1z = bz - dz
    local r1z = 180
    if mirror == 2 then
        r1z = 0
    end
    deploymentZones[1] = {
        scale = { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color = 1,
        shape = "TRIANGLE",
        rotation = { 0, 0, r1z }
    }
    local c2x = bx + mirrorAdj * dx
    local c2z = bz + dz
    local r2z = 180
    if mirror == 2 then
        r2z = 0
    end
    deploymentZones[2] = {
        scale = { cw, 0.01, ch },
        position = { c2x, 0, c2z },
        color = 1,
        shape = "TRIANGLE",
        rotation = { 0, 180, r2z }
    }

    local t1 = bh / bw * 6
    local c3x = 0
    local c3z = 0
    local c3w = d
    local c3h = 12
    local r3y = math.atan2(bh, bw) * 180 / math.pi
    if mirror == 2 then
        r3y = -r3y
    end
    deploymentZones[3] = {
        scale = { c3w, 0.01, c3h },
        position = { c3x, 0, c3z },
        color = 2,
        shape = "SQUARE",
        rotation = { 0, r3y, 0 }
    }
    return deploymentZones
end
