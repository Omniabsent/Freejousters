class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.string :name
      t.string :social_name
      t.date :birth_date
      t.string :major
      t.string :bio
      t.string :experience
      t.string :picture

      t.timestamps
    end
  end
end
