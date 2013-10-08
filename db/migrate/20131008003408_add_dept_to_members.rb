class AddDeptToMembers < ActiveRecord::Migration
  def change
    add_column :members, :dept, :string
  end
end
