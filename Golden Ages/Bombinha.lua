-->> Bombinha

-->> Glossario:

-- SPT: Suplementos Para Turtles
-- SLP: Sistema Logistic Pipes

versao = 1.0

combustivel = turtle.getFuelLevel()

function encher_tanque(f) -- Pega 1 stack de Combustivel do Ender Chest SPT 
    if combustivel == 0 or combustivel < 96 then

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
    
end

function esvaziar_inv() -- Transfere todos os itens dos slots 2-14 para o Ender Chest SLP
    if turtle.getItemSpace(14) < 64 then

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
end

function criar_caixas(x,y,z)

    if x == nil or y == nil or z == nil then
        print("Sem dimensoes suficientes para criar uma caixa. Por favor insira os valores para X, Y e Z")
    end

    for c = 1, z do 

        for b = 1, y do 

            for a = 1, x do
                
            end

        end

    end

end
