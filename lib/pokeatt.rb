# frozen_string_literal: true

# class PokeAtt
class PokeAtt < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :attack

  def self.damage_value(move)
    value = all.select do |pokemonattack|
      pokemonattack.attack.name.downcase == move
    end
    value.map do |pokeattack|
      pokeattack.attack.damage
    end[0]
  end

  def self.create_pokeattack
    i = 0
    while i < Pokemon.all.length
      create(pokemon: Pokemon.all[i], attack: Attack.all[i])
      i += 1
    end
  end
end
