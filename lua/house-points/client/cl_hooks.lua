hook.Add("PreDrawHalos", "AddPropHalos", function()
	local eEnt = LocalPlayer():GetEyeTrace().Entity
	if IsValid(eEnt) and eEnt:GetClass() != "ent_points_hourglass" then return end

    if (eEnt:GetPos():DistToSqr(LocalPlayer():GetPos()) > 12500) then return end

	halo.Add({eEnt}, color_white, 2, 2, 1)
end)