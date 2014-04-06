class RemoveUrlFromTerms < ActiveRecord::Migration
  def change
    remove_index :terms, :url
    remove_column :terms, :url
  end
end
