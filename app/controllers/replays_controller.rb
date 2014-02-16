class ReplaysController < ApplicationController

  # GET /replays
  # GET /replays.json
  def index
    @replays = Replay.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @replays }
    end
  end

  # GET /replays/1
  # GET /replays/1.json
  def show
    @replay = Replay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @replay }
    end
  end

  # GET /replays/new
  # GET /replays/new.json
  def new
    @replay = Replay.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @replay }
    end
  end

  # GET /replays/1/edit
  def edit 
    @replay = Replay.find(params[:id])
  end

  def eudict
    @b = Time.now
    word = params[:word]
    @smet = [] 
    
    if false
    #eudict dio  
    
   
    unless word.nil?
    agent = Mechanize.new
      
    page = agent.get('http://eudict.com/?word=' + word + '&lang=croeng')
    page.search(".//img").remove
    page.search("td[class='lang']").remove
    page.search("td[contains(' ')]").remove
    page.search("//div[@id='content']//table")
    @items=page.search('//tr/td[2]').map {|item| item.text}    
    @i=1
      
      @items.each do |x|
      page = agent.get('http://eudict.com/?word=' + x + '&lang=engcro')
      page.search(".//img").remove
      page.search("td[class='lang']").remove
      page.search("td[contains(' ')]").remove
      page.search("//div[@id='content']//table")
      smeti=page.search('//tr/td[2]').map {|aha| aha.text}
      @i=@i+1
        smeti.each do |y|
          if ((@smet.include? y) || y == word || ("u".include?(y[-1,1].downcase) || 
             ("i".include?(y[-1,1].downcase) && !("ti".include?(word[-2,2].downcase))) ||
             (!("i".include?(y[-1,1].downcase)) && ("ti".include?(word[-2,2].downcase)) )))
          next
          else 
            @smet << y       
          end
        end
      end
    end
    end
          
    #self dio
    unless word.nil?
    agent = Mechanize.new
      
    page = agent.get('http://empty-robot-3254.heroku.com/terms?inp=' + word)
    page.links.each do |link|    
      @smet << link.text          
    end
    end
    
  end
  
  # POST /replays
  # POST /replays.json
  def create 
    @replay = Replay.new(params[:replay])
    
    respond_to do |format|
      if @replay.save
        format.html { redirect_to @replay, notice: 'Replay was successfully created.' }
        format.json { render json: @replay, status: :created, location: @replay }
      else
        format.html { render action: "new" }
        format.json { render json: @replay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /replays/1
  # PUT /replays/1.json
  def update
    @replay = Replay.find(params[:id])

    respond_to do |format|
      if @replay.update_attributes(params[:replay])
        format.html { redirect_to @replay, notice: 'Replay was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @replay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /replays/1
  # DELETE /replays/1.json
  def destroy
    @replay = Replay.find(params[:id])
    @replay.destroy

    respond_to do |format|
      format.html { redirect_to replays_url }
      format.json { head :no_content }
    end
  end
end
