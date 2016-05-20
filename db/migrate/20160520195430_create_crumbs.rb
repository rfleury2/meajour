class CreateCrumbs < ActiveRecord::Migration
  def change
    create_table :crumbs do |t|
      t.float :measurement
      t.datetime :record_date
      t.belongs_to :tail

      t.timestamps
    end
  end
end
