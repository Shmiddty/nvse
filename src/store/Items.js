// TODO: load this async to reduce bundle
import * as data from '../../lib/nv/gamedata.json';

export const equipment = data.sheets
  .find(sht => sht.name === "equipment")?.lines
  ?.filter(eq => eq.id !== "") ?? [];

export const equipmentIdMap = equipment.reduce((o, e) => (o[e.id] = e, o), {});
export default data;
