class TermsController < ApplicationController
  load_and_authorize_resource
    
  def show
  end

  def new
  end
  
  def eudict
    @b = Time.now
    word = params[:word]
    @smet = [] 
    
    if false #startiffalse 
    
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
    
    
    end #endiffalse
  end

  def create
    @term = Term.new(params[:term])
    if @term.save
      flash[:notice] = "Pojam dodan"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to @term, notice: 'Term was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    term = Term.find(params[:id])
    term.termlinks.each do |termlink|
      if inversetermlink = Termlink.find_by_term_id_and_link_id(termlink.link.id,term.id)
        inversetermlink.destroy
      end
    end
    
    term.destroy

    respond_to do |format|
      format.html { redirect_to terms_url }
      format.json { head :no_content }
    end
  end
  
  def store
    
    if false
    @rez=[]
    id=1
    
    while Term.where(:id => id).present?
      term = Term.where(:id => id).first
      Termlink.where("term_id = ?", id).each do |link|
        rijec = Term.where(:id => link.link_id,
        :wordtype => term.wordtype).first
        unless rijec.nil?    
          if @rez.map{|a| a.word}.include? rijec.word
            link.destroy
          else
            @rez.push rijec
          end
        end
      end
      id+=1
      @rez.clear
    end
    end
    
    if false    
    File.readlines('rshj.txt').each do |line|
      require 'iconv' unless String.method_defined?(:encode)
      if String.method_defined?(:encode)
      line.encode!('UTF-8', 'UTF-8', :invalid => :replace)
      else
      ic = Iconv.new('UTF-8', 'UTF-8//IGNORE')
      line = ic.iconv(line)
      end
      
      word = line.split(",")[0]
      tip = line.split(",")[1]
      list = line.split(",").from(2).join(",").split(",x,")
      context = 1
      
  
        
      current_term = Term.find_or_create_by_word_and_wordtype(:word => word, :wordtype => tip) # MOTHER OF LINES
      
      list.each do |item|
        links = item.gsub(/\n/,"").split(",")

        links.each do |link|
            
            link_entry = Term.find_or_create_by_word_and_wordtype(:word => link, :wordtype => tip)
            
            @termlink = Termlink.new(:term_id => current_term[:id], :link_id => link_entry[:id], :context_id => context)
            @termlink.save           
            @termlink = Termlink.new(:term_id => link_entry[:id], :link_id => current_term[:id], :context_id => 0)
            @termlink.save           
        end
          
        links.each do |link|
          link_entry = Term.where(:word => link, :wordtype => tip).first 
          links.each do |lobster|
              if link != lobster
                  current_lobster = Term.where(:word => lobster, :wordtype => tip).first
                  @termlink = Termlink.new(:term_id => current_lobster[:id], :link_id => link_entry[:id], :context_id => 0)
                  @termlink.save
                  @termlink = Termlink.new(:term_id => link_entry[:id], :link_id => current_lobster[:id], :context_id => 0)
                  @termlink.save              
              end
          end
          links = links.from(1)
        end
       context += 1
      end     
        
    end
    end  
  end
  
  def index
    @b = Time.now
    counter = 0
    @rezultat = Hash.new {|h,k| h[k]=[]}
    unless params[:inp].nil?
      Term.where(:word => params[:inp].gsub('+', '/').gsub('_', ' ')).each do |rijec|    
        unless rijec.nil?      
        if Term.zero_context(rijec)
          @ostalo = 1
        else
          @ostalo = 0
        end   
          @max = Term.count_contexts(rijec)
          counter += @max
          i = 1
          while i <= @max
            if @ostalo == 1
              j = i - 1
            else
              j = i
            end
            rez = Term.get_links(rijec,j)
            unless rez.empty?
              if counter > @max and j > 0
                j = j + counter - @max - 1
              end
              @rezultat[j+1] << rez
            end
            i += 1
          end
        end 
      end
    @searched = 1
    @max = counter
    end
  end
end
