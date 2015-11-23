class AddSampleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :sample, :boolean, default: false
  end
end
