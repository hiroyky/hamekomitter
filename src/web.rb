require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require 'date'
# 静的コンテンツ参照のためのパス設定
set :public, File.dirname(__FILE__) + '/public'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/uploader_list.db")
class Item
    include DataMapper::Resource
    property :id, Serial
    property :in_filename, Text, :required => true
    property :out_filename, Text, :required => true
    property :recttopleft, Text, :required =>true 
    property :rectbottomright, Text, :required =>true 
    property :done, Boolean, :required => true, :default => false
    property :created, DateTime
end
DataMapper.finalize.auto_upgrade!

def helloworld 
  puts "heelo world"
end

#動作テスト：ここから追加
debug_counter=0
before do
 debug_counter+=1
end

get '/?' do 
  @items = Item.all(:order => :created.desc)
  redirect '/upload' if @items.empty?
  erb :index
end

post '/upload' do
  if params[:file]
 
    save_path = "./public/images/#{params[:file][:filename]}"
 
    File.open(save_path, 'wb') do |f|
      p params[:file][:tempfile]
      f.write params[:file][:tempfile].read
      @mes = "アップロード成功"
    end
  else
    @mes = "アップロード失敗"
  end
  #erb :upload
  redirect 'images'
end


# アップロードした画像の表示
get '/images' do
  images_name = Dir.glob("public/images/*")
  @images_path = []
  
  images_name.each do |image|
    @images_path << image.gsub("public/", "./")
  end
  erb :images
end

get '/upload?' do 
  erb :upload
end

get '/debug_create' do
       Item.create(:in_filename => "Hello #{debug_counter.to_s}.jpg!" \
    ,:out_filename =>"hoge.jpg", :recttopleft=>"100,100",:rectbottomright=>"200,200"\
       ,:done => [true, false].sample  ,:created => Time.now)
end

get '/debug_show' do 
  Item.all.map {|r| "#{r.id}, #{r.in_filename},#{r.out_filename},#{r.recttopleft},,#{r.rectbottomright}, #{r.done}, #{r.created} <br>" }
end

get '/delete_all' do
 Item.each do |item|
   item.destroy
 end
end 

