require 'gossip'
require 'bundler'
Bundler.require

class ApplicationController < Sinatra::Base
  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    gossip_author = params['gossip_author']
    gossip_content = params['gossip_content']
    gossip_id = params['gossip_id']

    gossip = Gossip.new(gossip_id, gossip_author, gossip_content)
    gossip.save

    redirect '/'
  end

  get '/' do
    erb :index, locals: { gossips: Gossip.all }
  end

  get '/gossips/:id/' do
    gossip_id = params['id'].to_i
    gossip = Gossip.find(gossip_id)

    if gossip != nil
      erb :show, locals: { gossip: gossip }
    else
      "Potin non trouvé ou inexistant"
    end
  end
end