module HomeHelper
  def get_years
    @sections.order(year: :desc).distinct.pluck(:year)
  end
  
  def get_semesters
    Section.semesters.reverse!
  end
  
  def does_year_semester_exist(year, semester)
    @sections.where(year: year, semester: semester).any?
  end
  
  def get_sections(year, semester)
    @sections.where(year: year, semester: semester).order(number: :asc)
  end
end
