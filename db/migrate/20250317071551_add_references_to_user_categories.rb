class AddReferencesToUserCategories < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_categories, :credit_card, null: false, foreign_key: true
    add_reference :user_categories, :category, null: false, foreign_key: true
    add_column :user_categories, :points_per_dollar, :decimal, default: 1.0
  end
end
