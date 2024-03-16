<script setup>
import { reactive, computed } from 'vue'
import InventoryItem from './components/InventoryItem.vue';

const model = reactive({
  state: { selected: null },
  filename: "slot0.sav",
  data: null
});
const equipment = computed(() => model.data?.world?.player?.inventory?.equipment);

function load(e) {
  e.target.files.item(0).text()
    .then(Hx.Unserialize)
    .then(data => {
      model.data = data
    });
  model.filename = e.target.files.item(0).name;
}
const output = computed(() => 
  'data:text/plain;charset=utf-8,' + encodeURIComponent(Hx.Serialize(model.data))
);
</script>

<template>
  <header>
    <label class="button">
      Load
      <input class="button" @change="load" type="file" />
    </label>
    <a class="button" :href="output" :download="model.filename">Save</a>
  </header>

  <main>
    <ol class="equipment">
      <li v-for="invi in equipment" :data-index="invi.index" :key="invi.index">
        <InventoryItem :index="invi.index" :item="invi.item" />
      </li>
    </ol>
  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}
.button {
  border: solid 1px #fff;
  background: #eee;
  padding: .25em .5em;
  color: #00bd7e;
  cursor: pointer;
  margin-right: .25em;
}
.button input {
  display: none;
}
.equipment {
  list-style:none;
  display:grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 0px;
  /*grid-auto-rows: minmax(100px, auto);*/
}
.equipment > li {
  padding: .5em;
  border: solid 1px #333;
  margin:3px
}
.equipment > li[data-index="4"] {
  order: -4;
}
.equipment > li[data-index="5"] {
  order: -3;
}
.equipment > li[data-index="6"] {
  order: -2;
}
.equipment > li[data-index="7"] {
  order: -1;
}
.equipment > li[data-index="8"] ,
.equipment > li[data-index="9"] ,
.equipment > li[data-index="10"] ,
.equipment > li[data-index="11"] {
  border-color: green;
}
@media (min-width: 1024px) {
  header {
    display: flex;
    place-items: center;
    padding-right: calc(var(--section-gap) / 2);
  }

  header .wrapper {
    display: flex;
    place-items: flex-start;
    flex-wrap: wrap;
  }
}
</style>
