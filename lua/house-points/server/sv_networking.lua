util.AddNetworkString("HOUSEPOINTS::ChangePoints")
util.AddNetworkString("HOUSEPOINTS::OpenBoard")

net.Receive("HOUSEPOINTS::ChangePoints", function(_, pPly)
    local nHouse = net.ReadUInt(2)
    local nPoints = net.ReadInt(13)

    if (!Arkonfig.PointSystem:IsTeacher(pPly)) then
        DarkRP.notify(pPly, NOTIFY_ERROR, 3, Arkonfig.PointSystem:GetPhrase("not_a_teacher"))
        return
    end

    local sChangePointNotification = string.format(nPoints > 0 and Arkonfig.PointSystem:GetPhrase("added_points") or Arkonfig.PointSystem:GetPhrase("removed_points"), nPoints, Arkonfig.PointSystem.Houses:ToString(nHouse))

    local bResult = Arkonfig.PointSystem:AddPoints(pPly, nHouse, nPoints)
    DarkRP.notify(pPly, bResult and NOTIFY_GENERIC or NOTIFY_ERROR, 3, bResult and sChangePointNotification or Arkonfig.PointSystem:GetPhrase("cannot_add_points"))
end)