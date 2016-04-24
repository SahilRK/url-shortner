class ChangeDefaultValueForVisitCounts < ActiveRecord::Migration
  def change
    change_column :short_urls, :visit_counts, :integer, :default => 0
  end
end
