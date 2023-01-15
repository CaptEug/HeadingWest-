CitiesAndFactories = {}
Cities = {}

function CitiesAndFactories:load()
    --citylist
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
    

    --tanklist
    T72A = {
        name = 'T-72a',
        line_image = T72A_line,
        accessories = { 
            {name = 'Kontakt_1', line_image = T72A_kontakt1_line, tag = 'Armor'},
        }
    }
    table.insert(UVZ.tanklist, T72A)

    T72B = {
        name = 'T-72b',
        line_image = T72B_line,
        accessories = { 
            {name = 'Kontakt_1', line_image = T72B_kontakt1_line, tag = 'Armor'},
            {name = 'Kontakt_5', line_image = T72B_kontakt5_line, tag = 'Armor'}
        }
    }
    table.insert(UVZ.tanklist, T72B)

end