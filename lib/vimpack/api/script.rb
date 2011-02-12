module Vimpack
  module Api

    class Script
      include ActiveModel::Serialization
        
      #attr_accessor :name, :email, :content  
       
      #validates_presence_of :name  
      #validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i  
      #validates_length_of :content, :maximum => 500  
        
      def initialize(attributes = Hash.new)
        attributes.each do |name, value|  
          send("#{name}=", value)  
        end  
      end  
        
      def self.search(pattern)
      end

    end

  end
end
