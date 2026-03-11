hook.Add("PlayerDisconnected", "HOUSEPOINTS::RemoveFromHourglass", function(pPly)
    for _, v in pairs(ents.FindByClass("ent_points_hourglass")) do
        if !v.tUsingPlayers[pPly:EntIndex()] then continue end
        v.tUsingPlayers[pPly:EntIndex()] = nil
    end
end)