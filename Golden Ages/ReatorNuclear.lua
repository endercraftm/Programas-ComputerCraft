-- Reator Novo Mundo

versao = 0.1 

os.unloadAPI("sensors")
os.loadAPI("/rom/apis/sensors")

local side = sensors.getController()
local sensor = sensors.getSensors(side)
local probe = sensors.getProbes(side, sensor[1])
local target = sensors.getAvailableTargetsforProbe(side, sensor[1], probe[2])
local reading = sensors.getSensorReadingAsDict(side, sensor[1], target[1], probe[2])
local infos = {reading.heat,reading.size,reading.output}

-- Testes temporários

print("  [ Infos ]\n")
print("Calor: "..tostring(infos[1]))
print("Tamanho: "..tostring(infos[2]))
print("Saida de Energia: "..tostring(infos[3])) 