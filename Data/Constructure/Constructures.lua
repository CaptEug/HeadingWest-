Constructures = {
    OilDriller = {
        name = 'Oil Driller',
        type = 'resource',
        requirement = 'oil field',
        width = 288,
        length = 288,
        steel_cost = 20,
        oil_cost = 0,
        steel_production = 0,
        oil_productioon = 1,
        hitpoint = 10,
        armorthickness = 0,
        image = Image_in_progress,
        anime_sheet = Image_in_progress,
        buildtime = 10,
        fixedbuildtime = 10
    },

    Maxim_Gorky = {
        name = 'Maxim Gorky II',
        type = 'defence',
        requirement = 'none',
        width = 288,
        length = 288,
        gun_offset = 0,
        gun_offset2 = 0,
        gun_offset3 = 0,
        steel_cost = 100,
        oil_cost = 50,
        hitpoint = 100,
        armorthickness = 305,
        ammorack = {
            {name = '305mmHE', type = 'HE', pentype = 'CE', velocity = 1000, mass = 0.3, pen = 305, TNT_eq = 61}
        },
        image = Image_in_progress,
        anime_sheet = Image_in_progress,
        buildtime = 30,
        fixedbuildtime = 30
    }
}

table.insert(Nizhny_Tagil.constructurelist, Constructures.OilDriller)
table.insert(Nizhny_Tagil.constructurelist, Constructures.Maxim_Gorky)

