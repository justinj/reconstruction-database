module ReconDatabase
  class Competition < Sequel::Model
    extend Field
    one_to_many :solves, class: Solve

    def to_s
      name
    end

    def at
      if name == "Unofficial"
        ""
      else
        "at #{link}"
      end
    end

    def url
     "https://www.worldcubeassociation.org/results/c.php?i=#{code}"
    end

    def link
      "<a href=#{url}>#{name}</a>"
    end
  end
end
