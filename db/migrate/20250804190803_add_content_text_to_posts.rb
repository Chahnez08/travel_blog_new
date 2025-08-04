class AddContentTextToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :content_text, :text
  end
end
