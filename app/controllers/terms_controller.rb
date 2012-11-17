class TermsController < ApplicationController
  def show
    @term = current_term
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
  
 def store
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
      

      if Term.exists?(:word => word, :wordtype => tip)
        current_term = Term.where("word = ?", word).first
        list.each do |item|
          links = item.gsub(/\n/,"").split(",")

          links.each do |link|
              if !(Term.exists?(:word => link))
                link_entry = Term.new(:word => link, :wordtype => tip)
                link_entry.save          
              end
              link_entry = Term.where("word = ?", link).first
              @termlink = Termlink.new(:term_id => current_term[:id], :link_id => link_entry[:id], :context_id => context)
              @termlink.save
              @termlink = Termlink.new(:term_id => link_entry[:id], :link_id => current_term[:id], :context_id => 0)
              @termlink.save
          end
          
          links.each do |link|
            link_entry = Term.where("word = ?", link).first      
            links.each do |lobster|
                if link != lobster
                    current_lobster = Term.where("word = ?", lobster).first
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
      else
        Term.new(:word => word, :wordtype => tip).save
      end
   end       
  end
  
  def rshj
    @b = Time.now
    input = params[:inp]
    @rez = [] 
    
    unless input.nil?
      id = Term.select(:id).where("word = ?", input)
      Termlink.find_each(:conditions => ["term_id = ?", id]) do |link|
        rijec = Term.select(:word).where("id = ?", link.link_id).map(&:word)
        if @rez.include? rijec
          link.destroy
        else
          @rez << rijec
        end
      end
    end
  end

end
