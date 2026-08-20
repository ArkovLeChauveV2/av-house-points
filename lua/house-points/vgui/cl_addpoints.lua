local color_background, color_house = Color(25, 25, 25, 225), Color(255, 255, 255, 100)

local mGryf, mPouf, mSerd, mSerp = Material("av-house-points/gryffondor.png"), Material("av-house-points/poufsouffle.png"), Material("av-house-points/serdaigle.png"), Material("av-house-points/serpentard.png")

local tHouses = {
    mGryf,
    mPouf,
    mSerd,
    mSerp
}

local PANEL = {}

function PANEL:Init()
    self.vPos = vector_origin
    self.aAng = angle_zero
    self.nScale = 1

    self.nHouse = 0
    
    self.Panels = {}

    self:SetSize(920, 1000)
    self:SetPaintedManually(true)
    self:SetPaintBackground(false)

    self.pHousesCont = vgui.Create("DPanel", self)
    self.pHousesCont:SetSize(self:GetWide(), self:GetTall() / 4.16)
    self.pHousesCont:SetBackgroundColor(color_background)

    for nIndex, mHouseMat in pairs(tHouses) do
        self.pHousesCont.pHouse = vgui.Create("DButton", self.pHousesCont)
        self.pHousesCont.pHouse:SetWide(215)
        self.pHousesCont.pHouse:SetText("")
        self.pHousesCont.pHouse:Dock(LEFT)
        self.Panels[nIndex] = self.pHousesCont.pHouse

        self.pHousesCont.pHouse.Paint = function(s, w, h)
            local bFullAlpha = self.nHouse == nIndex or s.Hovered

            surface.SetDrawColor(bFullAlpha and color_white or color_house)
            surface.SetMaterial(mHouseMat)
            surface.DrawTexturedRect(0, 0, w, h)
        end

        self.pHousesCont.pHouse.DoClick = function()
            self.nHouse = nIndex
        end

        if (nIndex == 1) then continue end
        self.pHousesCont.pHouse:DockMargin(20, 0, 0, 0)
    end
end

function PANEL:ElementHovered(pElement, nMouseX, nMouseY)
    local x, y = pElement:GetPos()
    local w, h = pElement:GetSize()

    return nMouseX >= x
        && nMouseY >= y
        && x + w >= nMouseX
        && y + h >= nMouseY
end

function PANEL:Get3d2dMousePos()
    local vHitPos = util.IntersectRayWithPlane(LocalPlayer():EyePos(), gui.ScreenToVector(input.GetCursorPos()), self.vPos, self.aAng:Up())
    if !vHitPos then return 0, 0 end

    local vDiff = self.vPos - vHitPos

    local x = vDiff:Dot(-self.aAng:Forward()) / self.nScale
    local y = vDiff:Dot(-self.aAng:Right()) / self.nScale

    return x, y
end

function PANEL:Think()
    local nMouseX, nMouseY = self:Get3d2dMousePos()
    
    for _, pPanel in pairs(self.Panels) do
		if self:ElementHovered(pPanel, nMouseX, nMouseY) && !pPanel.Hovered then
			pPanel.Hovered = true
		elseif !self:ElementHovered(pPanel, nMouseX, nMouseY) && pPanel.Hovered then
			pPanel.Hovered = false
		end

        if pPanel.Hovered && (input.IsMouseDown(MOUSE_LEFT) || LocalPlayer():KeyDown(IN_USE)) then
            pPanel:DoClick()
        end
    end
end

function PANEL:Set3d2dInfos(vPos, aAng, nScale)
    self.vPos = vPos
    self.aAng = aAng
    self.nScale = nScale
end

vgui.Register("HOUSEPOINTS::Registry", PANEL, "DPanel")