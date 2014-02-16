class TermsController < ApplicationController
  def show
    @term = Term.find(params[:id])
  end

  def new
    @term = Term.new
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
    @term = Term.find(params[:id])
  end
  
  def update
    @term = Term.find(params[:id])

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
      Termlink.dedupe
    end
    
    #if false
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
    #end
    
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
    i = 0
    @rezultat = []
    Term.where(:word => params[:inp]).each do |rijec| 
    unless rijec.nil?
      @max = Term.count_contexts(rijec)
      while i <= @max
      rez = Term.get_links(rijec,i)
      @rezultat.push i
      @rezultat.push rez
      i+=1
      end
    end
    end
  end

end
