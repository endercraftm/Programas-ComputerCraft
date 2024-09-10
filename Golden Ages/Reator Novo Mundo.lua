-- Reator Novo Mundo

--versao = 0.2

local inicio = true

function sair_programa()

    while inicio do 

        local event, key = os.pullEvent("key")

        if key == keys.x then
            inicio = false
        end
    
    end

end

function reator()

    while inicio do

    os.unloadAPI("sensors")
    os.loadAPI("/rom/apis/sensors")

    side = sensors.getController()
    sensor = sensors.getSensors(side)
    probe = sensors.getProbes(side, sensor[1])
    target = sensors.getAvailableTargetsforProbe(side, sensor[1], probe[2])
    reading = sensors.getSensorReadingAsDict(side, sensor[1], target[1], probe[2])
    infos = {reading.heat,reading.size,reading.output}
    local status = {"Ativado","Desativado","Resfriando...","Resfriamento Concluido"}

    term.setCursorPos(1,1)
    term.clearLine()
    print("Calor: "..tostring(infos[1]))
    print("Reator: "..tostring(status[2]))
    term.setCursorPos(1,3)
    term.clearLine()
    print("Saida de EU: "..tostring(infos[3]))

        if infos[1] == 0 then -- Calor

            rs.setBundledOutput("back",colors.white)

            elseif infos[1] > 0 and infos[1] <= 3000 then

            rs.setBundledOutput("back",colors.yellow)

            elseif infos[1] > 3000 and infos[1] <= 6000 then

            rs.setBundledOutput("back",colors.combine(colors.yellow,colors.orange))

            elseif infos[1] > 6000 then

            rs.setBundledOutput("back",colors.combine(colors.yellow,colors.orange,colors.red))

        end

        if rs.testBundledInput("back",colors.green) and rs.testBundledInput("back",colors.lime) then --Reator Ligado/Desligado

            term.setCursorPos(1,2)
            term.clearLine()
            print("Reator: "..tostring(status[1]))

            elseif not rs.testBundledInput("back",colors.green) and not rs.testBundledInput("back",colors.lime) then

            term.setCursorPos(1,2)
            term.clearLine()
            print("Reator: "..tostring(status[2]))
            
        end

    os.sleep(0.1)
    end

end

term.clear()
parallel.waitForAll(reator,sair_programa)
