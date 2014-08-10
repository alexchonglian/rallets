require 'sinatra'
require 'sinatra/base'
require 'haml'

class Rallets < Sinatra::Base
  get '/login' do
    p "login"
    haml :login
  end

  get '/login/:name' do
    "Hello #{params['name']}!"
  end

  get '/send_btc/:amount' do |n|
    # matches "GET /hello/foo" and "GET /hello/bar"
    # params['name'] is 'foo' or 'bar'
    # n stores params['name']
    "sent #{n}!"
  end

  get '/send_btc/*/to/*' do |from, to|
    "sent btc from #{from} to #{to}"
  end

  get '/posts' do
    # matches "GET /posts?title=foo&author=bar"
    #title = params['title']
    #author = params['author']
    # uses title and author variables; query is optional to the /posts route
  end

  get '/time' do
    erb "<%= Time.now %>"
  end

  def login_in
    set(:auth) do |*roles|   # <- notice the splat here
      condition do
        unless logged_in? && roles.any? {|role| current_user.in_role? role }
          redirect "/login/", 303
        end
      end
    end

    get "/my/account/", :auth => [:user, :admin] do
      "Your Account Details"
    end

    get "/only/admin/", :auth => :admin do
      "Only admins are allowed here!"
    end
  end
  class Stream
    def each
      100.times { |i| yield "#{i}\n" }
    end
  end

  get('/count') { Stream.new }
end
