class CreateShortVisits < ActiveRecord::Migration
  def change
    create_table :short_visits do |t|
      t.string :visitor_ip
      t.string :visitor_city
      t.string :visitor_state
      t.string :visitor_country_iso2
      t.references :short_url, index: true

      t.timestamps null: false
    end
    add_foreign_key :short_visits, :short_urls
  end
end
