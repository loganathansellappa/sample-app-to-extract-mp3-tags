class AudiosController < ApplicationController
  def index
    @audios = params[:search] ? Audio.search(params[:search]) : Audio.all
  end
  
  def new
   @audio = Audio.new
  end

  def create
   @audio =  Audio.new(params[:audio])  
   if @audio.save
    redirect_to audios_path,notice: "File uploaded successfully"
   else
     render "new"
   end
  end
end
