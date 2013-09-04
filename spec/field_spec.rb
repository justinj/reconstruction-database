module RCDB
  describe Field do
    let(:field) do
      Class.new do
        extend Field 
        class << self
          def name
            "SomeModule::TestModel"
          end
        end
      end
    end
  end 
end
