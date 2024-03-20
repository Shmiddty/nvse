<script setup>
import Hx from '../lib/hx'
import { reactive, computed } from 'vue'
import InventoryItem from './components/InventoryItem.vue';

const model = reactive({
  filename: null,
  data: null
});

function sanitize(data) {
  data.world.player.inventory.equipment.forEach(i => {
    i.item = i.item ?? { id:undefined, quality: 0, meld: null };
    i.item.meld = i.item.meld ?? { id:undefined, quality: 0 };
  });
  return data;
}
function clean(data) {
  //https://stackoverflow.com/a/69827802 
  function unproxify(val) {
    if (val instanceof Array) return val.map(unproxify)
    if (val instanceof Object) 
      return Object.fromEntries(
        Object.entries(Object.assign({},val))
          .map(
            // TODO: this is a bad solution
            ([k,v])=>["progress", "levelData", "saveData"].includes(k) 
              ? [k,v]
              : [k,unproxify(v)]
          )
      );
    return val
  }
  if (!data) return data;
  const out = unproxify(data);
  out.world.player.inventory.equipment.forEach(i => {
    i.item.meld = i.item.meld.id ? i.item.meld : null;
    i.item = i.item.id ? i.item : null;
  });
  return out;
}
function load(e) {
  e.target.files.item(0).text()
    .then(Hx.Unserialize)
    .then(data => 
      model.data = sanitize(data)
    );
  model.filename = e.target.files.item(0).name;
}

const resources = computed(() => model.data?.resources ?? {});
const player = computed(() => model.data?.world?.player ?? {});
const equipment = computed(() => model.data?.world?.player?.inventory?.equipment);
const output = computed(() => 
  'data:text/plain;charset=utf-8,' + encodeURIComponent(Hx.Serialize(clean(model.data)))
);
</script>

<template>
  <v-app>
    <v-app-bar app>
      <v-btn variant="elevated" color="info" class="button-load">
        <label class="load">
          Load
          <input class="button" @change="load" type="file" />
        </label>
      </v-btn>
      <v-btn variant="elevated" color="info" :disabled="model.data===null">
        <a class="save" :href="output" :download="model.filename">
          Save
        </a>
      </v-btn>
      {{ model.filename }}
    </v-app-bar>

    <v-main>
      <v-container :hidden="!model.data" transition="fade-transition">
        <v-row dense>
          <v-col cols="12" xxl="8" xl="8" lg="8" md="8" sm="12">
            <v-card title="Resources">
              <v-card-text>
                <v-row dense>
                  <v-col>
                    <v-text-field
                      v-model.number="player.health"
                      label="Health"
                      type="number"
                      :min="0"
                      :max="player.maxHealth"
                    />
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model.number="player.maxHealth"
                      label="Max Health"
                      type="number"
                      :min="0"
                    />
                  </v-col>
                </v-row>

                <v-row dense>
                  <v-col cols="2">
                    <v-text-field
                      v-model.number="resources.power"
                      label="Power"
                      type="number"
                      :min="0"
                      :max="20"
                    />
                    <v-text-field
                      v-model.number="resources.hope"
                      label="Hope"
                      type="number"
                      :min="-100"
                      :max="100"
                    />
                  </v-col>
                  <v-col>
                    <v-text-field
                      v-model.number="resources.coins"
                      label="Coins"
                      type="number"
                      :min="0"
                    />
                    <v-text-field
                      v-model.number="resources.hopestones"
                      label="Hopestones"
                      type="number"
                      :min="0"
                    />
                  </v-col>
                </v-row>
              </v-card-text>
            </v-card>
          </v-col>
          <v-col cols="12" xxl="4" xl="4" lg="4" md="4" sm="12">
            <!-- TODO: move to component -->
            <v-card title="Equipment">
              <v-card-text>
                <v-row dense>
                  <v-col
                    cols="3"
                    class="eqslot"
                    v-for="invi in equipment"
                    :data-index="invi.index"
                    :key="invi.index">
                      <InventoryItem
                        :index="invi.index"
                        :item="invi.item"
                      />
                  </v-col>
                </v-row>
              </v-card-text>
            </v-card>
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
.eqslot {
  text-align: center;
}
[data-index="4"],
[data-index="5"],
[data-index="6"],
[data-index="7"] {
  order: -1;
}
[data-index="8"] ,
[data-index="9"] ,
[data-index="10"] ,
[data-index="11"] {
  order:25;
  margin-top: 2em;
}

[data-index="12"] ,
[data-index="13"] ,
[data-index="14"] ,
[data-index="15"] {
  margin-top: 2em;
}
</style>
