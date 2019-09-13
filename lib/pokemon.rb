# frozen_string_literal: true

# class Pokemon contains methods to interact with and create Pokemon instances
class Pokemon < ActiveRecord::Base
  has_many :pokeatts
  has_many :attacks, through: :pokeatts

  def attacks
    value = PokeAtt.all.select do |pokemonattacks|
      pokemonattacks.pokemon.name == self.name
    end
    value.map do |pokeatt|
      pokeatt.attack.name
    end
  end

  def enemy_attack
    value = PokeAtt.all.select do |pokemonattacks|
      pokemonattacks.pokemon.name == self.name
    end
    value.map do |pokeatt|
      pokeatt.attack.name
    end
  end

  def self.pokemon_names
    response = RestClient.get('https://pokeapi.co/api/v2/pokemon')
    parsed_response = JSON.parse(response)
    parsed_response['results'].map { |result| result['name'] }
  end

  def self.create_pokemons
    i = 0
    while i < pokemon_names.length
      create(name: pokemon_names[i], health: rand(100..120))
      i += 1
    end
  end
end
