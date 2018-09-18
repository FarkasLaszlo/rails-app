class Post < ApplicationRecord
  SEARCH_KEYS = {
    category: "categories.name",
    user: "users.name",
    title: "posts.title",
    content: "posts.content"
  }

  #ASSOCIATIONS
  has_many :comments, dependent: :destroy
  has_many :top_level_comments, -> { top_level }, class_name: "Comment"
  belongs_to :user
  has_and_belongs_to_many :categories
  validates :title, presence: true, length: { minimum: 5 }
  validates :content, presence: true
  validates :categories, presence: true

  default_scope { order(created_at: :desc) }

  def self.filter_by search_params
    values = []
    result = search_params
              .to_unsafe_h
              .inject([]) { |result_array, (key, value)| 
                if value.present?
                  values << "%#{value}%"
                  result_array << " #{SEARCH_KEYS[key.to_sym]} LIKE ? "
                end
                result_array
              }
              .join("AND") if search_params
    result.present? ? joins(:categories, :user).where(values.unshift(result)).distinct : where("true")
  end

end
