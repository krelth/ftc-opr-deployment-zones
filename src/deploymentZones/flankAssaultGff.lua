function flankAssaultGff(bw, bh, bx, bz, mirror)
    local deploymentZones = {}
    local mirrorAdj = 1
    if mirror == 2 then
        mirrorAdj = -1
    end
    local cw = 24
    local ch = (bh - 24) * 0.5
    local c1x = bx + mirrorAdj * (bw/2 - 24 + cw/2)
    local c1z = bz - 12 - ch * 0.5
    deploymentZones[1] = {
        scale = { cw, 0.01, ch },
        position = { c1x, 0, c1z },
        color= 1,
        shape= "SQUARE",
    }
    local c2x = bx - mirrorAdj * (bw/2 - 24 + cw/2)
    local c2z = bz + 12 + ch * 0.5
    deploymentZones[2] = {
        scale = { cw, 0.01, ch },
        position = { c2x, 0, c2z },
        color= 2,
        shape= "SQUARE",
    }
    return deploymentZones
end
