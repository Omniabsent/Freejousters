class RemoveFeedbackColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :projects, :feedback
    remove_column :proposals, :feedback
  end
end
