class Term < ActiveRecord::Base
  def to_param  # overridden
    word
  end
  
  def self.count_contexts(word)
    if term = Term.find_by_word(word)
      @count = Termlink.where(:term_id => term.id).maximum(:context_id)
    end
    return @count
  end

  def self.get_links(word,context)
    
    @rez = [] 
    if term = Term.find_by_word(word)
      termlink = Termlink.where(:term_id => term.id, :context_id => context)
      termlink.each do |link|
      rijec = Term.where(:id => link.link_id,
      :wordtype => term.wordtype).first
        unless rijec.nil?    
          @rez.push rijec
        end   
      end
    end 
    @rez = @rez.sort_by { |a| a.word.uncolate }
    return @rez
  end
end
