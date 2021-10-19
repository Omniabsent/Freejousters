class CreateFeedbacksToProfessionals < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks_to_professionals do |t|
      t.references :user, null: false, foreign_key: true
      t.references :proposal, null: false, foreign_key: true
      t.integer :professional_id
      t.string :message
      t.integer :stars

      t.timestamps
    end
  end
end
