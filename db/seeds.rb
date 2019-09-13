# frozen_string_literal: true

PokeAtt.destroy_all
Pokemon.destroy_all
Attack.destroy_all

Pokemon.create_pokemons
Attack.create_attacks

PokeAtt.create(pokemon: Pokemon.all[0], attack: Attack.all[14])
PokeAtt.create(pokemon: Pokemon.all[1], attack: Attack.all[14])
PokeAtt.create(pokemon: Pokemon.all[2], attack: Attack.all[14])
PokeAtt.create(pokemon: Pokemon.all[3], attack: Attack.all[6])
PokeAtt.create(pokemon: Pokemon.all[4], attack: Attack.all[6])
PokeAtt.create(pokemon: Pokemon.all[5], attack: Attack.all[6])
PokeAtt.create(pokemon: Pokemon.all[6], attack: Attack.all[7])
PokeAtt.create(pokemon: Pokemon.all[7], attack: Attack.all[7])
PokeAtt.create(pokemon: Pokemon.all[8], attack: Attack.all[7])
PokeAtt.create(pokemon: Pokemon.all[9], attack: Attack.all[19])
PokeAtt.create(pokemon: Pokemon.all[10], attack: Attack.all[9])
PokeAtt.create(pokemon: Pokemon.all[11], attack: Attack.all[15])
PokeAtt.create(pokemon: Pokemon.all[12], attack: Attack.all[19])
PokeAtt.create(pokemon: Pokemon.all[13], attack: Attack.all[9])
PokeAtt.create(pokemon: Pokemon.all[14], attack: Attack.all[10])
PokeAtt.create(pokemon: Pokemon.all[15], attack: Attack.all[15])
PokeAtt.create(pokemon: Pokemon.all[16], attack: Attack.all[16])
PokeAtt.create(pokemon: Pokemon.all[17], attack: Attack.all[17])
PokeAtt.create(pokemon: Pokemon.all[18], attack: Attack.all[9])
PokeAtt.create(pokemon: Pokemon.all[19], attack: Attack.all[11])

PokeAtt.create(pokemon: Pokemon.all[0], attack: Attack.all[10])
PokeAtt.create(pokemon: Pokemon.all[1], attack: Attack.all[10])
PokeAtt.create(pokemon: Pokemon.all[2], attack: Attack.all[10])
PokeAtt.create(pokemon: Pokemon.all[3], attack: Attack.all[9])
PokeAtt.create(pokemon: Pokemon.all[4], attack: Attack.all[9])
PokeAtt.create(pokemon: Pokemon.all[5], attack: Attack.all[18])
PokeAtt.create(pokemon: Pokemon.all[6], attack: Attack.all[4])
PokeAtt.create(pokemon: Pokemon.all[7], attack: Attack.all[4])
PokeAtt.create(pokemon: Pokemon.all[8], attack: Attack.all[4])
PokeAtt.create(pokemon: Pokemon.all[11], attack: Attack.all[19])
PokeAtt.create(pokemon: Pokemon.all[14], attack: Attack.all[15])
PokeAtt.create(pokemon: Pokemon.all[15], attack: Attack.all[15])
PokeAtt.create(pokemon: Pokemon.all[16], attack: Attack.all[17])
PokeAtt.create(pokemon: Pokemon.all[17], attack: Attack.all[18])
PokeAtt.create(pokemon: Pokemon.all[18], attack: Attack.all[2])
PokeAtt.create(pokemon: Pokemon.all[19], attack: Attack.all[3])