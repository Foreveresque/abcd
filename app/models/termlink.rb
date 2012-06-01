class Termlink < ActiveRecord::Base
  belongs_to :term
  belongs_to :link, :class_name => "Term" 
end
