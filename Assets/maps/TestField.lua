return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 1,
  height = 1,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 3,
  nextobjectid = 2,
  properties = {},
  tilesets = {
    {
      name = "Basic Tiles",
      firstgid = 1,
      class = "",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 10,
      image = "Tiles.png",
      imagewidth = 320,
      imageheight = 320,
      transparentcolor = "#ff00ff",
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      wangsets = {},
      tilecount = 100,
      tiles = {}
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Boundary",
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1280,
          y = 832,
          width = 3072,
          height = 2048,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      id = 1,
      name = "Ground",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 1280,
      offsety = 832,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      chunks = {
        {
          x = 0, y = 0, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 17,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 27,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 27,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 16, y = 0, width = 16, height = 16,
          data = {
            30, 3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            30, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            50, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            10, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            20, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 32, y = 0, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 48, y = 0, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            51, 52, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            61, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            61, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            61, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            91, 64, 3, 3, 75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 71, 3, 3, 75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 71, 3, 3, 75, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 71, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 71, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 91, 64, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 91, 64, 3, 3, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 91, 64, 3, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 74, 3, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 73, 73, 51, 84, 3, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 64, y = 0, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 80, y = 0, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 0, y = 16, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 16, y = 16, width = 16, height = 16,
          data = {
            20, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            20, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            20, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            20, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            37, 10, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 3, 72, 1, 51, 55, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 3, 72, 1, 74, 75, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 3, 72, 1, 91, 95, 1, 1, 1, 1, 1, 1,
            32, 30, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1,
            32, 37, 10, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1,
            32, 32, 30, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1,
            32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1,
            32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 53, 55, 1, 1, 1
          }
        },
        {
          x = 32, y = 16, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 51,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 91,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 48, y = 16, width = 16, height = 16,
          data = {
            1, 73, 51, 84, 3, 3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 51, 84, 3, 3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 61, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 51, 52, 55, 1,
            55, 91, 64, 3, 82, 55, 1, 1, 1, 1, 1, 1, 91, 63, 95, 1,
            95, 1, 91, 92, 64, 85, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 91, 95, 1, 1, 1, 1, 51, 53, 53, 53, 53, 53,
            1, 1, 56, 57, 57, 57, 57, 60, 1, 1, 71, 3, 3, 3, 3, 3,
            1, 56, 89, 2, 2, 2, 2, 87, 60, 1, 91, 93, 93, 93, 93, 93
          }
        },
        {
          x = 64, y = 16, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            53, 53, 53, 53, 53, 53, 53, 53, 53, 53, 55, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 82, 53, 53, 53, 53, 53,
            93, 93, 63, 63, 63, 63, 64, 3, 3, 3, 3, 3, 3, 3, 3, 3
          }
        },
        {
          x = 80, y = 16, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            53, 53, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 65, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 0, y = 32, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 16, y = 32, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 3, 82, 53, 55, 1,
            32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 3, 3, 82, 55,
            32, 32, 32, 32, 32, 32, 37, 8, 10, 3, 3, 3, 3, 3, 3, 72,
            32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 8, 10, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 32, y = 32, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1,
            10, 3, 3, 3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1,
            37, 10, 3, 3, 3, 3, 3, 82, 83, 55, 1, 1, 1, 1, 1, 1,
            32, 37, 10, 3, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1, 1,
            32, 32, 37, 8, 10, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1, 1
          }
        },
        {
          x = 48, y = 32, width = 16, height = 16,
          data = {
            56, 89, 2, 2, 2, 2, 2, 2, 87, 60, 1, 1, 1, 1, 1, 1,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 70, 1, 1, 1, 1, 1, 1,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 70, 1, 1, 1, 1, 1, 1,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 70, 1, 1, 1, 1, 1, 1,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 70, 1, 1, 1, 1, 1, 1,
            96, 69, 2, 2, 2, 2, 2, 2, 67, 100, 1, 1, 1, 1, 1, 1,
            1, 96, 69, 2, 2, 2, 2, 67, 100, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 96, 69, 2, 2, 2, 70, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 96, 97, 97, 97, 100, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 64, y = 32, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 71, 3, 62, 64, 3, 3, 3, 3, 3, 3,
            1, 1, 1, 1, 1, 1, 91, 93, 95, 91, 93, 93, 93, 93, 93, 93,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 56, 57, 57, 57, 57, 57, 57, 60, 1, 1, 1, 1,
            1, 1, 1, 56, 89, 2, 2, 2, 2, 2, 2, 87, 60, 1, 1, 1,
            1, 1, 56, 89, 2, 2, 2, 2, 2, 2, 2, 2, 87, 60, 1, 1,
            1, 1, 66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 87, 60, 1,
            1, 1, 66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 87, 60,
            1, 1, 66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 87,
            1, 1, 66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            1, 56, 89, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            56, 89, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2
          }
        },
        {
          x = 80, y = 32, width = 16, height = 16,
          data = {
            3, 62, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            63, 95, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            60, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            87, 60, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 87, 60, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 2, 80, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 2, 80, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 2, 80, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 67, 100, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 0, y = 48, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 16, y = 48, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32
          }
        },
        {
          x = 32, y = 48, width = 16, height = 16,
          data = {
            32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 55, 1, 1, 1,
            32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 55, 1, 1,
            32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 55, 1,
            32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82, 55,
            32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3, 82,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 37, 10, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3,
            32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 30, 3, 3, 3
          }
        },
        {
          x = 48, y = 48, width = 16, height = 16,
          data = {
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 82, 55, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            3, 3, 3, 3, 72, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 64, y = 48, width = 16, height = 16,
          data = {
            66, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            96, 97, 69, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
            1, 1, 96, 97, 97, 97, 97, 69, 2, 2, 2, 2, 2, 2, 67, 98,
            1, 1, 1, 1, 1, 1, 1, 96, 97, 97, 97, 97, 97, 97, 100, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        },
        {
          x = 80, y = 48, width = 16, height = 16,
          data = {
            2, 77, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            2, 77, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            98, 100, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
          }
        }
      }
    }
  }
}
