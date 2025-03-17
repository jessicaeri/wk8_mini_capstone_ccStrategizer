class FixForeignKeyForCategories < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :categories, column: :credit_card_id
    add_foreign_key :categories, :credit_cards, column: :credit_card_id
  end
end
