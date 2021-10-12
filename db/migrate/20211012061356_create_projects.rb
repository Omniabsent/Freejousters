class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :wanted_skills
      t.integer :max_pay
      t.date :expiration_date
      t.boolean :remote

      t.timestamps
    end
  end
end
