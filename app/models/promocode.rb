class Promocode < ActiveRecord::Base
	validates_numericality_of :value, :message=>"El campo VALOR  ha de ser númerico"
	validates_numericality_of :days,  :message=>"El campo DIAS   ha de ser númerico"
	validates_presence_of :days, :message=>"El campo DIAS no puede estar en blanco"
	validates_presence_of :value, :message=>"El campo VALOR no puede estar en blanco"
end
