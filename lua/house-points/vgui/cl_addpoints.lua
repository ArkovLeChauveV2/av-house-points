local color_background = Color(25, 25, 25, 225)

local mGryf, mPouf, mSerd, mSerp = Material("av-house-points/gryffondor.png"), Material("av-house-points/poufsouffle.png"), Material("av-house-points/serdaigle.png"), Material("av-house-points/serpentard.png")

local tHouses = {
    mGryf,
    mPouf,
    mSerd,
    mSerp
}

local PANEL = {}

function PANEL:Init()
    self:SetSize(920, 1000)
    self:SetPaintBackground(false)

    self.pHousesCont = vgui.Create("DPanel", self)
    self.pHousesCont:SetSize(self:GetWide(), self:GetTall() / 4.16)
    self.pHousesCont:SetBackgroundColor(color_background)

    for nIndex, mHouseMat in pairs(tHouses) do
        self.pHousesCont.pHouse = vgui.Create("DImageButton", self.pHousesCont)
        self.pHousesCont.pHouse:SetMaterial(mHouseMat)
        self.pHousesCont.pHouse:SetWide(215)
        self.pHousesCont.pHouse:Dock(LEFT)
        self.pHousesCont.pHouse:SetAlpha(75)

        function self.pHousesCont.pHouse:OnCursorEntered()
            self:SetAlpha(255)
        end

        function self.pHousesCont.pHouse:OnCursorExited()
            self:SetAlpha(75)
        end

        if (nIndex == 1) then continue end
        self.pHousesCont.pHouse:DockMargin(20, 0, 0, 0)
    end


end

function PANEL:Think()
    print(gui.ScreenToVector(input.GetCursorPos()))
end

vgui.Register("HOUSEPOINTS::Registry", PANEL, "DPanel")
/*
if IsValid(AA) then AA:Remove() end

AA = vgui.Create("HOUSEPOINTS::Registry")
AA:MakePopup()