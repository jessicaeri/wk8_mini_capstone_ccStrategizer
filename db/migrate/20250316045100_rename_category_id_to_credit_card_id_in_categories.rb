class RenameCategoryIdToCreditCardIdInCategories < ActiveRecord::Migration[8.0]
  def change
    rename_column :categories, :category_id, :credit_card_id
  end
end
