class AddAssassinAndVictmToDeath < ActiveRecord::Migration[6.1]
  def change
    add_reference :deaths, :assassin, foreign_key: { to_table: :players }, null: true
    add_reference :deaths, :victim, foreign_key: { to_table: :players }
  end
end
