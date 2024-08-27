-->> Bombinha

-->> Glossario:

-- SPT: Suplementos Para Turtles
-- SLP: Sistema Logistic Pipes

versao = "1.0"

combustivel = turtle.getFuelLevel()
dir_esq = true

function limparLinhas(l1,l2,l3)
    for i = l1, l2 do
        term.setCursorPos(1,i)
        term.clearLine()
    end
    term.setCursorPos(1,l3)
end

function encher_tanque(f) -- Pega 1 stack de Combustivel do Ender Chest SPT 

        for i = 1, 2 do
            turtle.turnRight()
        end

        while turtle.detect() == true do
            turtle.dig()
        end
    
        turtle.select(15)
        turtle.place()
        turtle.select(1)
        turtle.suck()
        turtle.refuel(f)
        turtle.select(15)
        turtle.dig()

        for i = 1, 2 do
            turtle.turnLeft()
        end

end

function esvaziar_inv() -- Transfere todos os itens dos slots 2-14 para o Ender Chest SLP

    for i = 1, 2 do
        turtle.turnRight()
    end

    while turtle.detect() == true do
        turtle.dig()
    end

    turtle.select(16)
    turtle.place()
    for i = 2, 14 do
        turtle.select(i)
        turtle.drop()
    end
    turtle.select(16)
    turtle.dig()

    for i = 1, 2 do
        turtle.turnLeft()
    end        

end

function se_encher(x,y,z)
    if (combustivel < (x*y*z) and turtle.getItemCount(1) < (math.floor((x*y*z)/96)+1)) then
        encher_tanque(math.floor((x*y*z)/96)+1)
    elseif (combustivel < (x*y*z) and turtle.getItemCount(1) >= (math.floor((x*y*z)/96)+1)) then
        turtle.select(1)
        turtle.refuel(math.floor((x*y*z)/96)+1)
    end
end

function se_esvaziar()
    if turtle.getItemSpace(14) < 64 then
        esvaziar_inv()
    end
end

function voltar(x,y,z)

    dir_esq = true

    if (combustivel < (x+y+z) and turtle.getItemCount(1) < (math.floor((x+y+z)/96)+1)) then
        encher_tanque(math.floor((x*y*z)/96)+1)
    elseif (combustivel < (x+y+z) and turtle.getItemCount(1) >= (math.floor((x+y+z)/96)+1)) then
        turtle.select(1)
        turtle.refuel(math.floor((x*y*z)/96)+1)
    end

    se_esvaziar()

 if math.fmod(y,2) ~= 0 then

    for i = 1, 2 do
        turtle.turnRight()
    end

        for a = 1, x-1 do
            while not turtle.forward() do
                turtle.dig()
            end
        end

        if dir_esq == true then
            turtle.turnRight()
        elseif dir_esq == false then
            turtle.turnLeft()
        end

        for b = 1, y-1 do
            while not turtle.forward() do
                turtle.dig()
            end
        end

        turtle.turnRight()

        for c = 1, z-1 do 
            while not turtle.down() do
                turtle.digDown()
            end
        end

 else 

    turtle.turnRight()

    for b = 1, y-1 do
        while not turtle.forward() do
            turtle.dig()
        end
    end

    turtle.turnRight()

    for c = 1, z-1 do 
        while not turtle.down() do
            turtle.digDown()
        end
    end

 end

end

function tampa_buraco(x,y)

    dir_esq = true

    se_encher(x,y,1)
    se_esvaziar()

    for b = 1, y do 

        for a = 1, x-1 do

            while not turtle.detectDown() do
                turtle.select(2)
                turtle.placeDown()
            end

            while not turtle.forward() do
                turtle.dig()
            end

        end
        
        if y>1 and b ~= y then
            
            if dir_esq == true then

                while not turtle.detectDown() do
                    turtle.select(2)
                    turtle.placeDown()
                end

                turtle.turnRight()
                while not turtle.forward() do
                    turtle.dig()
                end
                turtle.turnRight()
                dir_esq = not dir_esq

            elseif dir_esq == false then

                while not turtle.detectDown() do
                    turtle.select(2)
                    turtle.placeDown()
                end

                turtle.turnLeft()
                while not turtle.forward() do
                    turtle.dig()
                end
                turtle.turnLeft()
                dir_esq = not dir_esq

            end

        end

        while not turtle.detectDown() do
            turtle.select(2)
            turtle.placeDown()
        end
        
    end

    voltar(x,y,1)

end

function criar_caixas(x,y,z)

    if x == 1 and y == 1 and z == 1 then

        esvaziar_inv()

    else

    se_encher(x,y,z)
    se_esvaziar()

    for a = 1, z do
        
        for b = 1, y do

            for c = 1, x-1 do

                while not turtle.forward() do
                    turtle.dig()
                end

                se_esvaziar()

            end

            if y ~= b then

            if dir_esq == true then 
                
                turtle.turnRight()
                while not turtle.forward() do
                    turtle.dig()
                end
                turtle.turnRight()
                
               dir_esq = not dir_esq

            elseif dir_esq == false then

                turtle.turnLeft()
                while not turtle.forward() do
                    turtle.dig()
                end
                turtle.turnLeft()

                dir_esq = not dir_esq

            end

            end

        end

        voltar(x,y,1)

        if z > 1 then 

            while not turtle.up() do
                turtle.digUp()
            end

        end

    end

    if z > 1 then
        for a = 1, z do
            while not turtle.down() do
                turtle.digDown()
            end
        end
    end
    tampa_buraco(x,y)

    end
end

term.clear()
term.setCursorPos(1,1)

print("\n            [Bombinha "..versao.."]")
print("---------------------------------------\n")
print(" =[ Dimensoes ]=\n")

term.write("  PROFUNDIDADE: ")
local profundidade = read()

term.setCursorPos(1,10)
term.write("  LARGURA: ")
local largura = read()

term.setCursorPos(1,12)
term.write("  ALTURA: ")
local altura = read()

if largura == nil or profundidade == nil or altura == nil then 
    limparLinhas(6,12,6)
    print("Essas dimensoes nao sao compativeis, por favor coloque valores validos")
end

criar_caixas(tonumber(profundidade), tonumber(largura), tonumber(altura))
