class CreateMapTypes < ActiveRecord::Migration
  def change
    create_table :map_types do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
  end
end
