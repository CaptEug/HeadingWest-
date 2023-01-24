CitiesAndFactories = {}
Cities = {}
Alltanks = {}

function CitiesAndFactories:load()
    UVZ = {
        x = 3100,
        y = 1200,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        type='Factory',
        map = 2,
        tanklist = {},
        tankstock = {}
    }
    table.insert(Cities, UVZ)

    Berlin = {
        x = 1835,
        y = 1345,
        name = 'Berlin',
        icon = Berlin_icon,
        type='Battlefield',
        map = 1,
        tankstock = {}
    }
    table.insert(Cities, Berlin)
end