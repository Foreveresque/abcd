class Term < ActiveRecord::Base
  has_many :termlinks
  has_many :links, :through => :termlinks
  has_many :inverse_termlinks, :class_name => "Termlink", :foreign_key => "link_id"
  has_many :inverse_links, :through => :inverse_termlinks, :source => :term
  
  attr_accessible :type
  attr_accessible :word
  
  set_inheritance_column :ruby_type
end
