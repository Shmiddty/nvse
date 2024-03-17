<script setup>
import '../../lib/nv/icons.css';
import { computed } from 'vue';

const props = defineProps({
  icon: { type: String, required: true },
  size: { type: String }
})
const className = computed(() => 
  'nvicon nvicon-' + props.icon + ' nvicon-' + (props.size || "native") 
);
</script>

<template>
  <i :class="className" />
</template>

<style scoped>
.nvicon {
  display:inline-block;
  position:relative;
}
.nvicon:before {
  position:absolute;
  top:-8px;
  left:-8px;
}
.nvicon-native,
.nvicon-16 {
  width: 16px;
  height: 16px;
}
.nvicon-medium,
.nvicon-32 {
  width: 32px;
  height: 32px;
}
.nvicon-medium:before,
.nvicon-32:before {
  transform: scale(2) translate(50%, 50%);
}
.nvicon-48 {
  width: 48px;
  height: 48px;
}
.nvicon-48:before {
  transform: scale(3) translate(50%, 50%);
}
.nvicon-large,
.nvicon-64 {
  width: 64px;
  height: 64px;
}
.nvicon-large:before,
.nvicon-64:before {
  transform: scale(4) translate(50%, 50%);
}

</style>
