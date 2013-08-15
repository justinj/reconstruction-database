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
        "at #{name}"
      end
    end
  end
end
