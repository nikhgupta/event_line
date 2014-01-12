class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description, null: true
      t.integer :language_id, default: 9
      t.integer :map_type_id, default: 4
      t.integer :font_id, default: 4
      t.boolean :start_at_end, default: false
      t.integer :start_at_slide, default: 0
      t.integer :start_zoom_adjust, default: 0
      t.boolean :hash_bookmark, default: true
      t.boolean :debug, default: false

      t.timestamps
    end
  end
end
