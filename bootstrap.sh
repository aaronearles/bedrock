#!/bin/bash
items=("netherite_sword" "bow" "netherite_axe" "netherite_pickaxe" "netherite_shovel" "netherite_hoe" "netherite_helmet" "netherite_leggings" "netherite_chestplate" "netherite_boots" "shield" "arrow 128" "cobblestone 128" "oak_log 128" "bed")

for item in "${items[@]}"; do
  docker compose exec minecraft send-command give @a $item
done