# frozen_string_literal: true

# class CLI
class Cli
  attr_reader :prompt, :box
  def initialize
    @prompt = TTY::Prompt.new
  end

  def main_menu
    clear
    game_title
    spacing
    player_choice = prompt.select('What would you like to do?', %w[Play Exit])
    spacing
    player_choice == 'Play' ? clear && start : exit
  end

  def start
    choose_box
    spacing
    poke_choice = prompt.select('Which pokemon do you prefer?', Pokemon.all.map(&:name))

    player = Pokemon.all.find do |pokemon|
      pokemon.name = poke_choice
    end
    clear
    location(player)
  end

  def location(player)
    clear
    spacing
    location_box
    spacing
    location_choice = prompt.select('Which location would you like to challenge?', %w[Deathly_Volcano Battle_Stadium Pokemon_League Quit])
    if location_choice == 'Quit'
      exit
    else
      battle(player)
    end
  end

  def battle(player)
    clear
    battle_box
    enemy = Pokemon.all.sample
    spacing
    puts "A wild #{enemy.name} appeared! Time to BATTLE!"
    player_health = player.health
    enemy_health = enemy.health
    while player_health.positive? && enemy_health.positive?
      enemy_health -= player_turn(player)
      spacing
      puts "You hear the #{enemy.name} cry out in pain!"
      spacing
      puts "The #{enemy.name} has #{enemy_health} HP left!"
      if enemy_health.positive?
        player_health -= enemy_turn(enemy)
      end
      puts "You have #{player_health} HP left!"
    end
    if player_health.positive?
      location(player)
    else
      clear
      game_over_box
      spacing
      continue
    end
  end

  def player_turn(player)
    spacing
    move_choice = prompt.select('Which attack will you use!?', player.attacks).downcase
    PokeAtt.damage_value(move_choice)
  end

  def enemy_turn(enemy)
    spacing
    move_choice = enemy.enemy_attack.sample.downcase
    puts "The #{enemy.name} used #{move_choice}!"
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

  def continue
    keep_playing = prompt.select('Keep playing?', %w[Yes No])
    if keep_playing == 'Yes'
      main_menu
    else
      exit
    end
  end

  def game_title
    box = TTY::Box.frame(
      width: 150,
      height: 20,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
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
                                                            $$$$$$/                         '
    end
    print box
  end

  def battle_box
    box = TTY::Box.frame(
      width: 150,
      height: 20,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
      padding: 3
    ) do
      '
       _______               __      __      __                  ________  __                          __ 
      /       \             /  |    /  |    /  |                /        |/  |                        /  |
      $$$$$$$  |  ______   _$$ |_  _$$ |_   $$ |  ______        $$$$$$$$/ $$/  _____  ____    ______  $$ |
      $$ |__$$ | /      \ / $$   |/ $$   |  $$ | /      \          $$ |   /  |/     \/    \  /      \ $$ |
      $$    $$<  $$$$$$  |$$$$$$/ $$$$$$/   $$ |/$$$$$$  |         $$ |   $$ |$$$$$$ $$$$  |/$$$$$$  |$$ |
      $$$$$$$  | /    $$ |  $$ | __ $$ | __ $$ |$$    $$ |         $$ |   $$ |$$ | $$ | $$ |$$    $$ |$$/ 
      $$ |__$$ |/$$$$$$$ |  $$ |/  |$$ |/  |$$ |$$$$$$$$/          $$ |   $$ |$$ | $$ | $$ |$$$$$$$$/  __ 
      $$    $$/ $$    $$ |  $$  $$/ $$  $$/ $$ |$$       |         $$ |   $$ |$$ | $$ | $$ |$$       |/  |
      $$$$$$$/   $$$$$$$/    $$$$/   $$$$/  $$/  $$$$$$$/          $$/    $$/ $$/  $$/  $$/  $$$$$$$/ $$/ 
                                                                                                          
                                                                                                          
                                                                                                          '
    end
    print box
  end

  def location_box
    box = TTY::Box.frame(
      width: 175,
      height: 25,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
      padding: 3
    ) do
      '       ______   __                                                                      __                                        __      __                      __ 
      /      \ /  |                                                                    /  |                                      /  |    /  |                    /  |
     /$$$$$$  |$$ |____    ______    ______    _______   ______          ______        $$ |        ______    _______   ______   _$$ |_   $$/   ______   _______  $$ |
     $$ |  $$/ $$      \  /      \  /      \  /       | /      \        /      \       $$ |       /      \  /       | /      \ / $$   |  /  | /      \ /       \ $$ |
     $$ |      $$$$$$$  |/$$$$$$  |/$$$$$$  |/$$$$$$$/ /$$$$$$  |       $$$$$$  |      $$ |      /$$$$$$  |/$$$$$$$/  $$$$$$  |$$$$$$/   $$ |/$$$$$$  |$$$$$$$  |$$ |
     $$ |   __ $$ |  $$ |$$ |  $$ |$$ |  $$ |$$      \ $$    $$ |       /    $$ |      $$ |      $$ |  $$ |$$ |       /    $$ |  $$ | __ $$ |$$ |  $$ |$$ |  $$ |$$/ 
     $$ \__/  |$$ |  $$ |$$ \__$$ |$$ \__$$ | $$$$$$  |$$$$$$$$/       /$$$$$$$ |      $$ |_____ $$ \__$$ |$$ \_____ /$$$$$$$ |  $$ |/  |$$ |$$ \__$$ |$$ |  $$ | __ 
     $$    $$/ $$ |  $$ |$$    $$/ $$    $$/ /     $$/ $$       |      $$    $$ |      $$       |$$    $$/ $$       |$$    $$ |  $$  $$/ $$ |$$    $$/ $$ |  $$ |/  |
      $$$$$$/  $$/   $$/  $$$$$$/   $$$$$$/  $$$$$$$/   $$$$$$$/        $$$$$$$/       $$$$$$$$/  $$$$$$/   $$$$$$$/  $$$$$$$/    $$$$/  $$/  $$$$$$/  $$/   $$/ $$/ 
                                                                                                                                                                     
                                                                                                                                                                     
                                                                                                                                                                     '
    end
    print box
  end

  def game_over_box
    box = TTY::Box.frame(
      width: 150,
      height: 20,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
      padding: 3
    ) do
      '  ______                                            ______                                 __ 
      /      \                                          /      \                               /  |
     /$$$$$$  |  ______   _____  ____    ______        /$$$$$$  | __     __  ______    ______  $$ |
     $$ | _$$/  /      \ /     \/    \  /      \       $$ |  $$ |/  \   /  |/      \  /      \ $$ |
     $$ |/    | $$$$$$  |$$$$$$ $$$$  |/$$$$$$  |      $$ |  $$ |$$  \ /$$//$$$$$$  |/$$$$$$  |$$ |
     $$ |$$$$ | /    $$ |$$ | $$ | $$ |$$    $$ |      $$ |  $$ | $$  /$$/ $$    $$ |$$ |  $$/ $$/ 
     $$ \__$$ |/$$$$$$$ |$$ | $$ | $$ |$$$$$$$$/       $$ \__$$ |  $$ $$/  $$$$$$$$/ $$ |       __ 
     $$    $$/ $$    $$ |$$ | $$ | $$ |$$       |      $$    $$/    $$$/   $$       |$$ |      /  |
      $$$$$$/   $$$$$$$/ $$/  $$/  $$/  $$$$$$$/        $$$$$$/      $/     $$$$$$$/ $$/       $$/ 
                                                                                                   
                                                                                                   
                                                                                                   '
    end
    print box
  end

  def choose_box
    box = TTY::Box.frame(
      width: 175,
      height: 20,
      align: :center,
      style: {
        fg: :yellow,
        bg: :black,
        border: {
          bg: :yellow
        }
      },
      padding: 3
    ) do
      '       ______   __                                                                      _______            __                                                    __ 
      /      \ /  |                                                                    /       \          /  |                                                  /  |
     /$$$$$$  |$$ |____    ______    ______    _______   ______          ______        $$$$$$$  | ______  $$ |   __   ______   _____  ____    ______   _______  $$ |
     $$ |  $$/ $$      \  /      \  /      \  /       | /      \        /      \       $$ |__$$ |/      \ $$ |  /  | /      \ /     \/    \  /      \ /       \ $$ |
     $$ |      $$$$$$$  |/$$$$$$  |/$$$$$$  |/$$$$$$$/ /$$$$$$  |       $$$$$$  |      $$    $$//$$$$$$  |$$ |_/$$/ /$$$$$$  |$$$$$$ $$$$  |/$$$$$$  |$$$$$$$  |$$ |
     $$ |   __ $$ |  $$ |$$ |  $$ |$$ |  $$ |$$      \ $$    $$ |       /    $$ |      $$$$$$$/ $$ |  $$ |$$   $$<  $$    $$ |$$ | $$ | $$ |$$ |  $$ |$$ |  $$ |$$/ 
     $$ \__/  |$$ |  $$ |$$ \__$$ |$$ \__$$ | $$$$$$  |$$$$$$$$/       /$$$$$$$ |      $$ |     $$ \__$$ |$$$$$$  \ $$$$$$$$/ $$ | $$ | $$ |$$ \__$$ |$$ |  $$ | __ 
     $$    $$/ $$ |  $$ |$$    $$/ $$    $$/ /     $$/ $$       |      $$    $$ |      $$ |     $$    $$/ $$ | $$  |$$       |$$ | $$ | $$ |$$    $$/ $$ |  $$ |/  |
      $$$$$$/  $$/   $$/  $$$$$$/   $$$$$$/  $$$$$$$/   $$$$$$$/        $$$$$$$/       $$/       $$$$$$/  $$/   $$/  $$$$$$$/ $$/  $$/  $$/  $$$$$$/  $$/   $$/ $$/ 
                                                                                                                                                                    
                                                                                                                                                                    
                                                                                                                                                                    '
    end
    print box
  end
end
