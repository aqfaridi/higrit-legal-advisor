include ActionView::Helpers::SanitizeHelper

class Post < ActiveRecord::Base
  belongs_to :users
  belongs_to :categories 
  has_many :voteposts
  has_many :comments
  has_many :postags
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]	


  after_save :update_words!

  def update_words!
    require 'htmlentities'; require 'nokogiri'
    doc = Nokogiri::HTML.parse(content)
    doc.xpath("//pre").remove.xpath("//code").remove
    words = doc.text.gsub(/\r\n/, '').downcase
    words = HTMLEntities.new.decode(sanitize(words, :tags => []))
    words = words.split(/\ |\.|\,|\!|\?|\//).reject(&:blank?).sort.join(',')
    words.gsub(/[^a-z\,]/i, '').split(',').reject(&:blank?).sort.join(',')
    update_columns(:words => words)
  end
  
  def update_related!
    posts = Post.all; related = {}
    ifd = inverse_document_frequency(posts)
    (posts - [self]).each do |post|
      score = 0
      intersection = self.words.split(',').multiset(post.words.split(','))
      intersection.each { |word| score += ifd[word] }
      related[post.id] = score
    end
    related = related.sort_by { |k,v| v }.reverse
    related = related.collect { |k,v| k }.first(3).join(',')
    update_columns(:related_posts => related)
  end
  
  def related
    Post.where(:id => related_posts.split(','))
  end
  
  def process_words(content)
    require 'htmlentities'; require 'nokogiri'
    doc = Nokogiri::HTML.parse(content)
    doc.xpath("//pre").remove.xpath("//code").remove
    words = doc.text.gsub(/\r\n/, '').downcase
    words = HTMLEntities.new.decode(sanitize(words, :tags => []))
    words = words.split(/\ |\.|\,|\!|\?|\//).reject(&:blank?).sort.join(',')
    words.gsub(/[^a-z\,]/i, '').split(',').reject(&:blank?).sort.join(',')
    self.update_columns(:words => words)
  end

  private

    def inverse_document_frequency(posts)
      words = {}
      posts.each do |post|
      	post.process_words(post.content) if post.words.blank?
        post.words.split(',').uniq.each do |word|
          words[word] = 0 if words[word].nil?
          words[word] += 1
        end
      end
      words.each do |word, freq|
        words[word] = Math.log(posts.size / freq)
      end
      words
    end


end
