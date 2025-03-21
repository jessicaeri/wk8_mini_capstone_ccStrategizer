class CreateCreditCards < ActiveRecord::Migration[8.0]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.string :bank
      t.string :custom_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
