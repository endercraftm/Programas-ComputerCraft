-- Reator Novo Mundo

--versao = 0.3

--[[    

    Lista de coisas para fazer

    -> Alarme
    -> Menus
    -> Modo Manual
    -> Calor Máximo ( 5000+1000*reading.size )

]]--

local inicio = true
target = sensors.getAvailableTargetsforProbe("left", "Sensor", "Reactor")
reading = sensors.getSensorReadingAsDict("left", "Sensor", target[1], "Reactor")
local status = {"Ativado","Desativado","Resfriando...","Resfriamento Concluido"}
local status_atual
local valor1 = 500  -- Variaveis temporárias
local valor2 = valor1*4 -- Variaveis temporárias

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

        if reading.heat > 0 and reading.heat <= valor1 then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow))
            elseif reading.heat > valor1 and reading.heat < valor2 then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow,colors.orange))
            elseif reading.heat >= valor2 then
            rs.setBundledOutput("bottom",colors.combine(colors.yellow,colors.orange,colors.red))
            elseif reading.heat == 0 then
            rs.setBundledOutput("bottom",0)
        end

        os.sleep(0.01)
    end

end

function resfriamento()

    if reading.heat >= valor2 then
            
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

                end

                break
            end
            os.sleep(1)
        end

    end

end

function reator()

    while inicio do

    resfriamento()
    
    if rs.testBundledInput("back",colors.green) then
        status_atual = status[1]
        elseif not rs.testBundledInput("back",colors.green) then
        status_atual = status[2]
    end

    limpa_linhas(1,1,1)
    print("Status do Reator: "..tostring(status_atual))
    limpa_linhas(2,2,2)
    print("Calor: "..tostring(reading.heat))

    os.sleep(0.1)
    end

end

term.clear()
term.setCursorPos(1,1)
parallel.waitForAll(sair_programa,calor,reator)