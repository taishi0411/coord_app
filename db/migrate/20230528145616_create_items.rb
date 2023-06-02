class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.references :genre, foreign_key: true
      t.string :name
      t.integer :clean_index
      t.integer :heat_index
      t.integer :rgb
      t.integer :color_difference

      t.timestamps
    end
  end
end
