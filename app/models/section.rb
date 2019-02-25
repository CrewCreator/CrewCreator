class Section < ApplicationRecord
  #require 'smarter_csv'
  require 'csv'
  belongs_to :course, touch: true, validate: true, autosave: true
  has_many :projects, dependent: :delete_all
  has_many :teams, through: :projects
  has_and_belongs_to_many :students
  has_and_belongs_to_many :instructors
  has_and_belongs_to_many :emails
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  validates_presence_of :number, :semester, :year
  
  validates_numericality_of :number, :year, only_integer: true
  
  validates_inclusion_of :number, :year, in: 1..9999
  
  validates_uniqueness_of :number, :scope => [:course, :semester, :year]
  
  def method_missing(m, *args, &block)
    if m.to_s=="name"
      self.send("number")
    else
      super
    end
  end 
  
  def self.import(file, section)
    #f = File.open(file.tempfile, "r:bom|utf-8")
    #emailsCSV = SmarterCSV.process(f, row_sep: :auto, :file_encoding => "utf-8")
    csv_text = File.read(file.tempfile)
    emailsCSV = CSV.parse(csv_text)
    emailsCSV = emailsCSV.flatten
    puts "Section id: #{section}"
    @section = Section.find_by_id(section)
    puts "localSection: #{@section}"
    puts "Email array imported: #{emailsCSV}"
    counter = 0
    emailsCSV.each do |csv_email|
      emailObj = Email.find_by_email(csv_email)
      puts "Conditional logic: #{emailObj}"
      if emailObj
        @section.emails << emailObj
      else
        # create new email
        @section.emails << csv_email
      end
    end
    
    puts "Imported #{counter} emails"
  end 

  scope :by_priority, -> { order(order_by_case) }
  
  def Section.semesters
    ['Spring', 'Summer', 'Fall', 'Winter']
  end
  
  def self.order_by_case
    ret = "CASE"
    Section.semesters.reverse!.each_with_index do |s, i|
      ret << " WHEN semester = '#{s}' THEN #{i}"
    end
    ret << " END"
  end
end
