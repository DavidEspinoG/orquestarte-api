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
      {name: 'Septiembre 2023', student: self, school_year: school_year, price: 1400},
      {name: 'Octubre 2023', student: self, school_year: school_year, price: 1400},
      {name: 'Noviembre 2023', student: self, school_year: school_year, price: 1400},
      {name: 'Diciembre 2023', student: self, school_year: school_year, price: 1400},
      {name: 'Enero 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Febrero 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Marzo 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Abril 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Mayo 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Junio 2024', student: self, school_year: school_year, price: 1400},
      {name: 'Julio 2024', student: self, school_year: school_year, price: 1400},
    ])
  end

end
