-- TODO:
-- Documentação
-- VARIÁVEIS

local profundidade, largura, altura
local direcao = {
    {"Direita",false},
    {"Esquerda",false}
}

local opc_selecionada = 1
local versao = 1.0

local ligar_programa = true
local escolher_dir = true
local escolher_preencher = true

-- FUNÇÕES

function limpar_tela()

    for i = 6, 12 do 
        term.setCursorPos(1,i)
        term.clearLine()
    end

end 

function esvaziar_inventario()

    turtle.turnRight()
    turtle.turnRight()
    while turtle.detect() do turtle.dig() end 

    turtle.select(16)
    while not turtle.place() do 
        turtle.dig()
        os.sleep(1) 
    end  
    turtle.select(1)

    if turtle.refuel(1) then
        for i = 2, 14 do
            turtle.select(i)
            turtle.drop()
        end
    else 
        for i = 1, 14 do
            turtle.select(i)
            turtle.drop()
        end 
    end

    turtle.select(16)
    turtle.dig()
    turtle.turnRight()
    turtle.turnRight()

end 

function encher_combustivel()

    turtle.turnRight()
    turtle.turnRight()
    while turtle.detect() do turtle.dig() end 

    turtle.select(15)
    while not turtle.place() do 
        turtle.dig()
        os.sleep(1) 
    end 
    turtle.select(1)
    turtle.suck()
    turtle.refuel(1)
    turtle.drop(63)
    turtle.select(15)
    turtle.dig()
    turtle.turnRight()
    turtle.turnRight()

end

function escavar(x, z, y)

    local total = y*z
    local vez_executada = 1 

    limpar_tela()

    term.setCursorPos(14,6)
    write("Escavando...")
    term.setCursorPos(10,8)
    write(string.format("Dim: %3d x %3d x %3d",profundidade, largura, altura))

    local dir = direcao[1][2]

    for i = 1, y do 

        for j = 1, z do 

            term.setCursorPos(15,11)
            write(string.format("( %3d %% )",math.floor((vez_executada/total)*100)))

            for k = 1, x do 

                while not turtle.forward() do 
                    turtle.dig()
                end

                if turtle.getItemCount(14) > 0 then 
                    esvaziar_inventario()
                end

            end

            if j ~= z then

                if dir then 
                    turtle.turnRight()
                    
                    while not turtle.forward() do 
                        turtle.dig()
                    end

                    turtle.turnRight()
                else 
                    turtle.turnLeft()
                    
                    while not turtle.forward() do 
                        turtle.dig()
                    end

                    turtle.turnLeft()
                end 
                dir = not dir 

            end

            vez_executada = vez_executada + 1
        end 

        if i ~= y then
            while not turtle.up() do
                turtle.digUp()
            end 
            turtle.turnRight()
            turtle.turnRight()
        else 
            term.setCursorPos(14,6)
            term.clearLine()
            write("Voltando...")

            if (y % 2) == 1 then 
                for i = 1, y-1 do 
                    while not turtle.down() do 
                        turtle.digDown()
                    end 
                end 

                for i = 1, x do 
                    if not turtle.back() then  
                        turtle.turnRight()
                        turtle.turnRight()
                        
                        while not turtle.forward() do 
                            turtle.dig()
                        end

                        turtle.turnRight()
                        turtle.turnRight()
                    end 
                end 

                if dir then 
                    turtle.turnLeft()
                else 
                    turtle.turnRight()
                end 

                for i = 1, z-1 do 
                    while not turtle.forward() do 
                        turtle.dig()
                    end
                end 

                if dir then 
                    turtle.turnRight()
                else 
                    turtle.turnLeft()
                end

                if (z % 2) == 0 then 
                    for i = 1, x do 
                        while not turtle.forward() do 
                            turtle.dig()
                        end
                    end 

                    turtle.turnRight()
                    turtle.turnRight()
                end

            else 
                turtle.turnRight()
                turtle.turnRight()

                for i = 1, y-1 do 
                    turtle.down()
                end 
            end
        end

    end
    
end

function preencher_chao(x, z)

    dir = direcao[1][2]

    limpar_tela()
    term.setCursorPos(7,6)
    write("[ Preenchendo o Chao... ]")

    local function achar_bloco()
    
        turtle.select(1)

        if turtle.refuel(1) then 
            for k = 2, 14 do 
                turtle.select(k)
                if turtle.placeUp() then 
                    turtle.digUp()
                    return k
                end 
            end
        else 
            for k = 1, 14 do
                turtle.select(k)
                if turtle.placeUp() then 
                    turtle.digUp()
                    return k
                end  
            end
        end 

    end 

    local slot_bloco = achar_bloco()

    for i = 1, z do 

        for j = 1, x do 

            while not turtle.detectDown() do 
                turtle.select(slot_bloco)
                if not turtle.placeDown() then 
                    slot_bloco = achar_bloco()
                end 
                os.sleep(0.5)
            end 

            while not turtle.forward() do 
                turtle.dig()
            end 

        end

        while not turtle.detectDown() do 
            turtle.select(slot_bloco)
            if not turtle.placeDown() then 
                slot_bloco = achar_bloco()
            end 
            os.sleep(0.5)
        end

        if i ~= z then

            if dir then 
                turtle.turnRight()

                while not turtle.forward() do 
                    turtle.dig()
                end

                turtle.turnRight()
            else 
                turtle.turnLeft()

                while not turtle.forward() do 
                    turtle.dig()
                end

                turtle.turnLeft()
            end 
            dir = not dir 

        end

    end 

    for i = 1, x do 
        turtle.back()
    end 

        if dir then 
            turtle.turnLeft()
        else 
            turtle.turnRight()
        end 

    for i = 1, z-1 do 
        turtle.forward()
    end 

        if dir then 
            turtle.turnRight()
        else 
            turtle.turnLeft()
        end

end

-- MENU 

local etapa_atual = 1
term.clear()
term.setCursorPos(1,1)

term.setCursorPos(14,2)
write("[ Bombinha ]")
term.setCursorPos(1,3)
write("---------------------------------------")

if turtle.getItemCount(16) == 0 or turtle.getItemCount(15) == 0 then  
    term.setCursorPos(2,6)
    write(string.format("%d. Insira os Ender Chests",etapa_atual))
    term.setCursorPos(1,8)
    write("Coloque o Ender Chest de entrada de itens no Slot 16 e o de Ender Chest de combustivel no Slot 15")
    term.setCursorPos(6,12)
    write("< Pressione algo >")
    term.setCursorPos(28,12)
    write("[X] - Sair")

    local event, key = os.pullEvent("key")

    if key == keys.x then
        term.setCursorPos(1,1)
        term.clear() 
        return false
    end

    limpar_tela()

    if turtle.getItemCount(16) ~= 1 or turtle.getItemCount(15) ~= 1 then 
        term.setCursorPos(7,7)
        write("[ Ender Chests Faltando! ]")
        term.setCursorPos(1,10)
        write("Por favor coloque o bau de carvao no slot 15 e o de entrada de itens no slot 16")
        
        event, key = os.pullEvent("key")
        term.setCursorPos(1,1)
        term.clear() 
        return false
    end

    etapa_atual = etapa_atual + 1
end

limpar_tela()
term.setCursorPos(14,7)
write("Carregando...")
esvaziar_inventario()
limpar_tela()

term.setCursorPos(2,6)
write(string.format("%d. Escolha a direcao para onde cavar",etapa_atual))
term.setCursorPos(28,12)
write("[X] - Sair")

while escolher_dir do 

    for i = 1, 2 do 

        if opc_selecionada == i then 
            term.setCursorPos(2,7+i)
            term.clearLine()
            write("-> "..direcao[i][1])
        else
            term.setCursorPos(5,7+i)
            term.clearLine()
            write(direcao[i][1])
        end

    end

    event, key = os.pullEvent("key")

        if key == keys.x then 
            return false
        end

        if key == 200 then 
            opc_selecionada = opc_selecionada - 1
        elseif key == 208 then 
            opc_selecionada = opc_selecionada + 1
        end 

        if opc_selecionada > 2 then 
            opc_selecionada = 1
        elseif opc_selecionada < 1 then 
            opc_selecionada = 2
        end

        if key == 28 then 
            direcao[opc_selecionada][2] = true 
            escolher_dir = false
            etapa_atual = etapa_atual + 1
        end 

end

limpar_tela()
term.setCursorPos(2,6)
write(string.format("%d. Digite as dimensoes",etapa_atual))

term.setCursorPos(6,8)
write("Profundidade: ")
profundidade = read()

if tonumber(profundidade) == nil or tonumber(profundidade) <= 0 then 
    limpar_tela()
    term.setCursorPos(8,10)
    write("[ Dimensoes invalidas ]")
    read()
    return false
end
profundidade = math.floor(tonumber(profundidade))

term.setCursorPos(6,10)
write("Largura: ")
largura = read()

if tonumber(largura) == nil or tonumber(largura) <= 0 then 
    limpar_tela()
    term.setCursorPos(8,10)
    write("[ Dimensoes invalidas ]")
    read()
    return false
end 
largura = math.floor(tonumber(largura))

term.setCursorPos(6,12)
write("Altura: ")
altura = read()

if tonumber(altura) == nil or tonumber(altura) <= 0 then 
    limpar_tela()
    term.setCursorPos(8,10)
    write("[ Dimensoes invalidas ]")
    read()
    return false
end
altura = math.floor(tonumber(altura)) 

local volume = profundidade*largura*altura
local combustivel_faltando = (volume*2) - turtle.getFuelLevel()

if volume <= 1 then 
    limpar_tela()
    term.setCursorPos(8,10)
    write("[ Dimensoes invalidas ]")
    read()
    return false
end

if combustivel_faltando > 0 then

    local carvao_faltando = math.ceil(combustivel_faltando/96)
    
    turtle.turnRight()
    turtle.turnRight()

    turtle.select(15)
    while not turtle.place() do 
        turtle.dig()
        os.sleep(1) 
    end 
    turtle.select(1)

    if carvao_faltando > 64 then 
        repeat
            turtle.suck()
            turtle.refuel()
            os.sleep(5)
        until turtle.getFuelLevel() >= volume*2
    else
        turtle.suck()
        turtle.refuel(carvao_faltando) 
    end 

    turtle.select(15)
    turtle.dig()
    turtle.select(1)
    turtle.turnRight()
    turtle.turnRight()

end

escavar(profundidade-1, largura, altura)
limpar_tela()
etapa_atual = etapa_atual + 1

term.setCursorPos(2,6)
write(string.format("%d. Deseja preencher o chao?",etapa_atual))
term.setCursorPos(7,8)
write("[S] - Sim")
term.setCursorPos(7,10)
write("[N] - Nao")

while true do 

    event, key = os.pullEvent("key")

    if key == keys.s then 
        preencher_chao(profundidade-1, largura)
        break
    elseif key == keys.n then 
        break 
    end

end

limpar_tela()
term.setCursorPos(13,8)
write("Encerrando...")
os.sleep(1)
term.setCursorPos(11,10)
write("Ate a proxima! =]")

    esvaziar_inventario()
    turtle.select(15)
    turtle.place()
        for i = 1, 16, 15 do 
            turtle.select(i)
            turtle.drop()
        end 
    turtle.select(1)
    turtle.dig()

os.sleep(0.1)
term.setCursorPos(1,1)
term.clear()