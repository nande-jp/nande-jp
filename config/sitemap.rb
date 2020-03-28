# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.nande-kids.jp"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #

  Question.categories.keys.to_a.each do |category|
    add category_path(id: category), :priority => 0.3, :changefreq => 'daily'
  end

  Question.categories.keys.to_a.each do |category|
    3.upto(6).each do |age|
      add category_age_path(category_id: category, id: age), :priority => 0.5, :changefreq => 'daily'
    end
  end

  add questions_path, :priority => 0.2, :changefreq => 'daily'
  Question.find_each do |question|
    add questions_path(question), :lastmod => question.answers_count > 0 ? question.answers.order(created_at: :desc).first.created_at : question.updated_at
  end

  3.upto(6).each do |age|
    add age_path(id: age), priority: 0.5, changefreq: 'daily'
  end

  add rankings_path, priority: 0.5, changefreq: 'weekly'
end
