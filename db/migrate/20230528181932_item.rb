class Item < ActiveRecord::Migration[5.2]
  def change
    def change
      create_table :items do |t|
        t.references :user, foreign_key: true, type: :integer
        t.references :genre, foreign_key: true, type: :integer
        t.string :name
        t.integer :clean_index
        t.integer :heat_index
        t.integer :rgb
        t.integer :color_difference
  
        t.timestamps
      end
    end
  end
end
