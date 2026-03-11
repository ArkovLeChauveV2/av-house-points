local tTeachersWhitelist = {}

local function loadTeachers()
    if !file.Exists("arkov/pointsys/staffs.txt", "DATA") then
        file.Write("arkov/pointsys/staffs.txt", "[]")
        MsgC(Color(0, 255, 0), "[House Points] Teachers loaded successfully\n")
        return
    end

    local sTeachers = file.Read("arkov/pointsys/staffs.txt", "DATA")
    local tTeachersWhitelist = util.JSONToTable(sTeachers) or tTeachersWhitelist

    MsgC(Color(0, 255, 0), "[House Points] Teachers loaded successfully\n")
end

hook.Add("InitPostEntity", "HOUSEPOINTS::LoadTeachers", loadTeachers)
hook.Add("PostCleanupMap", "HOUSEPOINTS::LoadTeachersAfterCleanup", loadTeachers)

local function saveTeachers()
    file.Write("arkov/pointsys/staffs.txt", util.TableToJSON(tTeachersWhitelist))
end

function Arkonfig.PointSystem:AddJobToTeachers(pPly, nTeam)
    assert(pPly:IsSuperAdmin(), string.format("Arkonfig.PointSystem:AddJobToTeachers(): %s is not a superadmin", pPly:Nick()), false)

    tTeachersWhitelist[nTeam] = true
    saveTeachers()

    return true
end

function Arkonfig.PointSystem:RemoveJobToTeachers(pPly, nTeam)
    assert(pPly:IsSuperAdmin(), string.format("Arkonfig.PointSystem:RemoveJobToTeachers(): %s is not a superadmin", pPly:Nick()), false)

    tTeachersWhitelist[nTeam] = nil
    saveTeachers()

    return true
end

function Arkonfig.PointSystem:IsTeacher(pPly)
    return tTeachersWhitelist[pPly:Team()]
end