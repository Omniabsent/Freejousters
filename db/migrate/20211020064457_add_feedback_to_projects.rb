class AddFeedbackToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :feedback, :string
  end
end
