class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :name 
      t.integer :destination_id
    end 
  end
end
