class CreateQueries < ActiveRecord::Migration
  def change
    create_table :queries do |t|
      t.string :val

      t.timestamps
    end
  end
end
