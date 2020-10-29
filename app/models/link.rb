class Link < ApplicationRecord
  GISTS_REGEX = /https:\/\/gist.github.com\//

  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, format: URI::regexp(%w[http https])

  def gist_url?
    url.match?(GISTS_REGEX)
  end

  def gist_url
    Octokit::Client.new.gist(url.split('/').last).files.map { |f| { name: f[0].to_s, content: f[1]['content'] } }
  end
end
