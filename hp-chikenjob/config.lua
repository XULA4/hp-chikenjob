vusca = {
    [1] = {
      type = "chiken",
      coords = vector3(-62.5368, 6241.3667, 31.0901),
      Items = {
        [1] = {
          name = "chiken",
          count = 1
        },
      }
    },
    [2] = {
      type = "cleaningchiken",
      coords = vector3(-78.2904, 6229.7188, 31.0920),
      Items = {
        [1] = {
          name = "cleanchiken",
          count = 1
        }
      },
      ReqItems = {
        [1] = {
          name = "chiken",
          count = 1
        }
      }
    },
    [3] = {
        type = "processchiken",
        coords = vector3(-85.7776, 6227.3325, 31.0899),
        Items = {
          [1] = {
            name = "chikenmeat",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "cleanchiken",
            count = 1
        }
      }
    },
    [4] = {
        type = "chickennuggets",
        coords = vector3(-99.4713, 6210.9863, 31.0250),
        Items = {
          [1] = {
            name = "chickennuggets",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "chikenmeat",
            count = 1
        }
      }
    },
    [5] = {
        type = "cooking",
        coords = vector3(-106.3099, 6204.4702, 31.0262),
        Items = {
          [1] = {
            name = "chikentyson",
            count = 1
          }
        },
        ReqItems = {
          [1] = {
            name = "chickennuggets",
            count = 1
          }
        }
      },
  }


Config = {}

Config.NPCEnable = true
Config.NPCHash = 0x49EADBF6
Config.NPCDealer = { x = 129.6462, y = -1465.6404, z = 28.3570, h = 65.6222 }
Config.NPCText = { x = 129.6462, y = -1465.6404, z = 29.3570 }

Config.Price = 320
Config.Item = 'chikentyson'