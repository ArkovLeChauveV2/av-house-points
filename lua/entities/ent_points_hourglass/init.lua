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

	self.tUsingPlayers = {}
end

function ENT:Use(pActivator)
	self:ToggleHourglass(pActivator)
end

function ENT:ToggleHourglass(pPly)
	if (pPly.nHourglassCooldown or 0) > CurTime() then return end

	local bEnter = !self.tUsingPlayers[pPly:UserID()]

	net.Start("HOUSEPOINTS::OpenBoard")
		net.WriteBool(bEnter)
		net.WriteEntity(self)
	net.Send(pPly)

	self.tUsingPlayers[pPly:UserID()] = bEnter and true or nil
	pPly.eHourglass = bEnter and self or nil
	pPly:Freeze(bEnter)
	
	pPly.nHourglassCooldown = CurTime() + 1
end

function ENT:OnRemove()
	for k, _ in pairs(self.tUsingPlayers) do
		local pPlayer = Player(k)
		if !IsValid(pPlayer) then continue end

		self:ToggleHourglass(pPlayer)
	end
end

hook.Add("PlayerButtonDown", "HOUSEPOINTS::RemoveView", function(pPly, nKey)
	if (nKey != KEY_E) then return end
	if !IsValid(pPly.eHourglass) then return end
	
	pPly.eHourglass:ToggleHourglass(pPly)
end)