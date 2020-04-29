class DestinationsController < ApplicationController
  
  get '/destinations' do
    @destinations = Destination.all
    erb :'destinations/index'
  end


  get '/destinations/new' do
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    erb :'destinations/new'
  end

  post '/destinations' do
    destination = Destination.create(params)
    user = Helpers.current_user(session)
    destination.user = user
    destination.save
    redirect to "/destinations/#{user.id}"
  end

  get '/destinations/:id' do
    if !Helpers.is_logged_in?(session)
      redirect '/'
    end
    @destination = Destination.find_by(id: params[:id])
    if !@destination
      redirect to '/'
    end
    erb :'destinations/show'
  end


  get '/destinations/:id/edit' do
      @destination = Destination.find_by(id: params[:id])
    if !Helpers.is_logged_in?(session) || !@destination || @destination.user != Helpers.current_user(session)
      redirect '/'
    end
    erb :'/destinations/edit'
  end
  
 
  
  post '/destinations/alpha' do 
     destination = Destination.create(params)
     destination.sort_by {|destination| destination }
    user = Helpers.current_user(session)
    destination.user = user
    destination.save
  end 

  patch '/destinations/:id' do
    destination = Destination.find_by(id: params[:id])
    if destination && destination.user == Helpers.current_user(session)
      destination.update(params[:destination])
      redirect to "/destinations/#{destination.id}"
    else
      redirect to "/destinations"
    end
  end

  delete '/destinations/:id/delete' do
    destination = Destinations.find_by(id: params[:id])
    if destination && destination.user == Helpers.current_user(session)
      destination.destroy
    end
    redirect to '/destinations'
  end


end