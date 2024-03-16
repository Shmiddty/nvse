<script setup>
import { computed, reactive } from 'vue';
import Item from './Item.vue';
const props = defineProps({
  index: { type: Number, required: true },
  item: { type: Object, required: false }
})
</script>

<template>
  <Item :item="item" />
  <Item :item="item.meld" label="Meld" />
</template>

<style scoped>

</style>
