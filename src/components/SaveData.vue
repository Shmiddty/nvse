<script setup>
import { computed, ref } from 'vue'

const saveData = defineModel()

function updater(key, e) {
  saveData.value.h[key] = e
}

function getVal(key) {
  return saveData.value.h[key]
}

const query = ref('')

const keys = computed(() => {
  const out = Object.keys(saveData.value?.h ?? {})
    .sort((a, b) => (a.toLowerCase() < b.toLowerCase() ? -1 : 1))
    .filter((v) => v.toLowerCase().includes(query.value.toLowerCase()))
  return out
})
</script>

<template>
  <v-card title="Save Data" style="margin-top: 0.5em">
    <v-card-text>
      <v-text-field label="Filter" variant="underlined" v-model="query" />
      <v-sheet
        class="overflow-auto d-flex flex-wrap justify-space-between"
        style="max-height: 300px"
      >
        <template v-for="key in keys" :key="key">
          <v-text-field
            class="order-0 data-field-wide"
            v-if="typeof getVal(key) === 'number'"
            :label="key"
            type="number"
            :model-value="getVal(key)"
            @update:model-value="updater(key, +$event)"
          />
          <v-checkbox
            class="d-inline-flex order-1 data-field"
            v-else
            :label="key"
            :model-value="getVal(key)"
            @update:model-value="updater(key, $event)"
          />
        </template>
      </v-sheet>
    </v-card-text>
  </v-card>
</template>

<style scoped>
.data-field-wide {
  display: inline-block;
  width: 100%;
}
.data-field {
  display: inline-block;
  width: 30%;
  margin: 0 0.5em;
}
</style>
