class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs
    
    def slug
        self.name.downcase.split(" ").join("-")
    end

    def self.find_by_slug(slug)
        name = slug.split("-").map{|part|part.capitalize}.join(" ")
        self.all.find{|artist| artist.name.downcase == name.downcase}
    end
    
end