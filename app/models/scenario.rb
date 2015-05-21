class Scenario < ActiveRecord::Base
  validates :name,
    presence: {},
    format: { with: /[a-zA-Z]/, allow_blank: true, message: "must contain at least 1 letter"}

  default_scope { order("name ASC") }

  def initialize(name)
    super(name: name)
  end
end
