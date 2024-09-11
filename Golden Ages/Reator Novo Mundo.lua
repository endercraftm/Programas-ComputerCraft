-- Reator Novo Mundo

--versao = 0.2

--[[    

    Lista de coisas para fazer

    -> Sistema de Resfriamento
    -> Alarme
    -> Menus
    -> Modo Manual
    -> Calor Máximo ( 5000+1000*reading.size )

]]--

local inicio = true

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

function reator()

    while inicio do
    
    local target = sensors.getAvailableTargetsforProbe("left", "Sensor", "Reactor")
    local reading = sensors.getSensorReadingAsDict("left", "Sensor", target[1], "Reactor")
    local status = {"Ativado","Desativado","Resfriando...","Resfriamento Concluido"}
    local status_atual

    local valor1 = 750  -- Variaveis temporárias
    local valor2 = valor1*4 -- Variaveis temporárias

    if reading.heat == 0 then
        rs.setBundledOutput("back",colors.white)
        elseif reading.heat > 0 and reading.heat <= valor1 then
        rs.setBundledOutput("back",colors.combine(colors.yellow))
        elseif reading.heat > valor1 and reading.heat < valor2 then
        rs.setBundledOutput("back",colors.combine(colors.yellow,colors.orange))
        elseif reading.heat >= valor2 then 
        rs.setBundledOutput("back",colors.combine(colors.yellow,colors.orange,colors.red))
    end
    
    if rs.testBundledInput("back",colors.lime) then
        status_atual = status[1]
        elseif not rs.testBundledInput("back",colors.lime) then
        status_atual = status[2]
        elseif rs.testBundledInput("back",colors.combine(colors.lightBlue,colors.cyan)) then
        status_atual = status[3]
        elseif rs.testBundledInput("back",colors.white) then
        status_atual = status[4]
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
parallel.waitForAll(reator,sair_programa)