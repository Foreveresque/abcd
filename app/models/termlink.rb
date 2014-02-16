class Termlink < ActiveRecord::Base
  belongs_to :term, :foreign_key => "term_id", :class_name => "Term"
  belongs_to :link, :foreign_key => "link_id", :class_name => "Term"
end
