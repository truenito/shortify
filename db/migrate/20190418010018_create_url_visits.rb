class CreateUrlVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :url_visits do |t|
      t.references :url, index: true, foreign_key: true

      t.timestamps
    end
  end
end
