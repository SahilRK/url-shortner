class ShortUrl < ActiveRecord::Base
  belongs_to :user
  has_many :short_visits

  validates_uniqueness_of :original_url
  after_create :generate_short_url
  UNIQUE_SHORT_KEY = 5

  def generate_short_url
    charset = ('a'..'z').to_a + (0..9).to_a
    self.shorty = (0...UNIQUE_SHORT_KEY).map{ charset.to_a[rand(charset.size)] }.join
    self.save
  end

  def self.search_shorty(short_url)
    ShortUrl.where(shorty: "#{short_url}")
  end

  def self.update_short_visit_counts(orig_url_record, visit_counts)
    orig_url_record.first.update(visit_counts: visit_counts)
  end
end
