CitiesAndFactories = {}
Cities = {}

function CitiesAndFactories:load()
    UVZ = {
        x = 3100,
        y = 1200,
        name = 'Uralvagonzavod',
        icon = UVZ_Icon,
        type='Factory',
        map = 2,
        tanklist = {}
    }
    table.insert(Cities, UVZ)

    Berlin = {
        x = 1835,
        y = 1345,
        name = 'Berlin',
        icon = Berlin_Bear,
        type='Battlefield',
        map = 1
    }
    table.insert(Cities, Berlin)
end