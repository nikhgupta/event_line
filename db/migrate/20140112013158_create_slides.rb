class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.integer :event_id
      t.string :title, null: false
      t.text :description, null: true
      t.datetime :start_date, null: true
      t.datetime :end_date, null: true
      t.boolean :cover, default: false
      t.string :class_name, null: true

      t.timestamps
    end
  end
end
