class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.text :previous_content
      t.references :item, polymorphic: true
      t.integer :action, null: false
      t.references :user, null: false

      t.datetime :created_at
    end
  end
end
