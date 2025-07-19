class AddResponseToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :response, :text
  end
end
