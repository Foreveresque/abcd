class CreateTermlinks < ActiveRecord::Migration
  def change
    create_table :termlinks do |t|
      t.integer :term_id
      t.integer :link_id
      t.integer :context_id

      t.timestamps
    end
  end
end
