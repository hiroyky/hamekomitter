require 'sinatra'
require 'sinatra/reloader'
require 'json'
 get '/' do   
    erb :test
 end
 
 get '/hoge' do
  redirect '/'
 end
