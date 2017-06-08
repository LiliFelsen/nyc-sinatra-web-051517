class FiguresController < ApplicationController

  get '/figures/new' do
    @figures = Figure.all
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
      if params[:landmark][:name]
        @landmark = Landmark.create(params[:landmark])
        @landmark.figure = @figure
        @landmark.save
      end
      if params[:title][:name]
        @title = Title.create(params[:title])
        @title.figures << @figure
      end
      if params[:figure][:landmark_ids]
        params[:figure][:landmark_ids].each do |id|
          landmark_added = Landmark.find(id)
          landmark_added.figure = @figure
          landmark_added.save
        end
      end
      if params[:figure][:title_ids]
        params[:figure][:title_ids].each do |id|
          title_added = Title.find(id)
          title_added.figures << @figure
        end
      end
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  get "/figures/:id" do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    if params[:landmark][:name]
      @landmark = Landmark.create(params[:landmark])
      @landmark.figure = @figure
      @landmark.save
    end
    if params[:title][:name]
      @title = Title.create(params[:title])
      @title.figures << @figure
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |id|
        landmark_added = Landmark.find(id)
        landmark_added.figure = @figure
        landmark_added.save
      end
    end
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |id|
        title_added = Title.find(id)
        title_added.figures << @figure
      end
    end
    redirect "figures/#{@figure.id}"
  end

end
