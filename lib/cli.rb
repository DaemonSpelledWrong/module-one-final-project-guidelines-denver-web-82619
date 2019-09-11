# frozen_string_literal: true

# class CLI
class Cli
  def main_menu
    # Add a title? PokeFight!
    puts 'What would you like to do?'
    puts " 1.) New Game\n 2.) Exit"
    player_choice = gets.chomp.downcase
    if player_choice == 'new game' || player_choice == '1'
      start
    elsif player_choice == 'exit' || player_choice == '2'
      exit
    else
      puts 'That was an invalid choice! Please choose again.'
      main_menu
    end
  end

  def start
    puts 'Which pokemon do you prefer?'
    puts " 1.) Abra\n 2.) Pikachu"
    poke_choice = gets.chomp.downcase
    # Use include? enumerable to check if it actually exists in the api
    if poke_choice == 'abra'
      player = Pokemon.all[0]
      location(player)
    elsif poke_choice =='pikachu'
     player = Pokemon.all[1]
      location(player)
    else
      puts 'Not a valid choice'
      start
    end
  end

  def location(player)
    puts 'Which location would you like to challenge?'
    puts " - Volcano\n - Pond"
    location_choice = gets.chomp.downcase
    if location_choice == 'volcano'
      puts 'hot!'
      volcano_battle(player)
    elsif location_choice == 'pond'
      puts 'wet!'
      pond_battle(player)
    else
      puts 'Not a valid location! Choose again.'
      location(player)
    end
  end

  def volcano_battle(player)
    enemy = Pokemon.all[1]
    battle(player, enemy)
  end

  def battle(player, enemy)
    player_health = player.health
    enemy_health = enemy.health
    while player_health > 0 || enemy_health > 0
      enemy_health -= player_turn(player)
      binding.pry
      player_health -= enemy_turn(enemy)
      binding.pry
    end
  end

  def player_turn(player)
    puts 'What attack would you like to use?'
    puts player.attacks
    move_choice = gets.chomp
    PokeAtt.damage_value(move_choice)
  end

  def enemy_turn(enemy)
    10
  end
end
