

local TPZ = exports.tpz_core:getCoreAPI()

-----------------------------------------------------------
--[[ General Events  ]]--
-----------------------------------------------------------

RegisterServerEvent("tpz_inventory:server:received_item")
AddEventHandler("tpz_inventory:server:received_item", function(targetSource, item, label, quantity)
    local _tsource = tonumber(targetSource)
    TriggerClientEvent("tpz_inventory_items_display:client:received_item", _tsource, item, label, quantity)
end)

RegisterServerEvent("tpz_inventory:server:removed_item")
AddEventHandler("tpz_inventory:server:removed_item", function(targetSource, item, label, quantity)
    local _tsource = tonumber(targetSource)
    TriggerClientEvent("tpz_inventory_items_display:client:removed_item", _tsource, item, label, quantity)
end)
