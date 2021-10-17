class CreateProposals < ActiveRecord::Migration[6.1]
  def change
    create_table :proposals do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :presentation
      t.integer :charges
      t.integer :week_hours
      t.integer :total_hours
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
