class Subject < ActiveRecord::Base
 
  #Link to HABTM programme_subject
  has_and_belongs_to_many :programmes
  
  #Link to model topics
  has_many :topics#, :class_name => 'Topic', :foreign_key => 'subject_id'  
  
  #Link to model exam
  has_many :subject, :class_name => 'Examquestion', :foreign_key => 'curriculum_id', :dependent => :destroy
  
  #Link to model courseevaluation
  has_many :subjectevaluate, :class_name => 'Courseevaluation', :foreign_key => 'subject_id'
  
  #Link to model timetableentry
  has_many :time_table_entries, :dependent => :delete_all
  
  #Link to Model Grade
  has_many :subjectgrade,  :class_name => 'Grade', :foreign_key => 'subject_id'
  
  
  def subject_code_with_subject_name
     "#{subjectcode}  #{name}"
   end
  
  
    
SEMESTER = [
            #  Displayed       stored in db
            [ "Tahun 1/Semester I","1" ],
            [ "Tahun 1/Semester II","2" ],
            [ "Tahun 2/Semester I","3" ],
            [ "Tahun 2/Semester II","4" ],
            [ "Tahun 3/Semester I","5" ],
            [ "Tahun 3/Semester II","6" ],
            
]


STATUS = [
                #  Displayed       stored in db
                [ "Major","1" ],
                [ "Minor","2" ],
                [ "Elective","3" ]

    ]
    
     
end
