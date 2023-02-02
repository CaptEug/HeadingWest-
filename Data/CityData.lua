CityData = {}
Cities = {}
Alltanks = {}

function CityData:load()
    UVZ = {
        x = 1000,
        y = 500,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        state ='Captured',
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
        state ='Battlefield',
        map = 1,
        tankstock = {}
    }
    table.insert(Cities, Berlin)
end