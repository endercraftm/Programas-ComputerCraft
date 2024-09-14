-- Reator Novo Mundo

--versao = 0.5

--[[    

    Lista de coisas para fazer

    -> Menus
    -> Modo Manual

]]--

local inicio = true
target = sensors.getAvailableTargetsforProbe("left", "Sensor", "Reactor")
reading = sensors.getSensorReadingAsDict("left", "Sensor", target[1], "Reactor")
local status = {"Ativado","Desativado","Resfriando...","Resfriamento Concluido"}
local calor_max = 5000+1000*reading.size

function limpa_linhas(l1,l2,l3)
    for i = l1, l2 do
    term.setCursorPos(1,i)
    term.clearLine()
    end
    term.setCursorPos(1,l3)
end

function sair_programa()

    while inicio do 

        local event, key = os.pullEvent("key")

        if key == keys.x then
            inicio = false
        end
    
    end

end

function calor()

    rs.setBundledOutput("back",0)
    while inicio do 
        reading = sensors.getSensorReadingAsDict("left", "Sensor", target[1], "Reactor")

        if reading.heat > 0 and reading.heat <= calor_max/2 then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow))
            elseif reading.heat > calor_max/2 and reading.heat < calor_max then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow,colors.orange))
            elseif reading.heat >= calor_max/2 then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow,colors.orange,colors.red))
            else
            rs.setBundledOutput("bottom",0)
        end

        os.sleep(0.01)
    end

end

function infos(n)
    term.setCursorPos(12,7)
    write("                       ")
    term.setCursorPos(16,8)
    write("      ")
    term.setCursorPos(18,9)
    write("             ")
    term.setCursorPos(4,7)
    write("Status: "..tostring(status[n]))   
    term.setCursorPos(4,8)
    write("Temperatura: "..tostring(reading.heat))
    term.setCursorPos(4,9)
    write("Saida de Energia: "..tostring(reading.output).." EU/t")
end

function resfriamento()

    if reading.heat >= calor_max then
            
        while true do

            rs.setBundledOutput("back",colors.combine(colors.cyan,colors.lightBlue,colors.lime,colors.blue))
            
            if reading.heat == 0 then
                
                while true do 

                    rs.setBundledOutput("back",colors.combine(colors.lime,colors.white))
                
                        if (rs.testBundledInput("bottom",colors.blue) and (reading.heat == 0)) then
                            rs.setBundledOutput("back",0)
                            break
                        end
                    os.sleep(0.5)
                infos(4)
                end

                break
            end
            infos(3)
            os.sleep(1)
        end

    end

end

function reator()

    while inicio do

    resfriamento()
    
        if rs.testBundledInput("back",colors.green) then
            infos(1)
            else
            infos(2)
        end

    os.sleep(0.1)
    end

end

term.clear()
term.setCursorPos(1,0)
print("<=================+=================>")
for i = 2, 17 do
term.setCursorPos(1,i)
write("|                                  |\n")
end
term.setCursorPos(1,5)
term.write("<=================+=================>")
term.setCursorPos(1,18)
term.write("<=================+=================>")
term.setCursorPos(9,3)
term.write("[ Reator Novo Mundo ]")

parallel.waitForAll(sair_programa,calor,reator)