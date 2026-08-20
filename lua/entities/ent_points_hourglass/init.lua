AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/sablier/sablier.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysWake()
end

function ENT:Use(pActivator)
	if (pActivator.nHourglassCooldown or 0) > CurTime() then return end

	net.Start("HOUSEPOINTS::OpenBoard")
		net.WriteEntity(self)
	net.Send(pActivator)

	pActivator.nHourglassCooldown = CurTime() + 1
end