net.Receive("HOUSEPOINTS::OpenBoard", function()
    local eBoard = net.ReadEntity()
    LocalPlayer().eBoard = !IsValid(LocalPlayer().eBoard) and eBoard or nil
end)