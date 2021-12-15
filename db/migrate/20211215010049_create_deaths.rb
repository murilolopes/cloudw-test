class CreateDeaths < ActiveRecord::Migration[6.1]
  def change
    create_table :deaths do |t|
      t.references :game
      t.string :cause

      t.timestamps
    end
  end
end
