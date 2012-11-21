class Term < ActiveRecord::Base  
  def to_param  # overridden
    word
  end

  def self.get_links(word)
    @rez = [] 
    if term = Term.find_by_word(word)
      Termlink.where("term_id = ?", term.id).each do |link|
        rijec = Term.find(link.link_id)
        if @rez.map{|a| a.word}.include? rijec.word
          link.destroy
        else
          @rez.push rijec
        end
      end
     end 
     return @rez
  end
end
