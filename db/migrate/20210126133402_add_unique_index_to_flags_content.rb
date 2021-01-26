class AddUniqueIndexToFlagsContent < ActiveRecord::Migration[6.1]
  def change
    add_index :flags, :content, unique: true
  end
end
