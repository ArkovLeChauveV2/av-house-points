local nHouseEnums = Arkonfig.PointSystem.Houses

local tPoints = {
    [nHouseEnums.POUFSOUFFLE] = "HOUSE::Pouf",
    [nHouseEnums.GRYFFONDOR] = "HOUSE::Gryf",
    [nHouseEnums.SERDAIGLE] = "HOUSE::Serd",
    [nHouseEnums.SERPENTARD] = "HOUSE::Serp"
}

local function loadPoints()
    if !file.Exists("arkov/pointsys/points.txt", "DATA") then
        file.Write("arkov/pointsys/points.txt", "[]")
        MsgC(Color(0, 255, 0), "[House Points] Points loaded successfully\n")
        return
    end

    local sPoints = file.Read("arkov/pointsys/points.txt", "DATA")
    local tParsedPoints = util.JSONToTable(sPoints)

    if !tParsedPoints then return end

    SetGlobal2Int("HOUSE::Serp", tParsedPoints.serpentard)
	SetGlobal2Int("HOUSE::Serd", tParsedPoints.serdaigle)
	SetGlobal2Int("HOUSE::Gryf", tParsedPoints.gryffondor)
	SetGlobal2Int("HOUSE::Pouf", tParsedPoints.poufsouffle)

    MsgC(Color(0, 255, 0), "[House Points] Points loaded successfully\n")
end

hook.Add("InitPostEntity", "HOUSEPOINTS::LoadPoints", loadPoints)
hook.Add("PostCleanupMap", "HOUSEPOINTS::LoadPointsAfterCleanup", loadPoints)

local function savePoints()
    file.Write("arkov/pointsys/points.txt", util.TableToJSON({
        [nHouseEnums.POUFSOUFFLE] = GetGlobal2Int("HOUSE::Pouf", 0),
        [nHouseEnums.GRYFFONDOR] = GetGlobal2Int("HOUSE::Gryf", 0),
        [nHouseEnums.SERDAIGLE] = GetGlobal2Int("HOUSE::Serd", 0),
        [nHouseEnums.SERPENTARD] = GetGlobal2Int("HOUSE::Serp", 0)
    }))
end

function Arkonfig.PointSystem:AddPoints(pPly, nHouse, nPoints)
    assert(nHouse >= 0 and nHouse <= 3, "Arkonfig.PointSystem:AddPoints(): Invalid house", false)
    assert(Arkonfig.PointSystem:IsTeacher(pPly), string.format("Arkonfig.PointSystem:AddPoints(): %s is not a teacher", pPly:Nick()), false)

    local nActualPoints = GetGlobal2Int(tPoints[nHouse], 0)

    SetGlobal2Int(tPoints[nHouse], nActualPoints + nPoints)
    savePoints()

    return true
end

function Arkonfig.PointSystem:SetPoints(pPly, nHouse, nPoints)
    assert(nHouse >= 0 and nHouse <= 3, "Arkonfig.PointSystem:SetPoints(): Invalid house", false)
    assert(Arkonfig.PointSystem:IsTeacher(pPly), string.format("Arkonfig.PointSystem:SetPoints(): %s is not a teacher", pPly:Nick()), false)

    SetGlobal2Int(tPoints[nHouse], nPoints)
    savePoints()

    return true
end

function Arkonfig.PointSystem:ResetPoints(pPly)
    assert(pPly:IsSuperAdmin(), string.format("Arkonfig.PointSystem:ResetPoints(): %s is not superadmin", pPly:Nick()), false)

    SetGlobal2Int("HOUSE::Serp", 0)
	SetGlobal2Int("HOUSE::Serd", 0)
	SetGlobal2Int("HOUSE::Gryf", 0)
	SetGlobal2Int("HOUSE::Pouf", 0)

    savePoints()
end