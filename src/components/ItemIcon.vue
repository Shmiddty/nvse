<script setup>
import '../../lib/nv/icons.css';
import { computed } from 'vue';

const props = defineProps({
  icon: { type: String, required: true },
  rarity: { type: Number, required: false },
  size: { type: String }
})
const className = computed(() => 
  'nvicon nvicon-' + props.icon +
  ' nvicon-' + (props.size || "native") +
  ' nvicon-rarity' + (props.rarity || 0)
);
</script>

<template>
  <i :class="className" />
</template>

<style lang="scss" scoped>
.nvicon {
  display:inline-block;
}
.nvicon:before {
}

$cmn: rgba(0,0,0,0);
$uncmn: blue;
$rare: yellow;
$lgnd: #c50;
$uniq: green;
$ols: 1px;
.nvicon-rarity1 {
  filter: drop-shadow(-$ols (-$ols) 0px $uncmn)
          drop-shadow(2*$ols 2*$ols 0px $uncmn)
          drop-shadow(-$ols $ols 0px $uncmn)
          drop-shadow($ols (-$ols) 0px $uncmn)
}
.nvicon-rarity2 {
  filter: drop-shadow(-$ols (-$ols) 0px $rare)
          drop-shadow(2*$ols 2*$ols 0px $rare)
          drop-shadow(-$ols $ols 0px $rare)
          drop-shadow($ols (-$ols) 0px $rare)
}
.nvicon-rarity3 {
  filter: drop-shadow(-$ols (-$ols) 0px $lgnd)
          drop-shadow(2*$ols 2*$ols 0px $lgnd)
          drop-shadow(-$ols $ols 0px $lgnd)
          drop-shadow($ols (-$ols) 0px $lgnd)
}
.nvicon-rarity4 {
  filter: drop-shadow(-$ols (-$ols) 0px $uniq)
          drop-shadow(2*$ols 2*$ols 0px $uniq)
          drop-shadow(-$ols $ols 0px $uniq)
          drop-shadow($ols (-$ols) 0px $uniq)
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
