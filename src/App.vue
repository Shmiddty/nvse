<script setup>
import { reactive, computed } from 'vue'
import { load, save } from './store/nvdata.js'
import PlayerResources from './components/PlayerResources.vue'
import SaveData from './components/SaveData.vue'
import PlayerEquipment from './components/PlayerEquipment.vue'
const model = reactive({
  filename: null,
  data: null
})

function fileSelected(e) {
  const file = e.target.files.item(0)
  file
    .text()
    .then(load)
    .then((data) => (model.data = data))
  model.filename = file.name
}

const resources = computed(() => model.data?.resources ?? {})
const player = computed(() => model.data?.world?.player ?? {})
const saveData = computed(() => model.data?.world?.saveData ?? {})
const equipment = computed(
  () => model.data?.world?.player?.inventory?.equipment
)
const output = computed(
  () => 'data:text/plain;charset=utf-8,' + encodeURIComponent(save(model.data))
)
</script>

<template>
  <v-app>
    <v-app-bar app>
      <v-btn variant="elevated" color="info" class="button-load">
        <label class="load">
          Load
          <input class="button" @change="fileSelected" type="file" />
        </label>
      </v-btn>
      <v-btn
        variant="elevated"
        color="info"
        :disabled="model.data === null || !model.filename"
      >
        <a class="save" :href="output" :download="model.filename"> Save </a>
      </v-btn>
      <v-text-field
        :disabled="model.data === null"
        class="filename"
        label="Filename"
        density="compact"
        variant="underlined"
        v-model="model.filename"
      />
    </v-app-bar>

    <v-main>
      <v-container :hidden="!model.data" transition="fade-transition">
        <v-row dense>
          <v-col cols="12" xxl="8" xl="8" lg="8" md="7" sm="12">
            <PlayerResources
              v-model:player="player"
              v-model:resources="resources"
            />
            <SaveData v-model="saveData" />
          </v-col>
          <v-col cols="12" xxl="4" xl="4" lg="4" md="5" sm="12">
            <PlayerEquipment :equipment="equipment" />
          </v-col>
        </v-row>
      </v-container>
    </v-main>
  </v-app>
</template>

<style lang="scss" scoped>
.button-load {
  margin-right: 1em;
}
.load {
  cursor: inherit;
}
.load input {
  display: none;
}
.save {
  color: inherit;
  background: inherit;
}
.save:hover {
  background: inherit;
  color: inherit;
}
.filename {
  height: 27px;
  margin: 0 1em;
}
</style>
