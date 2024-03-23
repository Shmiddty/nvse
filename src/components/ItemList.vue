<script setup>
import { computed } from 'vue'
import { equipment as items, equipmentById as itemmap } from '../store/Items.js'

const props = defineProps({
  label: { type: String }
})
const selected = defineModel('selected')

function filter(id, query, item) {
  const props = [
    item.raw.name,
    item.raw.id,
    item.raw.category,
    ...item.raw.properties.map((p) => p.stat)
  ].map((s) => s.toLowerCase())
  return props.some((p) => p.includes(query.toLowerCase()))
}

// TODO: this is a bit hacky, but I'm not sure how else to go about it.
const selectedId = computed({
  get() {
    return itemmap[props.selected.id] || { id: undefined, name: '' }
  },
  set(item) {
    selected.value.id = item?.id
  }
})
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

<style scoped></style>
