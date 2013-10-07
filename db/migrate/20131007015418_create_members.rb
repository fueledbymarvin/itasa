class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :college
      t.string :year
      t.string :hometown
      t.string :major
      t.string :position
      t.string :fact
      t.string :place

      t.timestamps
    end
  end
end
