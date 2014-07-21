class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.string :requested_by
      t.integer :position
      t.belongs_to :playlist, index: true
      t.belongs_to :song, index: true

      t.timestamps
    end
  end
end
