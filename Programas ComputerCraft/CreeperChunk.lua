-- Creeper Chunk

repeat 

versao = "1.1"

term.clear()
term.setCursorPos(1,1)
print("\n               [Creeper Chunk "..versao.."]")
print("---------------------------------------------------")
print("\nLista de funcoes: \n\n [M] - Mover Manual\n [D] - Mover por Comando\n [Q] - Quarry\n [X] - Sair\n [C] - Creeper")

local event, key = os.pullEvent("key")

if key == keys.m then -- Botão M leva ao Mover Manual

  -- Mover Manualmente 

  term.clear()
  term.setCursorPos(1,1)
  print("\n              [Creeper Chunk "..versao.."]     [X] - Sair")
  print("---------------------------------------------------")
  print("                        |")
  print("Controles Quarry:       | Controles Broca: \n                        |")
  print(" [W] - Ir para Frente   |  [NUM 8] - Subir")
  print(" [S] - Ir para Atras    |  [NUM 2] - Descer")
  print(" [D] - Ir para Direita  |  [NUM 6] - Direita")
  print(" [A] - Ir para Esquerda |  [NUM 4] - Esquerda")
  print(" [SPACE] - Subir        |  [NUM 5] - Quebrar")
  print(" [SHIFT] - Descer       |  [NUM 1/3] - Max. Broca\n")
  print("Posicao Horizontal da Broca: 13\n")
  print("STATUS: Parado")

  local brocaH = 13

  while true do

  local event, key = os.pullEvent("key")
  local coresBroca = {
      quebrar = colors.white,
      subir = colors.magenta,
      descer = colors.orange,
      esquerda = colors.yellow,
      direita = colors.lightBlue
    }
  local coresQuarry = {
      subir = colors.cyan,
      descer = colors.purple,
      esquerda = colors.gray,
      direita = colors.lightGray,
      frente = colors.lime,
      atras = colors.pink
    }
    


  function limparLinhas(l1,l2)
      for i = l1, l2 do
          term.setCursorPos(1,i)
          term.clearLine()
      end 
    end

  function moverBroca(cor, vezes) do

      for i = 1, vezes do

      if cor == coresBroca.esquerda then 
          brocaH = brocaH-1
      elseif cor == coresBroca.direita then
          brocaH = brocaH+1
      end

      if brocaH > 13 then
        brocaH = 13
      elseif brocaH < 0 then
        brocaH = 0
      end
          
      limparLinhas(17, 17)
      print("STATUS: Movendo Broca...")
      rs.setBundledOutput("left", cor)
      os.sleep(0.5)
      rs.setBundledOutput("left", 0)
      limparLinhas(15, 17)
      print("STATUS: Carregando...")
      term.setCursorPos(1, 15)
      print("Posicao Horizontal da Broca: "..brocaH)
      os.sleep(0.5)

      end

      

      limparLinhas(17, 17)
      print("STATUS: Parado")
    end
    end
    
  function moverQuarryManual(cor, vezes) do
      for i = 1, vezes do
      limparLinhas(17, 17)
      print("STATUS: Movendo Quarry...")
      rs.setBundledOutput("left", cor)
      os.sleep(0.5)
      rs.setBundledOutput("left", 0)
      limparLinhas(17, 17)
      print("STATUS: Carregando...")
      os.sleep(2)
      end
      limparLinhas(17, 17)
      print("STATUS: Parado")
    end
    end

  --  
  -- MOVER QUARRY
  --
    if key == keys.w then -- W para mover a Quarry para frente
        moverQuarryManual(coresQuarry.frente, 1)
      elseif key == keys.s then -- S para mover a Quarry para atrás
        moverQuarryManual(coresQuarry.atras, 1)
      elseif key == keys.d then -- D para mover a Quarry para direita
        moverQuarryManual(coresQuarry.direita, 1)
      elseif key == keys.a then -- A para mover a Quarry para esquerda
        moverQuarryManual(coresQuarry.esquerda, 1)
      elseif key == keys.space then -- SPACE para mover a Quarry para cima
        moverQuarryManual(coresQuarry.subir, 1)
      elseif key == 42 or key == 54 then -- LSHIFT ou RSHIFT para mover a Quarry para baixo
        moverQuarryManual(coresQuarry.descer, 1)
      --  
      -- MOVER BROCA
      --
      elseif key == 72 then -- NUMPAD 8 para mover a Broca para cima
        moverBroca(coresBroca.subir, 1)
      elseif key == 80 then -- NUMPAD 2 para mover a Broca para baixo
        moverBroca(coresBroca.descer, 1)
      elseif key == 77 then -- NUMPAD 6 para mover a Broca para direita
        moverBroca(coresBroca.direita, 1)
      elseif key == 75 then -- NUMPAD 4 para mover a Broca para esquerda
        moverBroca(coresBroca.esquerda, 1)
      elseif key == 79 then -- NUMPAD 1 para mover a Broca até a extrema esquerda
        moverBroca(coresBroca.esquerda, brocaH) 
      elseif key == 81 then -- NUMPAD 3 para mover a Broca até a extrema direita
        moverBroca(coresBroca.direita, 13-brocaH) 
      elseif key == 76 then -- NUMPAD 5 para ativar os Block Breakers da Broca
        moverBroca(coresBroca.quebrar, 1) 
      elseif key == keys.x then -- X para voltar ao Menu Inicial
        break
      end
    end

elseif key == keys.d then -- Botão D leva ao Mover por Comando

  -- Mover por Comando
  term.clear()
  term.setCursorPos(1,1)
  print("\n              [Creeper Chunk "..versao.."]     [X] - Sair")
  print("---------------------------------------------------\n")
  print("Lista de Comandos: \n")
  print("  Esquerda   |    Esquerda Broca")
  print("  Direita    |    Direita Broca")
  print("  Frente     |    Cima Broca")
  print("  Atras      |    Baixo Broca")
  print("  Cima       |    Quebrar Broca")
  print("  Baixo      |    Chunk")
  print("\nPara onde voce quer ir?\n")

  term.write("> ")

  while true do

  local event, key = os.pullEvent("key")

  local coresBroca = {
    quebrar = colors.white,
    subir = colors.magenta,
    descer = colors.orange,
    esquerda = colors.yellow,
    direita = colors.lightBlue
    }
  local coresQuarry = {
    subir = colors.cyan,
    descer = colors.purple,
    esquerda = colors.gray,
    direita = colors.lightGray,
    frente = colors.lime,
    atras = colors.pink
    }

  function limparLinhas(l1,l2)
    for i = l1, l2 do
        term.setCursorPos(1,i)
        term.clearLine()
    end
    end

  function moverBroca(cor, vezes) do

    for i = 1, vezes do

      limparLinhas(17, 17)
      print("STATUS: Movendo Broca...")
      rs.setBundledOutput("left", cor)
      os.sleep(0.5)
      rs.setBundledOutput("left", 0)
      limparLinhas(17,17)
      print("STATUS: Carregando...")
      os.sleep(0.5)

    end
    limparLinhas(17, 17)
    print("STATUS: Parado")
    end
    end

  function moverQuarry(cor, vezes) do
    for i = 1, vezes do
    limparLinhas(17,17)
    print("STATUS: Movendo Quarry...")
    rs.setBundledOutput("left", cor)
    os.sleep(0.5)
    rs.setBundledOutput("left", 0)
    limparLinhas(17,17)
    print("STATUS: Carregando...")
    os.sleep(5)
    end
    end
   end

  --
  -- COMANDO
  --

  limparLinhas(17,17)
  term.write("> ")
  local comando = string.lower(read())

  local direcao = string.match(comando, "(%a+)[^broca$+]")
  local direcaoB = string.match(comando, "(broca)")
  local numeroVezes = tonumber(string.match(comando, "(%d+)"))
  --
  -- COMANDOS QUARRY
  --
  if direcao == "frente" and direcaoB ~= "broca" then -- Mover a Quarry para frente (numeroVezes) vezes
    moverQuarry(coresQuarry.frente, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif direcao == "atras" and direcaoB ~= "broca" then -- Mover a Quarry para atras (numeroVezes) vezes
    moverQuarry(coresQuarry.atras, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif direcao == "direita" and direcaoB ~= "broca" then -- Mover a Quarry para direita (numeroVezes) vezes
    moverQuarry(coresQuarry.direita, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif direcao == "esquerda" and direcaoB ~= "broca" then -- Mover a Quarry para esquerda (numeroVezes) vezes
    moverQuarry(coresQuarry.esquerda, numeroVezeseroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif (direcao == "cima" or direcao == "subir" or direcao == "acima") and direcaoB ~= "broca" then -- Mover a Quarry para cima (numeroVezes) vezes
    moverQuarry(coresQuarry.subir, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif (direcao == "baixo" or direcao == "descer" or direcao == "abaixo") and direcaoB ~= "broca" then -- Mover a Quarry para baixo (numeroVezes) vezes
    moverQuarry(coresQuarry.descer, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  --
  -- COMANDOS BROCAS
  --
  elseif direcao == "direita" and direcaoB == "broca" then -- Mover a Broca para direita (numeroVezes) vezes
    moverQuarry(coresBroca.direita, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif direcao == "esquerda" and direcaoB == "broca" then -- Mover a Broca para esquerda (numeroVezes) vezes
    moverQuarry(coresBroca.esquerda, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif (direcao == "cima" or direcao == "subir" or direcao == "acima") and direcaoB == "broca" then -- Mover a Broca para cima (numeroVezes) vezes
    moverQuarry(coresBroca.subir, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif (direcao == "baixo" or direcao == "descer" or direcao == "abaixo") and direcaoB == "broca" then -- Mover a Broca para baixo (numeroVezes) vezes
    moverQuarry(coresBroca.descer, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif (direcao == "quebrar" or direcao == "minerar" or direcao == "cavar") and direcaoB == "broca" then -- Ativa os Block Breakers da Broca (numeroVezes) vezes
    moverQuarry(coresBroca.quebrar, numeroVezes)
    limparLinhas(17,17)
    term.write("> ")
  elseif key == keys.x or direcao == "x" then -- X para voltar ao Menu Inicial
    break
  end

 end
elseif key == keys.q then -- Botão Q leva a Quarry
    -- Modo Quarry
  while true do 
    term.clear()
    term.setCursorPos(1,1)
    print("\n              [Creeper Chunk "..versao.."]     [X] - Sair")
    print("---------------------------------------------------\n")
    print("Quantas camadas voce deseja cavar?\n")
    term.write(" >")
    local camadas = read()

    if tonumber(camadas) == nil then
      break
    else

    -- ]]
    -- VARIAVEIS
    -- ]]

    local coresBroca = {
        quebrar = colors.white,
        subir = colors.magenta,
        descer = colors.orange,
        esquerda = colors.yellow,
        direita = colors.lightBlue
      }
    local coresQuarry = {
        subir = colors.cyan,
        descer = colors.purple,
        esquerda = colors.gray,
        direita = colors.lightGray,
        frente = colors.lime,
        atras = colors.pink
      }
    local statusFases = {
      "Movendo Broca...",
      "Movendo Quarry...",
      "Mineirando...",
      "Carregando...",
      "Resetando...",
      "Parado",
      "Terminado"
      } 

    local brocaH = 13
    local camadasCavadas = 0
    local porcentagem = 0
    local x = 0

    -- ]]
    -- FUNÇÕES
    -- ]]

    function limparLinhas(l1,l2,l3)
        for i = l1, l2 do
            term.setCursorPos(1,i)
            term.clearLine()
        end
        term.setCursorPos(1,l3)
      end -- Fim do Limpar Linhas
      
    function atualizarInfos()
      term.setCursorPos(1,11)
      term.clearLine()
      term.write("      | Posicao Horizontal da Broca: "..brocaH)
      term.setCursorPos(41,11)
      term.write("|")

      term.setCursorPos(1,13)
      term.clearLine()
      term.write("      | Camadas cavadas: "..camadasCavadas)
      term.setCursorPos(41,13)
      term.write("|")

      term.setCursorPos(1,15)
      term.clearLine()
      term.write("      | Porcentagem de Conclusao: "..porcentagem.." %")
      term.setCursorPos(41,15)
      term.write("|")
    end 

    function atualizarStatus(x)
      term.setCursorPos(1,18)
      term.clearLine()
      print("STATUS: "..statusFases[x])
      end

    function moverBroca(cor, vezes) do

        for i = 1, vezes do

        if cor == coresBroca.esquerda then 
            brocaH = brocaH-1
        elseif cor == coresBroca.direita then
            brocaH = brocaH+1
        elseif cor == coresBroca.descer then 
            camadasCavadas = camadasCavadas+1
        end

        if brocaH > 13 then
          brocaH = 13
        elseif brocaH < 0 then
          brocaH = 0
        end

      rs.setBundledOutput("left", cor)
      os.sleep(0.5)
      rs.setBundledOutput("left", 0)
      os.sleep(0.5)

        end

      end
      end -- Fim do Mover Broca

    function Reset(camadas) do
      atualizarStatus(5)
      if camadas < 2 then
          for i = 1, 13 do
            rs.setBundledOutput("left", coresBroca.direita)
            os.sleep(0.5)
            rs.setBundledOutput("left", 0)
            os.sleep(0.5)
            brocaH = brocaH+1
            atualizarInfos()
          end
        elseif math.fmod(camadas, 2) == 1 then
          moverBroca(coresBroca.subir, camadas-1)
                for d = 1, 13 do
                  rs.setBundledOutput("left", coresBroca.direita)
                  os.sleep(0.5)
                  rs.setBundledOutput("left", 0)
                  os.sleep(0.5)
                  atualizarInfos()
                end
        elseif math.fmod(camadas, 2) == 0 then
          moverBroca(coresBroca.subir, camadas)
                for d = 1, 13 do
                  rs.setBundledOutput("left", coresBroca.direita)
                  os.sleep(0.5)
                  rs.setBundledOutput("left", 0)
                  os.sleep(0.5)
                  atualizarInfos()
                end
      end
    end
    end

    function Quarry(camadas) do
      term.setCursorPos(1,2)
      term.clearLine()
      print("              [Creeper Chunk "..versao.."]                ")
        if camadas < 2 then
          atualizarStatus(3)
          for i = 1, 13 do
            moverBroca(coresBroca.quebrar, 1)
            moverBroca(coresBroca.esquerda, 1)
            porcentagem = tonumber(string.sub(tostring((100*(i/13))),0,3))
            atualizarInfos()
          end
          moverBroca(coresBroca.quebrar, 1)
          camadasCavadas = camadasCavadas+1 
          atualizarInfos()
          Reset(camadas)
          atualizarStatus(7)
            
        else
          atualizarStatus(3)
          for a = 1, math.floor(camadas/2) do
          for e = 1, 13 do
            moverBroca(coresBroca.quebrar, 1)
            moverBroca(coresBroca.esquerda, 1)
            x = x+1
            porcentagem = tonumber(string.sub(tostring((100*((camadasCavadas+x)/(camadas*13)))),0,3))
            atualizarInfos()
          end
            moverBroca(coresBroca.quebrar, 1)
            moverBroca(coresBroca.descer, 1)
            atualizarInfos()
          for d = 1, 13 do
            moverBroca(coresBroca.quebrar, 1)
            moverBroca(coresBroca.direita, 1)
            x = x+1
            porcentagem = tonumber(string.sub(tostring((100*(x/(camadas*13)))),0,3))
            atualizarInfos()
          end
            moverBroca(coresBroca.quebrar, 1)
            moverBroca(coresBroca.descer, 1)
            atualizarInfos()
            if a == math.floor(camadas/2) and math.fmod(camadas, 2) == 1 then
              camadasCavadas = camadasCavadas+1
              for e = 1, 13 do
                moverBroca(coresBroca.quebrar, 1)
                moverBroca(coresBroca.esquerda, 1)
                x = x+1
                porcentagem = tonumber(string.sub(tostring((100*(x/(camadas*13)))),0,3))
                atualizarInfos()
              end
              moverBroca(coresBroca.quebrar, 1)  
            end
            Reset(camadas)
            atualizarInfos()
            atualizarStatus(7)
          end

        end

    end
    end


    ---
    ---  Quarry Menu
    ---

    limparLinhas(6,8,7)

    print("           <====[ Modo Quarry ]====>\n\n") -- 7
    print("      -----------------------------------") -- 10
    print("      | Posicao Horizontal da Broca: 13 |") -- 11
    print("      |                                 |") -- 12
    print("      | Camadas cavadas: 0              |") -- 13
    print("      |                                 |") -- 14
    print("      | Porcentagem de Conclusao: 0 %   |") -- 15
    print("      -----------------------------------\n") -- 16
    atualizarStatus(6) -- 18

    Quarry(tonumber(camadas))
    end -- Fim do IF 13
  end
    function esperando_sair()
      while true do
        term.setCursorPos(1,2)
        os.sleep(0.5)
        term.clearLine()
        term.write("              [Creeper Chunk "..versao.."]                ")
        os.sleep(0.5)
        term.setCursorPos(1,2)
        term.clearLine()
        term.write("              [Creeper Chunk "..versao.."]     [X] - Sair")
      end
    end
    function esperando_x()
      repeat
          local event, key = os.pullEvent("key")
      until key == keys.x
      
  
  parallel.waitForAny(esperando_sair, esperando_x)
  end

elseif key == keys.c then -- Botão C leva ao Creeper
  term.clear()
  term.setCursorPos(1,1)
  print("    :::::::::::       :::::::::::    ")
  os.sleep(0.2)
  print("    :::::::::::       :::::::::::    ")
  os.sleep(0.2)
  print("    :::::::::::       :::::::::::    ")
  os.sleep(0.2)
  print("    :::::::::::       :::::::::::    ")
  os.sleep(0.2)
  print("    :::::::::::       :::::::::::    ")
  os.sleep(0.1)
  print("                                     ")
  os.sleep(0.1)
  print("            ::::::::::::           ")
  os.sleep(0.2)
  print("            ::::::::::::           ")
  os.sleep(0.2)    
  print("       ::::::::::::::::::::::       ")
  os.sleep(0.2)
  print("       ::::::::::::::::::::::       ")
  os.sleep(0.2)
  print("       ::::::::::::::::::::::       ")
  os.sleep(0.2)
  print("       ::::::::::::::::::::::       ")
  os.sleep(0.2)
  print("       ::::::::      ::::::::      ")
  os.sleep(0.2)
  print("       ::::::::      ::::::::  ")

  print("\n\n[X] - Sair")
  repeat 
      local event, key = os.pullEvent()
  until key == keys.x
  os.sleep(0.1)
end

until key == keys.x 

term.clear()
term.setCursorPos(1,1)

