# frozen_string_literal: true

# class CLI
class Cli
attr_reader :prompt, :box
  def initialize
    @prompt = TTY::Prompt.new
  end

  def main_menu
    box = TTY::Box.frame(
      width: 272,
      height: 20,
      align: :center,
      padding: 3
    ) do
      '
       _______            __                  ________  __            __          __     __ 
      /       \          /  |                /        |/  |          /  |        /  |   /  |
      $$$$$$$  | ______  $$ |   __   ______  $$$$$$$$/ $$/   ______  $$ |____   _$$ |_  $$ |
      $$ |__$$ |/      \ $$ |  /  | /      \ $$ |__    /  | /      \ $$      \ / $$   | $$ |
      $$    $$//$$$$$$  |$$ |_/$$/ /$$$$$$  |$$    |   $$ |/$$$$$$  |$$$$$$$  |$$$$$$/  $$ |
      $$$$$$$/ $$ |  $$ |$$   $$<  $$    $$ |$$$$$/    $$ |$$ |  $$ |$$ |  $$ |  $$ | __$$/ 
      $$ |     $$ \__$$ |$$$$$$  \ $$$$$$$$/ $$ |      $$ |$$ \__$$ |$$ |  $$ |  $$ |/  |__ 
      $$ |     $$    $$/ $$ | $$  |$$       |$$ |      $$ |$$    $$ |$$ |  $$ |  $$  $$//  |
      $$/       $$$$$$/  $$/   $$/  $$$$$$$/ $$/       $$/  $$$$$$$ |$$/   $$/    $$$$/ $$/ 
                                                           /  \__$$ |                       
                                                           $$    $$/                        
                                                            $$$$$$/                         
                                                            '
    end
    print box
    spacing
    player_choice = prompt.select('What would you like to do?', %w[Play Exit]).downcase
    spacing
    if player_choice == 'play'
      clear
      start
    elsif player_choice == 'exit'
      exit
    else
      puts 'That was an invalid choice! Please choose again.'
      main_menu
    end
  end

  def start
    spacing
    poke_choice = prompt.select('Which pokemon do you prefer?', %w[Abra Pikachu]).downcase

    if poke_choice == 'abra'
      player = Pokemon.all[0]
      clear
      location(player)
    elsif poke_choice =='pikachu'
     player = Pokemon.all[1]
     clear
      location(player)
    else
      clear
      puts 'Not a valid choice'
      start
    end
  end

  def location(player)
    spacing
    location_choice = prompt.select('Which location would you like to challenge?', %w[Volcano]).downcase
    if location_choice == 'volcano'
      clear
      volcano_battle(player)
    end
    # else
    #   clear
    #   puts 'Not a valid location! Choose again.'
    #   location(player)
    # end
  end

  def volcano_battle(player)
    enemy = Pokemon.all.sample
    battle(player, enemy)
  end

  def battle(player, enemy)
    player_health = player.health
    enemy_health = enemy.health
    while player_health.positive? && enemy_health.positive?
      enemy_health -= player_turn(player)
      puts "The enemy has #{enemy_health} HP left!"
      if enemy_health.positive?
        player_health -= enemy_turn(enemy)
      end
      puts "You have #{player_health} HP left!"
    end
    if player_health.positive?
      location(player)
    else
      main_menu
    end
  end

  def player_turn(player)
    spacing
    puts 'What attack would you like to use?'
    spacing
    puts player.attacks
    move_choice = gets.chomp.downcase
    PokeAtt.damage_value(move_choice)
  end

  def enemy_turn(enemy)
    spacing
    move_choice = enemy.enemy_attack.sample.downcase
    puts "The enemy used #{move_choice}!"
    spacing
    PokeAtt.damage_value(move_choice)
  end

  def spacing
    puts ' '
    puts ' '
    puts ' '
    puts ' '
    puts ' '
  end

  def clear
    system('clear')
  end
end
