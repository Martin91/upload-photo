class CreateMoments < ActiveRecord::Migration
  def change
    create_table :moments do |t|
      t.string :photo

      t.timestamps
    end
  end
end
