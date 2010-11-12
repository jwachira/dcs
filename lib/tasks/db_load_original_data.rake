namespace :data do
  desc "Immunizations"
  task :immunizations => :environment do
    Immunization.create_or_update(:id => 1,  :name => 'Chicken Pox')
    Immunization.create_or_update(:id => 2,  :name => 'DPT/Td/TD'  )
    Immunization.create_or_update(:id => 3,  :name => 'Hepatatis B')
    Immunization.create_or_update(:id => 4,  :name => 'HIB Vaccine')
    Immunization.create_or_update(:id => 5,  :name => 'MMR Vaccine')
    Immunization.create_or_update(:id => 6,  :name => 'Mumps'      )
    Immunization.create_or_update(:id => 7,  :name => 'Measles'    )
    Immunization.create_or_update(:id => 8,  :name => 'Polio Vaccine')
    Immunization.create_or_update(:id => 9,  :name => 'PRP-D/HBPV/HBCV')
    Immunization.create_or_update(:id => 10, :name => 'TB PPD-Mantoux')
    Immunization.create_or_update(:id => 11, :name => 'TOPV/IPV')
    Immunization.create_or_update(:id => 12, :name => 'Rubella')
  end
  
  desc "Certifications"
	task :certifications => :environment do
	  Certification.create_or_update(:id => '1', :name => "CPR & First Aid")
	  Certification.create_or_update(:id => '2', :name =>  "CRN")
	  Certification.create_or_update(:id => '3', :name =>  "HHA")
	  Certification.create_or_update(:id => '4', :name => "Special Needs Care")
	end
	
	 desc "Languages"
	 task :languages => :environment do
	   Language.create_or_update(:id => 1, :name => "English")
	   Language.create_or_update(:id => 2, :name => "Chinese")
	   Language.create_or_update(:id => 3, :name => "Spanish" )
	   Language.create_or_update(:id => 4, :name => "French")
	   Language.create_or_update(:id => 5, :name => "Italian")
	   Language.create_or_update(:id => 6, :name => "German")
	   Language.create_or_update(:id => 7, :name => "Hindi")
	   Language.create_or_update(:id => 8, :name => "Korean")
	   Language.create_or_update(:id => 9, :name => "Vietnamese")
	   Language.create_or_update(:id => 10, :name => "Japanese")
	 end
	 
	 task "Holidays"
	 task :holidays => :environment do
	   Holiday.create_or_update(:id =>1, :name => "New Year's Day" )
	   Holiday.create_or_update(:id =>2, :name => "Martin Luther King Day")
	   Holiday.create_or_update(:id =>3, :name => "Presidents Day")
	   Holiday.create_or_update(:id =>4, :name => "Memorial Day")
	   Holiday.create_or_update(:id =>5, :name => "Independence Day")
	   Holiday.create_or_update(:id =>6, :name => "Labor Day")
	   Holiday.create_or_update(:id =>7, :name => "Columbus Day")
	   Holiday.create_or_update(:id =>8, :name => "Veterans' Day")
	   Holiday.create_or_update(:id =>9, :name => "Thanksgiving Day")
	   Holiday.create_or_update(:id =>10, :name => "Christmas Day")
	 end
end