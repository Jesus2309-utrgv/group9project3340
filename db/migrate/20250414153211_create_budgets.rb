class CreateBudgets < ActiveRecord::Migration[8.0]
  def change
    create_table :budgets do |t|
      t.string :category
      t.decimal :amount

      t.timestamps
    end
  end
end
