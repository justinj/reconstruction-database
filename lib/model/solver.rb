module ReconDatabase
  class Solver < Sequel::Model
    extend Field
    one_to_many :solves, class: Solve

    def to_s
      name
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
