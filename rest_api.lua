local pretty = require "cc.pretty"

local monitor = peripheral.wrap("back")
endpoint = "http://api.kuraitachi.com/"

local request = http.get(endpoint)
response = request.readAll()

function printTable(table)
    for key, value in pairs(table) do
        if type(value) == "table" then
            print(key .. ": ")
            printTable(value)
        else
            monitorWrite(key .. ": " .. value)
        end
    end
end

function monitorWriteNewLine(text)
    monitor.write(text)
    local x, y = monitor.getCursorPos()
    monitor.setCursorPos(1, y + 1)
end

function monitorWrite(text)
    monitor.write(text)
end

function monitorWriteJson(data)
    local data_table = textutils.unserialiseJSON(data)
    local data_endpoints = data_table["endpoints"]
    local data_message = data_table["message"]

    monitorWriteNewLine(data_message)
    monitorWriteNewLine("Endpoints:")
    
    for _, endpoint in ipairs(data_endpoints) do
        monitorWrite(" -")
        printTable(endpoint)
        monitorWriteNewLine("")
    end
end

-- Setup the monitor for writing
monitor.clear()
monitor.setCursorPos(1, 1)

monitorWriteNewLine("Testing " .. endpoint)
monitorWriteJson(response)

request.close()
