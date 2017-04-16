class CreateEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :entities do |t|
      t.string :url
      t.string :short_url
      t.timestamps
    end
  end
end
