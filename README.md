# PokeFight-V1
---
A simple turn based combat CLI application

### Requirements
---
- Ruby 2.6.3

### Installation
---
Fork and clone this repository if you intend on testing and editting

Make sure to install the dependencies using:
```md
bundle install
```
from your shell.

### Usage
---
Once you've installed all the dependencies you should be able to run the program by writing this command in your shell:
```md
ruby runner.rb
```
The ruby runner file requires the environment.rb file and creates a new Cli instance to call the main menu method on, thus starting the game.

The application uses RestClient and PokeApi to seed the pokemon and attacks into the database being used. The database is a sqlite3 database.



### Contributing
Contributing to the project is unadvised due to this being a school project my partner and I have written. However, feel free to use this project idea in any way you like.

### License
The origin for this project belongs to the Flatiron School Learn.co website.