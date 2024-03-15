<script setup>
import { reactive, computed } from 'vue'

const model = reactive({
  state: { selected: null },
  filename: "slot0.sav",
  data: null
})

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
  </header>

  <main>
    <label class="load-button">
      Load
      <input class="load-button" @change="load" type="file" />
    </label>
    <a class="save-button" :href="output" :download="model.filename">Save</a>
  </main>
</template>

<style scoped>
header {
  line-height: 1.5;
}
.load-button {
  border: solid 1px #fff;
  background: #eee;
  padding: .25em .5em;
  color: #00bd7e;
  cursor: pointer;
  margin-right: .25em;
}
.load-button input {
  display: none;
}
.save-button {
  border: solid 1px #fff;
  padding: .25em .5em;
  background: #eee;
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
