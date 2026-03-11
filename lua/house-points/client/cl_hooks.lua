local start = 0

net.Receive("HOUSEPOINTS::OpenBoard", function()
    local bEnter = net.ReadBool()
    
    if bEnter then
        start = SysTime()
        LocalPlayer().eBoard = net.ReadEntity()
        gui.EnableScreenClicker(true)
        return
    end
    
    LocalPlayer().eBoard = NULL
    gui.EnableScreenClicker(false)
    start = 0
end)

hook.Add("CalcView", "HOUSEPOINTS::OnUseHourglass", function(pPly, pos, angles, fov)
	if !IsValid(pPly.eBoard) then
        return
    end

	local vEntPos = pPly.eBoard:GetPos() + pPly.eBoard:GetForward() * 100 + pPly.eBoard:GetUp() * 5 - pPly.eBoard:GetRight() * 10

	local aAng = pPly.eBoard:GetAngles()
	aAng:RotateAroundAxis(aAng:Up(), 150)

    local ratio = math.Clamp((SysTime() - start) / 0.2, 0, 1)

    local vLerped = LerpVector(ratio, pos, vEntPos)
    local aLerped = LerpAngle(ratio, angles, aAng)

    local view = {
		origin = vLerped,
		angles = aLerped,
		fov = fov,
		drawviewer = true
	}

	return view
end)

hook.Add("PreDrawHalos", "AddPropHalos", function()
	local eEnt = LocalPlayer():GetEyeTrace().Entity
	if IsValid(eEnt) and eEnt:GetClass() != "ent_points_hourglass" then return end

    if (eEnt:GetPos():DistToSqr(LocalPlayer():GetPos()) > 12500) then return end

	halo.Add({eEnt}, color_white, 2, 2, 1)
end)