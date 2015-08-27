class CreateFruitBats < ActiveRecord::Migration
  def change
    create_table :fruit_bats do |t|
      t.string :fangs
    end
  end
end
