<script setup>
import { computed } from 'vue';
import ItemList from './ItemList.vue';

const props = defineProps({
  item: { type: Object, required: false },
  label: { type: String, required: false }
})

</script>

<template>
  <ItemList :label="label" :selected="item" />
  <v-slider show-ticks="always" step="1" tick-size="1" :max="6" v-model="item.quality"/>
</template>

<style scoped>

</style>
