# frozen_string_literal: true

require 'bundler'
require 'sinatra/activerecord'
require 'require_all'
require 'rest-client'
require 'pry'
require 'poke-api-v2'
require 'tty-prompt'
require 'tty-box'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/pokemon.db'
)
ActiveRecord::Base.logger = nil
require_all 'lib'
