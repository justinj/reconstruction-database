require "sequel"
require "yaml"
require "oauth"
require "rack-flash"
require "forwardable"

module Padrino
  IGNORE_NO_RENDERING_ENGINE = true
end
require "padrino-helpers"

require_relative "formatting_utils"
require_relative "queryable"
require_relative "field"
require_relative "taggable"

require_relative "model/solve"
require_relative "model/solver"
require_relative "model/puzzle"
require_relative "model/competition"
require_relative "model/average"
require_relative "model/tag"
require_relative "model/user"
require_relative "model/step"
require_relative "model/stat"
require_relative "model/stat_section"
require_relative "model/reconstructor"

require_relative "solve_time"

require_relative "query_parser"
require_relative "garronizer"
require_relative "roofpig_former"
require_relative "brest_parser/brest_parser"
require_relative "brest_parser/brest_stats"

require_relative "puzzle_renamer"
require_relative "../helpers/view_helpers"
require_relative "../helpers/helpers"
