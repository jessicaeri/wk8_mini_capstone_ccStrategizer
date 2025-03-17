class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.decimal :points_per_dollar
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
