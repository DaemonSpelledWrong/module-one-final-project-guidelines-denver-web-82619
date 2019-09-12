# frozen_string_literal: true

# class Attack contains methods to create attack instances
class Attack < ActiveRecord::Base
  has_many :pokeatts
  has_many :pokemon, through: :pokeatts

  def self.attack_names
    response = RestClient.get('https://pokeapi.co/api/v2/move')
    parsed_response = JSON.parse(response)
    parsed_response['results'].map { |result| result['name'] }
  end

  def self.create_attacks
    i = 0
    while i < attack_names.length
      create(name: attack_names[i], damage: rand(10..30))
      i += 1
    end
  end
end
