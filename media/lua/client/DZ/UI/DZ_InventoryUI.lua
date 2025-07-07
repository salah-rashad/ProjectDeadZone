--- @type ISPanel
DZ_InventoryUI = ISPanel:derive("DZ_InventoryUI")

local ITEM_BTN_H = 32
local ITEM_BTN_W = 180
local ITEM_BTN_PAD = 4

-------------------------------------------------------------
-- Initialise → populate buttons
-------------------------------------------------------------
function DZ_InventoryUI:initialise()
    ISPanel.initialise(self)
    self:refreshItemList()
end

-------------------------------------------------------------
-- Constructor
-------------------------------------------------------------
function DZ_InventoryUI:new(x, y, w, h)
    local panel = ISPanel.new(self, x, y, w, h)
    panel.backgroundColor = {
        r = 0.1,
        g = 0.1,
        b = 0.1,
        a = 0.7
    }
    panel:initialise()
    return panel
end

-------------------------------------------------------------
-- Rebuild every button (call after inventory changes)
-------------------------------------------------------------
function DZ_InventoryUI:refreshItemList()
    self:clearChildren()

    local player = getSpecificPlayer(0)
    if not player then
        return
    end

    local inv = player:getInventory()
    local y = ITEM_BTN_PAD

    local items = inv:getItems()
    for i = 0, items:size() - 1 do
        local item = items:get(i)
        local btn = ISButton:new(ITEM_BTN_PAD, y, ITEM_BTN_W, ITEM_BTN_H, item:getDisplayName(), self,
            DZ_InventoryUI.onClickItem)
        btn.internal = item
        self:addChild(btn)
        y = y + ITEM_BTN_H + ITEM_BTN_PAD
    end

    -- Resize panel to fit
    self:setHeight(y + ITEM_BTN_PAD)
end

-------------------------------------------------------------
-- Click → start vanilla place‑item preview
-------------------------------------------------------------
function DZ_InventoryUI:onClickItem(button)
    local player = getPlayer()
    local item = button.internal
    if not (player and item) then
        return
    end

    -- -- Hand over to vanilla placement system
    -- ISInventoryPaneContextMenu.doPlace3DItemOption(item, player)
end

-------------------------------------------------------------
-- Utility – string endsWith (local)
-------------------------------------------------------------
function string.endswith(str, ending)
    return ending == "" or str:sub(-#ending) == ending
end
