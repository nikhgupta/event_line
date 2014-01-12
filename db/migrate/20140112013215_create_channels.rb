class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :slide_id
      t.text :url, null: false
      t.text :thumbnail, null: true
      t.text :caption, null: true
      t.string :credit, null: true

      t.timestamps
    end
  end
end
