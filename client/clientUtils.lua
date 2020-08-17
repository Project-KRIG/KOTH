KOTH.CreateObject = function(object, coords, pitch, roll, yaw)
    local object = GetHashKey(object)

    RequestModel(object)
    if not HasModelLoaded(object) then
        Citizen.Wait(100)
    end
    SetEntityRotation(object, pitch, roll, yaw, 0, true)
    KOTH.Object = CreateObject(object, coords.x, coords.y, coords.z, false, false, true)
end

KOTH.BuildBase = function()
    for k,v in pairs(KOTH.Teams) do
        local pos =  vector3(v.ShopLocation.x, v.ShopLocation.y, v.ShopLocation.z)
        KOTH.CreateObject('gr_prop_gr_bench_01a', pos)
    end
end