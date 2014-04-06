class AddUrlToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :url, :string, :nil => false
    add_index :terms, :url, :unique => true

    Term.initialize_urls
  end
end
