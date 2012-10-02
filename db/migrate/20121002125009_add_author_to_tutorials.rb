class AddAuthorToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :author, :string
    add_column :tutorials, :author_url, :string
  end
end
