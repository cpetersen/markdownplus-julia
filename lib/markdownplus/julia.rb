require "markdownplus/julia/version"
require "tempfile"

module Markdownplus
  module Julia
    class JuliaHandler < Handler
      def execute(input, parameters, variables, warnings, errors)
        output = nil
        file = Tempfile.new(['julia-script','.jl'])
        begin
          parameters.each_with_index do |param,i|
            if param.respond_to?(:to_julia)
              file.write(param.to_julia)
            else
              warnings << "Parameter [#{i}] does not respond to to_julia"
            end
          end
          file.write(input)
          file.close
          puts File.read(file.path)
          output = `julia #{file.path}`
          output.gsub!(/\n\s+/,"\n")
        ensure
          # file.unlink
        end
        output
      end
    end
    HandlerRegistry.register("julia", JuliaHandler)

    class DataFrameHandler < Handler
      class DataFrame
        attr_reader :name
        attr_reader :csv

        def initialize(name, csv)
          @name = name
          @csv = csv
        end

        def to_julia
          file = Tempfile.new(['data','.csv'])
          file.write(csv)
          file.close
          output = "#{name} = readcsv(\"#{file.path}\")\n"
        end
      end

      def execute(input, parameters, variables, warnings, errors)
        name = nil
        csv = nil
        if parameters==nil || parameters.count < 2
          errors << "Two parameters are required"
        else
          warnings << "More than two variables given" if parameters.count > 2
          name = parameters[0].to_s
          csv = parameters[1].to_s
        end
        DataFrame.new(name, csv)
      end
    end
    HandlerRegistry.register("dataFrame", DataFrameHandler)
  end
end
