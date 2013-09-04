module RCDB
  describe Field do
    let(:field) do
      Class.new do
        extend Field 
        class << self
          def name
            "SomeModule::Test"
          end

          def first(params)
            nil
          end

          def order_by(prop)
            []
          end
        end
      end
      end

      it "uses the last part of the name as the query_name" do
        field.query_name.must_equal "test"
      end

      it "creates a dropdown with its field_name" do
        field.queryer_html({}).must_include "test"
      end

      describe "filtering" do
        it "does nothing if there are no params for it" do
          dataset = mock
          dataset.expects(:where).never
          field.stubs(:find).returns(stub)
          field.filter_solves(mock, {})
        end

        it "filters based on a param that matches its query_name" do
          dataset = mock
          dataset.expects(:where).with(test_id: "test_id").once
          field.stubs(:find).returns({id: "test_id"})
          field.filter_solves(dataset, {"test" => "test_id"})
        end
      end
    end 
  end
