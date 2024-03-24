<script setup>
import { computed, ref } from 'vue'
import ItemStats from './ItemStats.vue'
import ItemList from './ItemList.vue'
import ItemIcon from './ItemIcon.vue'
import { equipmentById as itemmap } from '../store/Items.js'

defineProps({
  index: { type: Number, required: true }
})

const item = defineModel('item')
const dItem = computed(() => itemmap[item.value.id])
const dMeld = computed(() => itemmap[item.value.meld.id])
const menu = ref(false)
</script>

<template>
  <v-menu v-model="menu" open-on-hover :close-on-content-click="false">
    <template v-slot:activator="{ props }">
      <v-sheet v-bind="props" class="icon-wrap">
        <ItemIcon size="48" :icon="dItem?.icon" :rarity="dItem?.rarity" />
        <ItemIcon
          class="meld"
          size="24"
          :icon="dMeld?.icon"
          :rarity="dMeld?.rarity"
        />
      </v-sheet>
    </template>
    <template v-slot:default="{}">
      <v-card style="min-width: 300px">
        <v-card-text>
          <v-row dense>
            <v-col>
              <ItemList label="Item" :selected="item" />
            </v-col>
            <v-col cols="3">
              <v-text-field
                v-model.number="item.quality"
                label="Quality"
                type="number"
                :min="0"
                :max="6"
              />
            </v-col>
          </v-row>
          <v-row dense>
            <v-col>
              <ItemList label="Meld" :selected="item.meld" />
            </v-col>
            <v-col cols="3">
              <v-text-field
                v-model.number="item.meld.quality"
                label="Quality"
                type="number"
                :min="0"
                :max="6"
              />
            </v-col>
          </v-row>
          <v-row dense>
            <ItemStats :item="item" />
          </v-row>
        </v-card-text>
      </v-card>
    </template>
  </v-menu>
</template>

<style scoped>
.icon-wrap {
  display: inline-block;
  background: inherit;
  text-align: left;
  position: relative;
  width: 64px;
  height: 64px;
  cursor: pointer;
}
.meld {
  position: absolute;
  bottom: 12px;
  right: 12px;
}
</style>
