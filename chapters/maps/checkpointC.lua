return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 40,
  tilewidth = 128,
  tileheight = 128,
  nextlayerid = 7,
  nextobjectid = 92,
  properties = {},
  tilesets = {
    {
      name = "berlintiles",
      firstgid = 1,
      class = "",
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      columns = 6,
      image = "berlintiles.png",
      imagewidth = 768,
      imageheight = 768,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 128,
        height = 128
      },
      properties = {},
      wangsets = {},
      tilecount = 36,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      id = 1,
      name = "Ground",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 16, 16, 7, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 16, 16, 7, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 16, 16, 7, 25, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8,
        32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 33, 9, 16, 16, 16, 16, 16, 7, 31, 32, 32, 32, 32, 32, 32, 32, 32, 32, 33, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 16, 16, 16, 16, 16, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 16, 16, 16, 13, 14, 14, 14, 14, 14,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 1, 2, 2, 2, 2, 2,
        8, 8, 8, 8, 8, 19, 20, 20, 20, 20, 20, 20, 21, 9, 16, 16, 16, 7, 19, 20, 20, 20, 21, 8, 8, 19, 20, 20, 20, 21, 9, 16, 16, 16, 7, 8, 8, 8, 8, 19,
        8, 8, 8, 8, 8, 25, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 27, 8, 8, 25, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        10, 8, 8, 8, 8, 25, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 32, 33, 8, 8, 31, 32, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        16, 10, 8, 8, 8, 25, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 27, 8, 8, 8, 8, 8, 8, 25, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        16, 16, 10, 8, 8, 25, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 27, 8, 8, 8, 8, 8, 8, 25, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        16, 16, 16, 10, 8, 31, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 27, 8, 8, 8, 8, 8, 8, 25, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        5, 16, 16, 16, 10, 8, 31, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 20, 21, 8, 8, 19, 20, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 25,
        8, 5, 16, 16, 16, 10, 8, 31, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 27, 8, 8, 25, 26, 26, 26, 27, 9, 16, 16, 16, 7, 19, 21, 8, 8, 25,
        21, 8, 5, 16, 16, 16, 10, 8, 31, 32, 32, 32, 33, 9, 16, 16, 16, 7, 31, 32, 32, 32, 33, 8, 8, 31, 32, 32, 32, 33, 9, 16, 16, 16, 7, 31, 33, 8, 8, 31,
        26, 21, 8, 5, 16, 16, 16, 10, 14, 14, 14, 14, 14, 15, 16, 16, 16, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 16, 16, 16, 13, 14, 14, 14, 14, 14,
        26, 26, 21, 8, 5, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        26, 26, 26, 21, 8, 5, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        26, 26, 26, 26, 21, 8, 5, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        26, 26, 26, 26, 27, 8, 8, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 1, 2, 2, 2, 2, 2,
        26, 26, 26, 26, 27, 8, 8, 19, 20, 20, 20, 20, 21, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8, 8, 19, 20, 20, 20, 20, 21, 9, 16, 16, 16, 7, 19, 20, 20, 20, 20,
        26, 26, 26, 26, 27, 8, 8, 31, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8, 8, 25, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        32, 32, 32, 32, 33, 8, 8, 8, 31, 26, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8, 8, 25, 26, 19, 21, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 31, 26, 26, 27, 9, 16, 16, 16, 7, 8, 8, 8, 8, 8, 8, 25, 26, 31, 33, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 31, 26, 27, 9, 16, 16, 16, 7, 19, 20, 20, 20, 21, 8, 25, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 19, 20, 20, 21, 8, 8, 8, 8, 8, 31, 33, 9, 16, 16, 16, 7, 25, 26, 26, 26, 27, 20, 31, 32, 32, 32, 32, 33, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 25, 26, 26, 27, 8, 8, 8, 8, 8, 8, 8, 9, 16, 16, 16, 7, 25, 26, 26, 26, 27, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 25, 26, 26, 27, 8, 8, 8, 8, 8, 8, 8, 9, 16, 16, 16, 7, 25, 26, 26, 26, 27, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        8, 8, 31, 32, 32, 33, 8, 8, 8, 8, 8, 8, 8, 9, 16, 16, 16, 7, 31, 32, 32, 32, 33, 32, 32, 32, 32, 32, 32, 33, 9, 16, 16, 16, 7, 31, 32, 32, 32, 32,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 16, 16, 16, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 16, 16, 16, 13, 14, 14, 14, 14, 14,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16, 16,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 16, 16, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 16, 16, 16, 1, 2, 2, 2, 2, 2,
        20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21, 9, 16, 16, 16, 16, 16, 7, 19, 20, 20, 21, 8, 8, 8, 19, 20, 20, 21, 9, 16, 16, 16, 7, 19, 20, 20, 20, 20,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 16, 16, 7, 25, 26, 26, 27, 20, 20, 20, 25, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26,
        26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 26, 27, 9, 16, 16, 16, 16, 16, 7, 25, 26, 26, 27, 26, 26, 26, 25, 26, 26, 27, 9, 16, 16, 16, 7, 25, 26, 26, 26, 26
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      id = 4,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0,
        0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 17, 18, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0,
        0, 0, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 18, 0, 11, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      id = 3,
      name = "Sky",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 36, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 24, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 30, 22, 23, 24,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 36, 28, 29, 30,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 36,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 22, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 26, 26, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 28, 29, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 32, 32, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 34, 35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 20, 20, 20, 20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 26, 26, 26, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 32, 32, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 28, 29, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 34, 35, 36, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "Buildings",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 1536,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2432,
          y = 0,
          width = 1408,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 4736,
          width = 1536,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 256,
          y = 3584,
          width = 512,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2432,
          y = 4736,
          width = 512,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2944,
          y = 4864,
          width = 384,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3328,
          y = 4736,
          width = 512,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 4736,
          width = 640,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 2944,
          width = 640,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3072,
          y = 2944,
          width = 768,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2304,
          y = 3456,
          width = 640,
          height = 640,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2944,
          y = 3584,
          width = 128,
          height = 512,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 2048,
          width = 256,
          height = 256,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4992,
          y = 1152,
          width = 128,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2304,
          y = 1152,
          width = 384,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3456,
          y = 1152,
          width = 384,
          height = 1152,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2688,
          y = 1152,
          width = 256,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3200,
          y = 1152,
          width = 256,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2688,
          y = 1920,
          width = 256,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3200,
          y = 1920,
          width = 256,
          height = 384,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "Obstacles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 39,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1664,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1920,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2176,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1792,
          y = 128,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 43,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2048,
          y = 128,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2432,
          y = 640,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2432,
          y = 896,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2688,
          y = 768,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1536,
          y = 2432,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 60,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1280,
          y = 2560,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1536,
          y = 2688,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2304,
          y = 2432,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2560,
          y = 2560,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2304,
          y = 2688,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1408,
          y = 4224,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1152,
          y = 4352,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1408,
          y = 4480,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1664,
          y = 4736,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1920,
          y = 4736,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2176,
          y = 4736,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 71,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1792,
          y = 4992,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 72,
          name = "",
          class = "",
          shape = "rectangle",
          x = 2048,
          y = 4992,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 4224,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4736,
          y = 4352,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 4480,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3968,
          y = 4608,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4224,
          y = 4608,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4096,
          y = 4864,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 2432,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4736,
          y = 2560,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 81,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 2688,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 640,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4480,
          y = 896,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4736,
          y = 768,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "",
          class = "",
          shape = "rectangle",
          x = 3968,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 88,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4224,
          y = 384,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          class = "",
          shape = "rectangle",
          x = 4096,
          y = 128,
          width = 128,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
