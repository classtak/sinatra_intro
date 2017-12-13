require 'sinatra'
require 'sinatra/reloader'
require 'csv'

before do
  p '*************************************'
  p params
  p '*************************************'
end

get '/' do
  send_file 'index.html'
end

# form 에서 글 쓰는 곳
get '/post' do
  erb :post
end

get '/complete' do
  @title = params[:title]
  @content = params[:content]
  CSV.open('post.csv', 'a+:utf-8') do |csv|
    csv << [@title, @content]
  end
  erb :complete
end

get '/posts' do
  @posts = []
  CSV.foreach('post.csv',encoding: 'utf-8') do |row|
    @posts << row
  end
  erb :posts
end
