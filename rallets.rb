require 'sinatra'
require 'sinatra/base'
require 'haml'

set :root, File.dirname(__FILE__)
enable :sessions

class Rallets < Sinatra::Base
  configure do
    #Load up database and blabla
  end

  before do
  end

  helpers do 
    def stat(page)
      session[page] ||= 0
      session[page] += 1
      p "#{page}:  #{session['index']}"
    end
  end
  get '/' do
    redirect '/index'
  end
  get '/index' do
    #stat 'index'
    haml :index
  end
end


Dir[settings.root + "/routes/**"].each do |route|
    require route
end
