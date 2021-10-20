class Drop < ActiveRecord::Migration[6.1]
  def change
    drop_table :feedbacks_to_professionals
  end
end
