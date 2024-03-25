<script setup>
import { ref, computed } from 'vue'
import InventoryItem from './InventoryItem.vue'

const props = defineProps({
  equipment: { type: Array }
})

const page = ref(0)
const maxPage = computed(
  () => Math.ceil((props.equipment?.length || 0) / 30) - 1
)
const pagedEq = computed(
  () => props.equipment?.slice(page.value * 30, (1 + page.value) * 30) ?? []
)
</script>

<template>
  <v-card v-if="equipment" title="Stash" style="margin-top: 0.5em">
    <v-card-text>
      <v-sheet class="stashnav">
        <v-btn @click="page = (page + maxPage) % (maxPage + 1)">
          <v-icon icon="mdi-chevron-left" />
        </v-btn>
        <span>{{ page + 1 }} / {{ maxPage + 1 }}</span>
        <v-btn @click="page = (page + 1) % (maxPage + 1)">
          <v-icon icon="mdi-chevron-right" />
        </v-btn>
      </v-sheet>
      <v-row dense class="eqgrid">
        <v-col
          class="eqslot"
          v-for="invi in pagedEq"
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
.stashnav {
  width: fit-content;
  margin: auto;
}
.stashnav > span {
  display: inline-block;
  margin: 0 0.5em;
}

.eqgrid {
  margin: auto;
  margin-top: 0.5em;
  width: 360px;
}
.eqslot {
  flex: 0 0 20%;
  max-width: 20%;
  text-align: center;
  background: #333;
  border: solid 1px #222;
  border-radius: 10%;
  transition: background-color 250ms linear;
  height: 72px;
}
.eqslot:hover,
.eqslot:has([aria-expanded='true']) {
  background: #357;
}
</style>
