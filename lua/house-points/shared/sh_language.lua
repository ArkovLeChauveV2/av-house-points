Arkonfig.PointSystem.Languages = {}

Arkonfig.PointSystem.Languages["en"] = {
    ["ent_hourglass"] = "Points hourglass",
    ["not_a_teacher"] = "You are not a teacher",
    ["added_points"] = "You added %d points for %s.",
    ["removed_points"] = "You removed %d points for %s.",
    ["cannot_add_points"] = "You cannot add points.",
}

Arkonfig.PointSystem.Languages["fr"] = {
    ["ent_hourglass"] = "Sabliers de points",
    ["not_a_teacher"] = "Vous n'êtes pas un professeur.",
    ["added_points"] = "Vous avez ajouté %d points pour %s.",
    ["removed_points"] = "Vous avez retiré %d points pour %s.",
    ["cannot_add_points"] = "Ajout de points impossible.",
}

local sSelectedLang = "en"

function Arkonfig.PointSystem:GetPhrase(sPhrase)
    return self.Languages[sSelectedLang][sPhrase] or "Invalid phrase"
end

local function loadLang()
    if !file.Exists("arkov/pointsys/lang.txt", "DATA") then
        file.Write("arkov/pointsys/lang.txt", sSelectedLang)
        return
    end

    sSelectedLang = file.Read("arkov/pointsys/lang.txt", "DATA")

    MsgC(Color(0, 255, 0), "[House Points] Language loaded successfully\n")
end

hook.Add("InitPostEntity", "HOUSEPOINTS::LoadLang", loadLang)
hook.Add("PostCleanupMap", "HOUSEPOINTS::LoadLangAfterCleanup", loadLang)

function Arkonfig.PointSystem:SetLang(sLang)
    sSelectedLang = sLang
    file.Write("arkov/pointsys/lang.txt", sLang)
end