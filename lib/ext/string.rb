# frozen_string_literal: true

# Adding a method to the inbuilt class, String

class String
  def is_blank?
    regex_blank = /\A[[:space:]]*\z/
    regex_blank.match?(self)
  end
end
