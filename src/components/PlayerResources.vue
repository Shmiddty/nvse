<script setup>
const player = defineModel('player')
const resources = defineModel('resources')
</script>

<template>
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
</template>
