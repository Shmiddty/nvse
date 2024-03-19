<script setup>
import { computed } from 'vue';
import ItemList from './ItemList.vue';
import ItemIcon from './ItemIcon.vue';
import { equipmentIdMap as itemmap } from "../store/Items.js";

const props = defineProps({
  item: { type: Object, required: false },
  label: { type: String, required: false }
})

</script>

<template>
  <v-row>
    <v-col cols="3" align-self="center">
      <ItemIcon
        size="48"
        :rarity="itemmap[item.id]?.rarity"
        :icon="itemmap[item.id]?.icon"
      />
    </v-col>
    <v-col cols="9">
      <ItemList :label="label" :selected="item" />
      <v-slider 
        show-ticks="always"
        step="1"
        tick-size="1"
        :max="6"
        v-model="item.quality"
      />
    </v-col>
  </v-row>
</template>

<style scoped>
</style>
