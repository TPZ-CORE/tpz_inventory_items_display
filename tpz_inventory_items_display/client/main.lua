local DISPLAY_LIST = {}
local HAS_NUI_ACTIVE = false

-----------------------------------------------------------
--[[ Functions ]]--
-----------------------------------------------------------

local function DisplayNextItem()

    if HAS_NUI_ACTIVE then
        return
    end

    if #DISPLAY_LIST <= 0 then
        return
    end

    local display = DISPLAY_LIST[1]

    HAS_NUI_ACTIVE = true

    -- =====================================================
    -- OPEN / UPDATE NUI HERE
    -- =====================================================

    SendNUIMessage({
        action = 'displayItem',
        item = display.item,
        label = display.label,
        quantity = display.quantity,
        type = display.type
    })

end

-----------------------------------------------------------
--[[ Events ]]--
-----------------------------------------------------------

RegisterNetEvent('tpz_inventory_items_display:client:received_item')
AddEventHandler('tpz_inventory_items_display:client:received_item', function(item, label, quantity)

    table.insert(DISPLAY_LIST, {
        duration = 0,
        item = item,
        label = label,
        quantity = quantity,
        type = 'add'
    })

    DisplayNextItem()

end)


RegisterNetEvent('tpz_inventory_items_display:client:removed_item')
AddEventHandler('tpz_inventory_items_display:client:removed_item', function(item, label, quantity)

    table.insert(DISPLAY_LIST, {
        duration = 0,
        item = item,
        label = label,
        quantity = quantity,
        type = 'remove'
    })

    DisplayNextItem()

end)

-----------------------------------------------------------
--[[ Threads ]]--
-----------------------------------------------------------

CreateThread(function()

    while true do

        Wait(1000)

        if HAS_NUI_ACTIVE and DISPLAY_LIST[1] then

            local display = DISPLAY_LIST[1]

            display.duration = display.duration + 1

            local maximumDuration

            if display.type == 'add' then
                maximumDuration = Config.ItemAddedDisplayDuration
            elseif display.type == 'remove' then
                maximumDuration = Config.ItemRemovedDisplayDuration
            end

            if maximumDuration and display.duration >= maximumDuration then

                -- =================================================
                -- CLOSE / HIDE CURRENT NUI HERE
                -- =================================================

                SendNUIMessage({
                    action = 'closeItem'
                })

                -- Remove the item that was just displayed.
                table.remove(DISPLAY_LIST, 1)

                HAS_NUI_ACTIVE = false

                -- Display the next queued item.
                DisplayNextItem()

            end

        elseif not HAS_NUI_ACTIVE and #DISPLAY_LIST > 0 then

            DisplayNextItem()

        end

    end

end)