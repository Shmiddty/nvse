<script setup>
import { computed } from 'vue'
import { equipmentById, statsById } from '../store/Items.js'

function mergeStat(a, b) {
  const value = Math.sqrt(2 * Math.abs(a.value * b.value))
  return {
    ...a,
    value
  }
}
function scale(prop, levels) {
  // return (val * M.pow(1.20, M.min(100, levels)));
  if (['health', 'damage'].includes(prop.stat))
    return prop.base + 0.1 * levels * prop.base

  return prop.base + prop.increment * levels
}
const props = defineProps({
  item: { type: Object, required: true }
})

// BetterWay?
const mergedStats = computed(() => {
  const itemStats = equipmentById[props.item.id]?.properties?.reduce(
    (o, p) => (
      (o[p.mode][p.stat] = {
        value: scale(p, props.item.quality),
        type: p.type,
        valence: p.valence
      }),
      o
    ),
    [{}, {}, {}]
  ) ?? [{}, {}, {}]
  const meldStats = equipmentById[props.item.meld?.id]?.properties?.reduce(
    (o, p) => (
      (o[p.mode][p.stat] = {
        value: scale(p, props.item.meld.quality),
        type: p.type,
        valence: p.valence
      }),
      o
    ),
    [{}, {}, {}]
  ) ?? [{}, {}, {}]
  return meldStats.map((m, i) =>
    Object.entries(m).reduce(
      (o, [k, v]) => ((o[k] = o[k] ? mergeStat(o[k], v) : v), o),
      itemStats[i]
    )
  )
})
</script>

<template>
  <table class="statlist">
    <template v-for="(mode, i) in mergedStats">
      <tr v-for="(val, key) in mode" :key="key" :data-mode="i">
        <td class="statname">{{ statsById[key]?.display }}</td>
        <td class="statvalue">
          {{
            (statsById[key]?.display_type === 3 || val.value < 0 ? '' : '+') +
            val.value.toLocaleString() +
            (statsById[key]?.display_type === 1 ? '%' : '')
          }}
        </td>
      </tr>
    </template>
  </table>
</template>

<style scoped>
.statlist {
  display: block;
  width: 100%;
  font-size: 1.25em;
  line-height: 1.5em;
}
.statlist [data-mode='0'] {
  color: #fff;
}
.statlist [data-mode='1'] {
  color: #99f;
}
.statlist [data-mode='2'] {
  color: #9f9;
}
.statname {
  text-align: right;
}
.statname:after {
  content: ':';
}
.statvalue {
  padding-left: 0.5em;
}
</style>
