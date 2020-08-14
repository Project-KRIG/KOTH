KOTH.CreateObject = function(object, x, y ,z )
    local object = GetHashKey(object)

    RequestModel(object)
    if not HasModelLoaded(object) then
        Citizen.Wait(100)
    end
    KOTH.Object = CreateObject(object, x, y, z, true, false, true)
end