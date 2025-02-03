-- TODO: 
-- Documentar o Mover por Comandos e algumas partes do Mover Manual

-- [ INTRO ]

local intervalo = 0.06
term.clear()
term.setCursorPos(1,3)
print("          ::::::::::         :::::::::::    ")
os.sleep(intervalo)
print("          ::::::::::         :::::::::::    ")
os.sleep(intervalo)
print("          ::::::::::         :::::::::::    ")
os.sleep(intervalo)
print("          ::::::::::         :::::::::::    ")
os.sleep(intervalo)
print("          ::::::::::         :::::::::::    ")
os.sleep(0.04)
print("                                      ")
os.sleep(0.04)
print("                   :::::::::::           ")
os.sleep(intervalo)
print("                   :::::::::::           ")
os.sleep(intervalo)    
print("            :::::::::::::::::::::::::       ")
os.sleep(intervalo)
print("            :::::::::::::::::::::::::       ")
os.sleep(intervalo)
print("            :::::::::::::::::::::::::       ")
os.sleep(intervalo)
print("            :::::::          ::::::::  ")
os.sleep(intervalo)
print("            :::::::          ::::::::      ")
os.sleep(intervalo)
print("            :::::::          ::::::::  ")
os.sleep(intervalo)
print("            :::::::          ::::::::  ")
os.sleep(intervalo*10)

--[ VARIAVEIS ]

local largura, altura = term.getSize() -- 51, 19
local versao = 1.2

local coords_broca = {X = 0, Y = 0, Z = 0}
local coords_quarry = {X = 0, Y = 0, Z = 0}
local broca_max_esq = 0
local broca_max_dir = 0 
local broca_min_alt = 0 
local pos_broca = 0
local primeira_vez = true

local coresQuarry = {
    frente = colors.lime,
    atras = colors.pink,
    direita = colors.lightGray,
    esquerda = colors.gray,
    subir = colors.cyan,
    descer = colors.purple,
    subirB = colors.magenta,
    descerB = colors.orange,
    direitaB = colors.lightBlue,
    esquerdaB = colors.yellow,
    quebrar = colors.white
}

local comandos = {
    "Frente",
    "Atras",
    "Direita",
    "Esquerda",
    "Subir",
    "Descer",
    "Broca",
    "Chunk"
}

--[ FUNÇÕES ]

function menus(opc)

    term.clear()

    for i = 2, altura do                   -- Barras verticais

        term.setCursorPos(2,i)             -- Cria as barras verticais
        write("|")                         -- Barras da esquerda
        term.setCursorPos(largura-1,i)     --
        write("|")                         -- Barras da direita

    end

    for i = 1, altura, altura-1 do
        term.setCursorPos(2,i)
        write("+-----------------------------------------------+") -- Cria as barras horizontais
    end

    if (opc == 0) then
        
        term.setCursorPos(2,10)
        write("+-----------------------------------------------+") -- Cria a barra horizontal do meio no menu principal

        term.setCursorPos(19,5)
        write("Creeper Chunk")                                     -- 
        term.setCursorPos(22,7)                                    -- Cria o titulo e a versão do programa
        print("[ ",tostring(versao)," ]")                          --

        term.setCursorPos(6,13)
        write("[A] - Mover Manual       [B] - Comandos")           --
        term.setCursorPos(6,16)                                    -- Opções
        write("[C] - Quarry             [D] - Sair")               --

    elseif (opc == 1) then
        
            term.setCursorPos(20,3)
            write("Mover Manual")
            term.setCursorPos(2,5)
            write("+---[ Quarry ]----------+---[ Broca ]-----------+")
            term.setCursorPos(26,altura)
            write("+")

            term.setCursorPos(6,7)
            write("[W] - Frente             [^] - Subir")
            term.setCursorPos(6,8)
            write("[S] - Atras              [V] - Descer")
            term.setCursorPos(6,9)
            write("[D] - Direita            [>] - Direita")
            term.setCursorPos(6,10)
            write("[A] - Esquerda           [<] - Esquerda")
            term.setCursorPos(6,11)
            write("[SPACE] - Subir          [ENTER] - Quebrar")
            term.setCursorPos(6,12)
            write("[SHIFT] - Descer         [PgU/D] - Extremos")
            term.setCursorPos(6,13)
            write("                         [HOME] - RST Broca")
        
            for j = altura-1, 6, -1 do                   
                term.setCursorPos(26,j)             
                write("|")                        
            end

    elseif (opc == 2) then

        term.setCursorPos(17,3)
        write("Mover por Comandos")
        term.setCursorPos(5,6)
        write("[ Comandos ]        [ Complementos ]")

        for i = 5, 15, 10 do
            term.setCursorPos(2,i)
            write("+-----------------------------------------------+")
            term.setCursorPos(22,i)
            write("+")
            end

        for i = 6, 14 do
            term.setCursorPos(22,i)
            write("|") 
        end

        for i = 1, #comandos do
            if (i < 7) then
                term.setCursorPos(7,7+i)
                write(comandos[i])
            else
                term.setCursorPos(26,1+i)
                write(comandos[i])
            end
        end

        for i = 16, 19 do
            term.setCursorPos(1,i)
            term.clearLine()
        end

        term.setCursorPos(4,17)
        write("Para onde voce deseja ir?\n")

    
    elseif (opc == 3) then

        term.setCursorPos(23,3) 
        write("Quarry")
        term.setCursorPos(2,5)
        write("+-----------------------------------------------+")
        -- term.setCursorPos(9,9)
        -- write("Quantas camadas voce deseja cavar?")
        term.setCursorPos(12,7)
        write("Qual modo voce deseja usar?")
        term.setCursorPos(8,9)
        write("[1] - Automatico       [2] - Manual")
        term.setCursorPos(8,10)
        write("[3] - Furar")
        -- term.setCursorPos(23,11)
        -- write("> ")

    end

end

function atualizar_coords()
    rednet.open("right")

    while (coords_quarry.X == 0 or coords_quarry.Y == 0) do
        coords_quarry.X, coords_quarry.Y, coords_quarry.Z = gps.locate(3)    
    end

    broca_max_dir = coords_quarry.X + 10
    broca_max_esq = coords_quarry.X - 3
    broca_min_alt = coords_quarry.Y - 18

    rednet.send(8, "coords")

    local id, msg, dist, coordenadas

        repeat

            id, msg, dist = rednet.receive()

            if (msg ~= "PING") then
                coordenadas = msg
            end
        
        until (msg ~= "PING")

    rednet.close("right")
    
    coords_broca.X = tonumber(string.match(coordenadas, "^%d+"))
    coords_broca.Y = tonumber(string.match(coordenadas, " %d+ "))
    coords_broca.Z = tonumber(string.match(coordenadas, "%d+$"))

    pos_broca = coords_broca.X - broca_max_esq
 
end

function moverQuarry(cor, vezes, modo)

    if (vezes == nil) then
        vezes = 1
    elseif (vezes == 0) then
        return false
    end

    if (modo == nil or modo == "") then
        modo = "comando"
    end

    local t

    if (cor >= 32 and modo == "comando") then
        t = 3
    else 
        t = 0.5
    end

    for i = 1, vezes do
        rs.setBundledOutput("left", cor)
        os.sleep(0.5)
        rs.setBundledOutput("left", 0)
        os.sleep(t)
    end

    return true

end

function moverManual()

    repeat 

        local event, key = os.pullEvent("key")
    
        if (key == keys.w) then
                broca_max_esq = 0
                broca_max_dir = 0
                moverQuarry(coresQuarry.frente, 1, "manual")
            elseif (key == keys.s) then
                broca_max_esq = 0
                broca_max_dir = 0
                moverQuarry(coresQuarry.atras, 1, "manual")
            elseif (key == keys.d) then
                moverQuarry(coresQuarry.direita, 1, "manual")
            elseif (key == keys.a) then
                moverQuarry(coresQuarry.esquerda, 1, "manual")
            elseif (key == keys.space) then
                broca_min_alt = 0
                moverQuarry(coresQuarry.subir, 1, "manual")
            elseif (key == keys.leftShift) then
                broca_min_alt = 0
                moverQuarry(coresQuarry.descer, 1, "manual")
            elseif (key == keys.up) then
                moverQuarry(coresQuarry.subirB, 1, "manual")
            elseif (key == keys.down) then
                moverQuarry(coresQuarry.descerB, 1, "manual")
            elseif (key == keys.right) then
                moverQuarry(coresQuarry.direitaB, 1, "manual")
            elseif (key == keys.left) then
                moverQuarry(coresQuarry.esquerdaB, 1, "manual")
            elseif (key == keys.enter) then
                moverQuarry(coresQuarry.quebrar, 1, "manual") 
            elseif (key == keys.pageUp) then
                atualizar_coords()
                moverQuarry(coresQuarry.direitaB, broca_max_dir - coords_broca.X, "manual")
            elseif (key == keys.pageDown) then
                atualizar_coords()
                moverQuarry(coresQuarry.esquerdaB, coords_broca.X - broca_max_esq, "manual")   
            elseif (key == keys.home) then
                atualizar_coords()
                moverQuarry(coresQuarry.subirB, broca_min_alt - coords_broca.Y, "manual")   
        end
    
    until (key == keys.x)

end

function moverComando()

    repeat

        atualizar_coords()

        term.setCursorPos(4,18)
        write("> ") 
        local ler_comando = (string.lower(tostring(read())))
        local function acharComandos(n)

            local function tirarEspaco(str)
                return string.match(tostring(str), "(%S+)")
            end

            if (n == 1) then

                for i = 1, #comandos-1 do 
                    local pegar_comando = string.match(ler_comando, tostring("^"..string.lower(comandos[i]).." ?") )
                    local sem_espaco = tirarEspaco(pegar_comando)

                    if (string.lower(comandos[i]) == sem_espaco) then
                        return sem_espaco
                    end
                end
            
            elseif (n == 2) then
                local com_broca = string.match(ler_comando, " +broca ?")
                local com_chunk = string.match(ler_comando, " +chunks? ?")

                if (com_broca == nil) then 
                    return tirarEspaco(tostring(com_chunk))
                else
                    return tirarEspaco(tostring(com_broca))
                end 
                
            end
            
        end
        
        local parametros_comando = {acharComandos(1), acharComandos(2), tonumber(string.match(ler_comando, "%d+$"))}

        if (parametros_comando[1] == nil) then
            print("erro sem parametro 1")
        else

            if (parametros_comando[2] == "broca") then

                if (parametros_comando[1] == "direita") then
                    moverQuarry(coresQuarry.direitaB, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "esquerda") then
                    moverQuarry(coresQuarry.esquerdaB, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "subir" or parametros_comando[1] == "atras") then
                    moverQuarry(coresQuarry.subirB, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "descer" or parametros_comando[1] == "frente") then
                    moverQuarry(coresQuarry.descerB, parametros_comando[3], "comando")
                end

            elseif (parametros_comando[2] == "chunk" or parametros_comando[2] == "chunks") then 

                if (parametros_comando[1] == "frente") then 
                    broca_max_esq = 0
                    broca_max_dir = 0
                    moverQuarry(coresQuarry.frente, parametros_comando[3]*16, "comando")
                elseif (parametros_comando[1] == "atras") then
                    broca_max_esq = 0
                    broca_max_dir = 0
                    moverQuarry(coresQuarry.atras, parametros_comando[3]*16, "comando")
                elseif (parametros_comando[1] == "direita") then
                    moverQuarry(coresQuarry.direita, parametros_comando[3]*16, "comando")
                elseif (parametros_comando[1] == "esquerda") then
                    moverQuarry(coresQuarry.esquerda, parametros_comando[3]*16, "comando")
                elseif (parametros_comando[1] == "subir") then
                    broca_min_alt = 0
                    moverQuarry(coresQuarry.subir, parametros_comando[3]*16, "comando")
                elseif (parametros_comando[1] == "descer") then
                    broca_min_alt = 0
                    moverQuarry(coresQuarry.descer, parametros_comando[3]*16, "comando")
                end

            else

                if (parametros_comando[1] == "frente") then 
                    moverQuarry(coresQuarry.frente, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "atras") then
                    moverQuarry(coresQuarry.atras, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "direita") then
                    moverQuarry(coresQuarry.direita, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "esquerda") then
                    moverQuarry(coresQuarry.esquerda, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "subir") then
                    moverQuarry(coresQuarry.subir, parametros_comando[3], "comando")
                elseif (parametros_comando[1] == "descer") then
                    moverQuarry(coresQuarry.descer, parametros_comando[3], "comando")
                end

            end 
        
        end

    until (ler_comando == "x")
end

function Quarry()

    local function limpar_linhas() 

        for i = 6, 18 do 
            term.setCursorPos(1,i)
            term.clearLine()
        end 

        for i = 6, altura-1 do                   -- Barras verticais

            term.setCursorPos(2,i)             -- Cria as barras verticais
            write("|")                         -- Barras da esquerda
            term.setCursorPos(largura-1,i)     --
            write("|")                         -- Barras da direita
    
        end

    end

    atualizar_coords()
    local event, key = os.pullEvent("key")
    local ler_camadas
    
    if (key == 2) then

        limpar_linhas() 
        term.setCursorPos(16,3) 
        write("Quarry - Automatico")
        ler_camadas = coords_broca.Y - 7

    elseif (key == 3) then

        limpar_linhas() 
        term.setCursorPos(18,3) 
        write("Quarry - Manual")
        term.setCursorPos(8,9)
        write("Quantas camadas voce deseja cavar? ")
        term.setCursorPos(23,11)
        write("> ")
        ler_camadas = read() 
        ler_camadas = tonumber(ler_camadas)

        if (ler_camadas == nil or ler_camadas <= 0) then
            return false
        end
        limpar_linhas() 

    elseif (key == 4) then

        limpar_linhas() 
        term.setCursorPos(18,3) 
        write("Quarry - Furar  ")
        term.setCursorPos(8,8)
        write("Camada Atual: ")
        term.setCursorPos(8,10)
        write("Camadas Restantes: ") 
        term.setCursorPos(8,12)
        write("Progressao: ") 
        term.setCursorPos(8,14)
        write("Status: ") 
        ler_camadas = coords_broca.Y - 8
        
        for i = 1, ler_camadas do

            term.setCursorPos(22,8)
            write(i)
            term.setCursorPos(27,10)
            write(ler_camadas-i)
            term.setCursorPos(20,12)
            write("     ")
            term.setCursorPos(20,12)
            write(string.format("%3d %%",math.floor((i/ler_camadas)*100)))
            term.setCursorPos(16,14)
            write("Cavando...")

            moverQuarry(coresQuarry.quebrar)
            moverQuarry(coresQuarry.descerB)
        end
        moverQuarry(coresQuarry.quebrar)

        term.setCursorPos(16,14)
        write("Resetando Quarry...")
        atualizar_coords()
        moverQuarry(coresQuarry.subirB, broca_min_alt - coords_broca.Y, "manual")
        moverQuarry(coresQuarry.direitaB, broca_max_dir - coords_broca.X, "manual")

        return true

    else
        return false
    end
    
    local lado_broca

    if (pos_broca == 13) then
        lado_broca = true
    elseif (pos_broca == 0) then
        lado_broca = false
    elseif (pos_broca >= 6) then
        moverQuarry(coresQuarry.direitaB, broca_max_dir - coords_broca.X, "manual")
        lado_broca = true
    elseif (pos_broca < 6) then
        moverQuarry(coresQuarry.esquerdaB, coords_broca.X - broca_max_esq, "manual")
        lado_broca = false
    end

    term.setCursorPos(8,8)
    write("Camada Atual: ")
    term.setCursorPos(8,10)
    write("Camadas Restantes: ") 
    term.setCursorPos(8,12)
    write("Progressao: ") 
    term.setCursorPos(8,14)
    write("Status: ") 
    
    for c = 1, ler_camadas do 

        term.setCursorPos(22,8)
        write(c)
        term.setCursorPos(27,10)
        write(ler_camadas-c)
        term.setCursorPos(20,12)
        write("     ")
        term.setCursorPos(20,12)
        write(string.format("%3d %%",math.floor((c/ler_camadas)*100)))
        term.setCursorPos(16,14)
        write("Cavando...")

        if (lado_broca == true) then

            for i = 1, 13 do

                moverQuarry(coresQuarry.quebrar)
                moverQuarry(coresQuarry.esquerdaB)
    
            end
            moverQuarry(coresQuarry.quebrar)
            moverQuarry(coresQuarry.descerB)

        elseif (lado_broca == false) then

            for i = 1, 13 do

                moverQuarry(coresQuarry.quebrar)
                moverQuarry(coresQuarry.direitaB)
    
            end
            moverQuarry(coresQuarry.quebrar)
            moverQuarry(coresQuarry.descerB)
            
        end
        
        lado_broca = not lado_broca

    end

    term.setCursorPos(16,14)
    write("Resetando Quarry...")
    atualizar_coords()
    moverQuarry(coresQuarry.subirB, broca_min_alt - coords_broca.Y, "manual")
    moverQuarry(coresQuarry.direitaB, broca_max_dir - coords_broca.X, "manual")

end

--[ INICIO ]

menus(0)

repeat

atualizar_coords()
local event, key = os.pullEvent("key")

if (key == keys.a) then
        menus(1)
        moverManual() 
        menus(0)
    elseif (key == keys.b) then
        menus(2)
        moverComando()
        menus(0)
    elseif (key == keys.c or key == keys.q) then
        menus(3)
        Quarry()
        menus(0)
end

if (primeira_vez == true) then
    primeira_vez = false
end

until (key == keys.x or key == keys.d)
rednet.close("right")