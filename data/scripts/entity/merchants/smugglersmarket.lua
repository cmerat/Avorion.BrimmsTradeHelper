local hooked_onShowWindow = SmugglersMarket.onShowWindow
function SmugglersMarket.onShowWindow()
    hooked_onShowWindow()

    local ship = buyer.craft

    -- read cargos and sort
    local cargos = {}
    for good, amount in pairs(ship:getCargos()) do
        table.insert(cargos, {good = good, amount = amount})
    end

    function comp(a, b) return a.good.name < b.good.name end
    table.sort (cargos, comp)

    local i = 1
    for _, p in pairs(cargos) do
        local good, amount = p.good, p.amount

        if good.stolen then
            if i - 1 < itemStart then
                goto continue
            end

            if i - itemStart <= #brandLines then
                -- do unbranding lines
                local line = brandLines[i - itemStart]
                line.numbers.text = tostring(amount)
            end

            ::continue::

            i = i + 1
        end
    end
end