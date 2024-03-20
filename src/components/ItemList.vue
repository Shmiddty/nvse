<script setup>
import { computed } from 'vue';
import { equipment as items, equipmentById as itemmap } from "../store/Items.js";

const props = defineProps({
  selected: { type: Object, required: true },
  label: { type:String }
});
function filter(id, query, item) {
  const props = [
    item.raw.name,
    item.raw.id,
    item.raw.category,
    item.raw.description, 
    ...item.raw.properties.map(p => p.stat)
  ].map(s => s.toLowerCase());
  return props.some(p => p.includes(query.toLowerCase()));
}
const selectedId = computed({
  get() {
    return itemmap[props.selected.id] || { id:undefined, name:'' };
  },
  set(item) {
    props.selected.id = item?.id;
  }
});
</script>

<template>
  <v-combobox
    :label="label ?? 'Item'"
    placeholder="None"
    :custom-filter="filter"
    v-model="selectedId"
    :items="items"
    item-title="name"
    item-value="id"
  />
</template>

<style scoped>

</style>
