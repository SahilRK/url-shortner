class CreateShortUrls < ActiveRecord::Migration
  def change
    create_table :short_urls do |t|
      t.string :original_url
      t.string :shorty
      t.integer :visit_counts
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :short_urls, :users
  end
end
