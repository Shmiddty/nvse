<script setup>
import { computed } from 'vue';
import items from "../store/Items.js";

const props = defineProps({
  selected: { type: Object },
  label: { type:String }
});
function filter(id, query, item) {
  const props = [
    item.raw.name, 
    item.raw.category,
    item.raw.description, 
    ...item.raw.properties.map(p => p.stat)
  ];
  return props.some(p => p.includes(query));
}
const selectedId = computed({
  get() {
    return props.selected.id;
  },
  set(item) {
    props.selected.id = item.id;
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
    return-object="false"
    />
</template>

<style scoped>

</style>
