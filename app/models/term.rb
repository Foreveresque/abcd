class Term < ActiveRecord::Base
  has_many :termlinks, :foreign_key => "term_id", :class_name => "Termlink", :dependent => :delete_all
  has_many :links, :through => :termlinks
  
  def linkify(term)
    # TODO: put in check that association does not exist
    self.links << term
    term.links << self
  end
  
  def self.count_contexts(term)
    @count = Termlink.where(:term_id => term.id).maximum(:context_id)
    return @count
  end

  def self.get_links(term,context)
    
    @rez = []
    @abc = []
    term.termlinks.each do |termlink|
      if termlink.link
      if (termlink.context_id == context and termlink.link.wordtype == term.wordtype) 
          @rez.push termlink 
      end
      else
        @abc.push termlink.id
      end
    end
    @rez = @rez.sort_by { |a| a.link.word.uncolate }
    @rez = @rez + @abc
    return @rez
  end
end
