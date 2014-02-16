class Termlink < ActiveRecord::Base
  belongs_to :term, :foreign_key => "term_id", :class_name => "Term"
  belongs_to :link, :foreign_key => "link_id", :class_name => "Term"
  
  def self.dedupe
    # find all links and group them on keys which should be common
    grouped = all.group_by{|link| [link.term_id,link.link_id] }
    grouped.values.each do |duplicates|
      # the first one we want to keep right?
      first_one = duplicates.shift # or pop for last one
      # if there are any more left, they are duplicates
      # so delete all of them
      duplicates.each{|double| double.destroy} # duplicates can now be destroyed
    end
  end  
end
