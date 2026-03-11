include("shared.lua")

local color_gryffondor, color_poufsouffle, color_serpentard, color_serdaigle = Color(134, 0, 0), Color(206, 164, 26), Color(0, 94, 28), Color(11, 31, 117)

local color_back = Color(10, 10, 10, 200)

local MAX_BAR_HEIGHT = 1000
local BAR_WIDTH = 200

local function drawHouseBar(xPos, nPoints, cColor)
	draw.RoundedBox(0, xPos, 0, BAR_WIDTH, MAX_BAR_HEIGHT, color_back)
	draw.RoundedBox(0, xPos, MAX_BAR_HEIGHT - nPoints, BAR_WIDTH, nPoints, cColor)
	draw.RoundedBox(0, xPos, MAX_BAR_HEIGHT - nPoints, BAR_WIDTH, 1, color_white)
end

local REGISTRY_GUI = vgui.Create("HOUSEPOINTS::Registry")
REGISTRY_GUI:SetPaintedManually(true)

local function drawAddPoints()
    if !IsValid(LocalPlayer().eBoard) then return end
	REGISTRY_GUI:PaintManual()
end

function ENT:Draw()
	self:DrawModel()

	local aAng = self:GetAngles()
	local vPos = self:GetPos() + aAng:Right() * 28 + aAng:Up() * 20

	aAng:RotateAroundAxis(aAng:Up(), 90)
	aAng:RotateAroundAxis(aAng:Forward(), 90)

	local nSerpentardPoints = GetGlobal2Int("HOUSE::Serp", 0)
	local nSerdaiglePoints = GetGlobal2Int("HOUSE::Serd", 0)
	local nGryffPoints = GetGlobal2Int("HOUSE::Gryf", 0)
	local nPoufPoints = GetGlobal2Int("HOUSE::Pouf", 0)

	cam.Start3D2D(vPos, aAng, 0.05)
		drawHouseBar(0, nSerpentardPoints, color_serpentard)
		drawHouseBar(310, nSerdaiglePoints, color_serdaigle)
		drawHouseBar(610, nGryffPoints, color_gryffondor)
		drawHouseBar(915, nPoufPoints, color_poufsouffle)

		draw.SimpleText(nSerpentardPoints, "HOUSEPOINTS::Font1", 100, 10, color_white, TEXT_ALIGN_CENTER)
		draw.SimpleText(nSerdaiglePoints, "HOUSEPOINTS::Font1", 410, 10, color_white, TEXT_ALIGN_CENTER)
		draw.SimpleText(nGryffPoints, "HOUSEPOINTS::Font1", 710, 10, color_white, TEXT_ALIGN_CENTER)
		draw.SimpleText(nPoufPoints, "HOUSEPOINTS::Font1", 1015, 10, color_white, TEXT_ALIGN_CENTER)
	cam.End3D2D()

	
	aAng:RotateAroundAxis(aAng:Right(), 45)
	vPos = vPos - aAng:Up() * 20 - aAng:Right() * 5 + aAng:Forward() * 65

	cam.Start3D2D(vPos, aAng, 0.05)
		drawAddPoints()
	cam.End3D2D()
end