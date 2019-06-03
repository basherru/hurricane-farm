class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :title, null: false, default: "unnamed"
      t.string :host, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
