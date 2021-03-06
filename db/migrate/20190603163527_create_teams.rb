# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :title, null: false, default: "Unknown"
      t.string :host, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
