class RemovePointsPerDollarFromCategories < ActiveRecord::Migration[8.0]
  def change
    remove_column :categories, :points_per_dollar, :decimal
  end
end
