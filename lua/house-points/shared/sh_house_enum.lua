Arkonfig.PointSystem.Houses = {}

Arkonfig.PointSystem.Houses.POUFSOUFFLE = 0
Arkonfig.PointSystem.Houses.GRYFFONDOR = 1
Arkonfig.PointSystem.Houses.SERDAIGLE = 2
Arkonfig.PointSystem.Houses.SERPENTARD = 3

local tHousesConvert = {
    [Arkonfig.PointSystem.Houses.POUFSOUFFLE] = "Poufsouffle",
    [Arkonfig.PointSystem.Houses.GRYFFONDOR] = "Gryffondor",
    [Arkonfig.PointSystem.Houses.SERDAIGLE] = "Serdaigle",
    [Arkonfig.PointSystem.Houses.SERPENTARD] = "Serpentard"
}

function Arkonfig.PointSystem.Houses:ToString(nHouse)
    return tHousesConvert[nHouse] or "Invalid house"
end