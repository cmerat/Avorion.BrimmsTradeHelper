local hooked_updateBoughtGoodGui = TradingManager.updateBoughtGoodGui
function TradingManager:updateBoughtGoodGui(index, good, price)    
    hooked_updateBoughtGoodGui(self, index, good, price)

    if not self.guiInitialized then return end

    local maxAmount = self:getMaxStock(good.size)
    local amount = self:getNumGoods(good.name)
    local capacity = maxAmount - amount
    
    local ownCargo = 0
    local ship = Entity(Player().craftIndex)
    if ship then
        ownCargo = ship:getCargoAmount(good) or 0
    end

    local line = self.boughtLines[index]

    local newNumberValue
    if ownCargo > capacity then
        newNumberValue = tostring(capacity)        
    else
        newNumberValue = tostring(ownCargo)
    end

    line.number.text = newNumberValue
end
