class AddFbidToMembers < ActiveRecord::Migration
  def change
    add_column :members, :fbid, :string
  end
end
