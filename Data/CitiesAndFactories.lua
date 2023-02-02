CitiesAndFactories = {}
Cities = {}
Alltanks = {}

function CitiesAndFactories:load()
    UVZ = {
        x = 1000,
        y = 500,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        type='Factory',
        map = 3,
        tanklist = {},
        tankstock = {}
    }
    table.insert(Cities, UVZ)

    Berlin = {
        x = 500,
        y = 500,
        name = 'Berlin',
        icon = Berlin_icon,
        type='Battlefield',
        map = 1,
        tankstock = {}
    }
    table.insert(Cities, Berlin)
end