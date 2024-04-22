-- attributeTimings
-- v1.3  (MA3 2.0) - 2024-04-22
-- Written by jeff @ penlight.ca
-- https://github.com/jefffarrow
-- Released under WTFPL Public License

-- Set attribute fade and delay times for the current cue via popup

-- Many hours have been invested in building and testing this code.
-- If you find this plugin useful, please buy me a coffee https://buymeacoffee.com/jfarrow

local function attributeTimings()
    local attList = {}
    for k, value in ipairs(DataPool().PresetPools:Children()) do
        attList[value.name] = value.no
    end

    local options = {
        icon = "time",
        backColor = "Global.PartlySelected",
        title = "Attribute Cue Timings",
        message = "Set Attribute Fade / Delay Times for the current cue",
        commands = { { value = 1, name = "Ok" }, { value = 0, name = "Cancel" } },
        inputs = { { name = "Fade Time", value = "", whiteFilter = ".0123456789" }, { name = "Delay Time", value = "", whiteFilter = ".0123456789" } },
        selectors = { { name = "Att", selectedValue = 1, values = attList, type=0 } }
    }

    local r = MessageBox(options)

    if r.success then
        if r.result == 0 then
            Echo('User pressed Cancel')
        end
        if r.result == 1 then
            Echo('User pressed OK')
            if (r.inputs["Fade Time"] ~= "") then -- test for blank entry
                Cmd('Set Cue Property "preset%sfade" %s', tostring(r.selectors["Att"]), tostring(r.inputs["Fade Time"]))
            end
            if (r.inputs["Delay Time"] ~= "") then -- test for blank entry
                Cmd('Set Cue Property "preset%sdelay" %s', tostring(r.selectors["Att"]), tostring(r.inputs["Delay Time"]))
            end
        end
    else
        Echo('User escaped the dialog')
    end
end

return attributeTimings
