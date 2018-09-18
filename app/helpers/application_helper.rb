module ApplicationHelper
  def creation_time_of object
    l(object.created_at)
  end
end