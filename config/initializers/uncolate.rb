#!/bin/env ruby
# encoding: utf-8

class String
  def uncolate
    self.tr('č','cz').tr('ć','cz').tr('š','sz').tr('đ','dz').tr('dž','dz')
  end
end