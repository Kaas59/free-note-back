class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.integer :user_id, :null => false
      t.string :text
      t.boolean :share_flag, :default => false, :null => false
      t.integer :share_pass

      t.timestamps
    end
  end
end
