module RCDB
  class Solver < Sequel::Model
    extend Field
    one_to_many :averages

    def to_s
      name.to_s
    end

    def name_link
      if wca_id.nil?
        name
      else
       "<a href='https://www.worldcubeassociation.org/results/p.php?i=#{wca_id}' target='_blank'>#{name}</a>"
      end
    end
  end
end
