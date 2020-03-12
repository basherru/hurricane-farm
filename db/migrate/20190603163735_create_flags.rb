# frozen_string_literal: true

class CreateFlags < ActiveRecord::Migration[5.2]
  def change
    create_table :flags do |t|
      t.string :content, null: false
      t.references :team
      t.references :exploit
      t.integer :status, null: false, default: 0, index: true
      t.float :pts, null: false, default: 0, index: true

      t.timestamps
    end
  end
end
