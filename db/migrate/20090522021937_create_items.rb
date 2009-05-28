class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.boolean :done
      t.integer :priority
      t.string :description
      t.date :due_date
      t.integer :category_id
      t.integer :note_id
      t.boolean :private

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
