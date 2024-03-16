<script setup>
import { computed } from 'vue';
import Item from './Item.vue';
const props = defineProps({
  index: { type: Number, required: true },
  item: { type: Object, required: false }
})

// Hackalacka
const meld = new Proxy({}, {
  get(target, prop, receiver) {
    return props.item.meld?.[prop] ?? { id:'', quality:0 }[prop];
  },
  set(obj, prop, newval) {
    if (prop === 'id' && !newval) {
      props.item.meld = null;
      return;
    }
    if (props.item.meld === null) {
      props.item.meld = { id: '', quality: 0 };
    }
    props.item.meld[prop] = newval;
  }
});
</script>

<template>
  <Item :item="item" />
  <Item :item="meld" label="Meld" />
</template>

<style scoped>

</style>
