require 'sinatra/activerecord'

require 'sinatra'
require './lib/team'
require './lib/player'
require './lib/game'
require 'pg'
require 'sinatra/reloader'
require 'pry'

get '/'  do
	erb :index
end

###games routing###

get '/games' do

	erb :game_form
end

post '/games' do
	home = rand(9)
	away = rand(9)
	@game = Game.create({ home_team_id: params['home_team'].to_i, away_team_id: params['away_team'].to_i, home_team_score: home, away_team_score: away, winning_team_id: nil })
	#binding.pry
	if home > away
		@game.update({ winning_team_id: params['home_team'].to_i})

	elsif away > home
		@game.update({ winning_team_id: params['away_team'].to_i})
	else
		@game.update({ winning_team_id: 0})
	end
	erb :results
end



###players routing###

get '/players' do
	erb :players
end

post '/players' do
	@player = Player.create(name: params['name'])
	redirect :players
end

get '/players/:id/edit' do
  @player = Player.find(params['id'].to_i)
	erb :player_edit
end

delete '/players/:id' do
  @player = Player.find(params['id'].to_i)
	@player.destroy
	redirect '/players'
end

patch '/players/:id' do
  @player = Player.find(params['id'].to_i)
	@player.update({ name: params['name'] }) if params['name'] != ''
	redirect '/players'
end

###teams routing###

get '/teams' do
	erb :teams
end

post '/teams' do
	@team = Team.create({name: params['name']})
	redirect :teams
end

get '/teams/:id/edit' do
	@team = Team.find(params['id'].to_i)
	erb :team_edit
end

patch '/teams/:id' do
	if params['player'] != 'players'
		@player = Player.find(params['player'])
		@player.update(team_id: params['id'].to_i)
	end

  @team = Team.find(params['id'].to_i)
	@team.update({name: params['name']}) if params['name'] != ''
	redirect :teams
end

delete '/teams/:id' do
  @team = Team.find(params['id'].to_i)
	@team.destroy
	redirect '/teams'
end
