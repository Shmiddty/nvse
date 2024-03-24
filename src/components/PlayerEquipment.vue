<script setup>
import InventoryItem from './InventoryItem.vue'

defineProps({
  equipment: { type: Array }
})
</script>

<template>
  <v-card title="Equipment" v-if="equipment">
    <v-card-text>
      <v-row dense class="eqgrid">
        <v-col
          cols="3"
          class="eqslot"
          v-for="invi in equipment"
          :data-index="invi.index"
          :key="invi.index"
        >
          <InventoryItem :index="invi.index" v-model:item="invi.item" />
        </v-col>
      </v-row>
    </v-card-text>
  </v-card>
</template>

<style scoped>
.eqgrid {
  width: 288px; /* this is bad */
  margin: auto;
}
.eqslot {
  text-align: center;
  background: #333;
  border: solid 1px #222;
  border-radius: 10%;
  transition: background-color 250ms linear;
}
.eqslot:hover,
.eqslot:has([aria-expanded='true']) {
  background: #357;
}
[data-index='4'],
[data-index='5'],
[data-index='6'],
[data-index='7'] {
  order: -1;
}
[data-index='8'],
[data-index='9'],
[data-index='10'],
[data-index='11'] {
  order: 25;
  margin-top: 0.5em;
}

[data-index='12'],
[data-index='13'],
[data-index='14'],
[data-index='15'] {
  margin-top: 0.5em;
}
</style>
