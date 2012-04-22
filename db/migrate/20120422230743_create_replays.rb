class CreateReplays < ActiveRecord::Migration
  def change
    create_table :replays do |t|
      t.string :dire
      t.string :radiant
      t.date :time

      t.timestamps
    end
  end
end
