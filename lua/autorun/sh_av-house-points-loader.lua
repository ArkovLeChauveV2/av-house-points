Arkonfig = Arkonfig || {}
Arkonfig.PointSystem = {}

if SERVER then
    include("house-points/shared/sh_house_enum.lua")
    include("house-points/shared/sh_language.lua")
    
    include("house-points/server/sv_teachers.lua")
    include("house-points/server/sv_points.lua")

    include("house-points/server/sv_networking.lua")
    include("house-points/server/sv_hooks.lua")

    AddCSLuaFile("house-points/shared/sh_house_enum.lua")
    AddCSLuaFile("house-points/shared/sh_language.lua")

    AddCSLuaFile("house-points/client/cl_fonts.lua")
    AddCSLuaFile("house-points/client/cl_hooks.lua")

    AddCSLuaFile("house-points/vgui/cl_admin.lua")
    AddCSLuaFile("house-points/vgui/cl_addpoints.lua")
else
    include("house-points/shared/sh_house_enum.lua")
    include("house-points/shared/sh_language.lua")

    include("house-points/client/cl_fonts.lua")
    include("house-points/client/cl_hooks.lua")

    include("house-points/vgui/cl_admin.lua")
    include("house-points/vgui/cl_addpoints.lua")
end