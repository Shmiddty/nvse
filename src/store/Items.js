// TODO: load this async to reduce bundle
import * as data from '../../lib/nv/gamedata.json';

function byId(arr) {
  return arr.reduce((o, i) => (o[i.id] = i, o), {});
}

export const stats = data.sheets
  .find(sht => sht.name === "stats")?.lines ?? [];

export const statsById = byId(stats);

export const equipment = data.sheets
  .find(sht => sht.name === "equipment")?.lines
  ?.filter(eq => eq.id !== "") ?? [];

export const equipmentById = byId(equipment)

export default data;
