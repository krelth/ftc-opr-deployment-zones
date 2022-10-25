function kitchenSideBattle(bw, bh, bx, bz, mirror)
    local deploymentZones = {}
    local mirrorAdj = 1
    if mirror == 2 then
        mirrorAdj = -1
    end
    local dz = 0
    local dx = 0
    local d = math.sqrt(bw * bw + bh * bh)
    local d1 = d/2 - 0
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
        color= 1,
        shape= "TRIANGLE",
        rotation={ 0, 0, r1z }
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
        color= 2,
        shape= "TRIANGLE",
        rotation={ 0, 180, r2z },
    }
    return deploymentZones
end
