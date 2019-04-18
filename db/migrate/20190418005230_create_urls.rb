class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :original_link
      t.string :shortened_link
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
