require 'guard'
require 'guard/guard'

module Guard
  class Latexercise < Guard

    def initialize(watchers = [], options = {})
      super
    end

    def start
    end

    def stop
    end

    def reload
    end

    def run_all
    end

    def run_on_changes(paths)
      paths.each do |path|
        compile_latexercise path
      end
    end

    def run_on_removals(paths)
    end

    private

    def compile_latexercise(path)
      system("latexercise compile #{path}")
    end

  end
end
