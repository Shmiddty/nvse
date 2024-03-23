<script setup>
import { computed } from 'vue'

const saveData = defineModel()

function updater(key, e) {
  saveData.value.h[key] = e
}
const keys = computed(() => Object.keys(saveData.value?.h ?? {}).sort())

function getVal(key) {
  return saveData.value.h[key]
}
</script>

<template>
  <v-card title="Save Data" style="margin-top: 1em">
    <v-card-text>
      <v-sheet
        class="overflow-auto d-flex flex-wrap justify-space-between"
        height="300"
      >
        <template v-for="key in keys" :key="key">
          <v-text-field
            class="order-0"
            style="width: 100%"
            v-if="typeof getVal(key) === 'number'"
            :label="key"
            type="number"
            :model-value="getVal(key)"
            @update:model-value="updater(key, +$event)"
          />
          <v-checkbox
            class="d-inline-flex order-1"
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

<style scoped></style>
