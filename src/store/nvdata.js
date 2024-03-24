import Hx from '../../lib/hx'

function sanitize(data) {
  data.world.player.inventory.equipment.forEach((i) => {
    i.item = i.item ?? { id: undefined, quality: 0, meld: null }
    i.item.meld = i.item.meld ?? { id: undefined, quality: 0 }
  })
  data.world.inventory.stash.forEach((i) => {
    i.item = i.item ?? { id: undefined, quality: 0, meld: null }
    i.item.meld = i.item.meld ?? { id: undefined, quality: 0 }
  })

  return data
}
function clean(data) {
  //https://stackoverflow.com/a/69827802
  function unproxify(val) {
    if (val instanceof Array) return val.map(unproxify)
    if (val instanceof Object)
      return Object.fromEntries(
        Object.entries(Object.assign({}, val)).map(
          // TODO: this is a bad solution
          ([k, v]) =>
            ['progress', 'levelData', 'saveData'].includes(k)
              ? [k, v]
              : [k, unproxify(v)]
        )
      )
    return val
  }
  if (!data) return data
  const out = unproxify(data)
  out.world.player.inventory.equipment.forEach((i) => {
    i.item.meld = i.item.meld.id ? i.item.meld : null
    i.item = i.item.id ? i.item : null
  })
  out.world.inventory.stash.forEach((i) => {
    i.item.meld = i.item.meld.id ? i.item.meld : null
    i.item = i.item.id ? i.item : null
  })
  return out
}
export function load(saveData) {
  return sanitize(Hx.Unserialize(saveData))
}
export function save(modelData) {
  return Hx.Serialize(clean(modelData))
}
