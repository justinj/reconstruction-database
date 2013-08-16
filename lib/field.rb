module ReconDatabase
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

    def filter(dataset, params)
      property = where(name: params[query_name]).first
      if params[query_name] && property
        dataset.where(query_name.to_sym => property)
      else
        dataset
      end
    end
  end
end
