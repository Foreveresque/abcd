# encoding: UTF-8

module TermsHelper
  def capitalcro(word)
    case word 
    when "č" then
      word = word.gsub("č","Č")
    when "š" then
      word = word.gsub "š", "Š"
    when "ž" then
      word = word.gsub "ž", "Ž"
    when "đ" then
      word = word.gsub "đ", "Đ"
    end
  return word
  end
end
