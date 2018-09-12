class Post < ApplicationRecord
  SEARCH_KEYS = {
    category: "categories.name",
    user: "users.name",
    title: "posts.title",
    content: "posts.content"
  }

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :category_ids, presence: { message: "At least one category must be selected" } # TODO FL message i18n; lehet simán `validates :categories`

  # TODO FL ennyi osztálymetódust már szebb lenne class<<self blokkba tenni
  def self.filter_by search_params
    joins(:categories, :user).where(Post.filter_query search_params).order("created_at DESC").distinct
    # TODO FL minek a Post?
    #az #order metódus hash szintaxát direkt nem használod?
  end

  def self.filter_query search_params
    values = []
    values.unshift(query_string_from(search_params, values) || "posts.id IS NOT NULL") # TODO FL szerintem a || jobb helyen lenne a .filter_by metódusban - ha nincs mi alapján keresni, akkor ne is join-oljon
    values
  end

  def self.create_query_from data, query_string, values
    data.present? && values << "%#{data}%" && " #{query_string} LIKE ? " || nil # TODO FL no, ez szerintem közel átláthatlan... hogy a values-t csak azért eldobálod idáig, hogy itt push-solj bele... akkor már inkább ne bontsd ennyi metódusra
  end

  def self.query_string_from params_search, values
    result = []
    params_search && params_search.each { |key, value| result << create_query_from(value, SEARCH_KEYS[key.to_sym], values) } && result = result.compact.join("AND")
    result.present? && result
  end
end
