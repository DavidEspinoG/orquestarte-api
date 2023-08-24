class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def current_school_year 
    SchoolYear.first
  end
end
