class Student < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_many :months, dependent: :destroy

  validates :first_name, :last_name, presence: true

  after_create :create_months

  private 

  def create_months
    school_year = current_school_year
    months = Month.create([
      {name: 'Septiembre', student: self, school_year: school_year},
      {name: 'Octubre', student: self, school_year: school_year},
      {name: 'Noviembre', student: self, school_year: school_year},
      {name: 'Diciembre', student: self, school_year: school_year},
      {name: 'Enero', student: self, school_year: school_year},
      {name: 'Febrero', student: self, school_year: school_year},
      {name: 'Marzo', student: self, school_year: school_year},
      {name: 'Abril', student: self, school_year: school_year},
      {name: 'Mayo', student: self, school_year: school_year},
      {name: 'Junio', student: self, school_year: school_year},
      {name: 'Julio', student: self, school_year: school_year},
    ])
  end

end
