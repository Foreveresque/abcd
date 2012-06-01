class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :word
      t.string :type
      t.string :meaning

      t.timestamps
    end
  end
end
