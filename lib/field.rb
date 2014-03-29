module RCDB
  module Field
    include Queryable

    def field_name
      name.split("::").last
    end

    def query_name
      field_name.downcase
    end

    def filter_solves(dataset, params)
      property = find(name: params[query_name])
      if !params[query_name].blank? && property
        dataset.where((query_name + "_id").to_sym => property[:id])
      else
        dataset
      end
    end
  end
end
