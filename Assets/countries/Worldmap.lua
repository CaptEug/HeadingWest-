return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 1,
  height = 1,
  tilewidth = 1920,
  tileheight = 1280,
  nextlayerid = 2,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "WorldMap",
      firstgid = 1,
      class = "",
      tilewidth = 1920,
      tileheight = 1280,
      spacing = 0,
      margin = 0,
      columns = 1,
      image = "WorldMap.png",
      imagewidth = 1920,
      imageheight = 1280,
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
        width = 1920,
        height = 1280
      },
      properties = {},
      wangsets = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 1,
      height = 1,
      id = 1,
      name = "Earth",
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
        1
      }
    }
  }
}
