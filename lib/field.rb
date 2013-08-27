module RCDB
  module Field
    def queryer_html(params)
      ERB.new(File.read("views/dropdown.erb")).result(binding)
    end

    def field_name
      name.split("::").last
    end

    def query_name
      field_name.downcase
    end

    def filter_solves(dataset, params)
      property = find(name: params[query_name])
      if params[query_name] && property
        dataset.where((query_name + "_id").to_sym => property[:id])
      else
        dataset
      end
    end
  end
end
