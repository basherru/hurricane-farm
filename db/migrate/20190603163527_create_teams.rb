class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :title, null: false, default: "unnamed"
      t.string :ip, null: false
      t.string :status, null: false, default: "active"

      t.timestamps
    end
  end
end
