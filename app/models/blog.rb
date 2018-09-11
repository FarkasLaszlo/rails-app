class Blog < ApplicationRecord
  SEARCH_KEYS = {
    category: "categories.name",
    user: "users.name",
    title: "blogs.title",
    content: "blogs.content"
  }

  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :category_ids, presence: { message: "At least one category must be selected" }

  def self.filter_by search_params
    joins(:categories, :user).where(Blog.filter_query search_params).order("created_at DESC").distinct
  end

  def self.filter_query search_params
    values = []
    values.unshift(query_string_from(search_params, values) || "blogs.id IS NOT NULL")
    values
  end

  def self.create_query_from data, query_string, values
    data.present? && values << "%#{data}%" && " #{query_string} LIKE ? " || nil
  end

  def self.query_string_from params_search, values
    result = []
    params_search && params_search.each { |key, value| result << create_query_from(value, SEARCH_KEYS[key.to_sym], values) } && result = result.compact.join("AND")
    result.present? && result
  end
end
