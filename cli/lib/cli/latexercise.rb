require "thor"

module Cli
  class LaTeXercise < Thor
    include Thor::Actions
    include Thor::Shell
    
    desc "new NAME", "create new exercise sheet"
    def new(name)
      create_exercise_sheet!(name)
    end

    desc "compile FILENAME", "compile exercise sheet into a pdf"
    def compile(filename)
      check_if_file_exists!(filename)
      compile_to_latex!(filename)
      compile_to_pdf!(latex_filename(filename))
      # when filename = foo.exs then
      # - latex_filename = foo.exs.tex
      # - pdf_filename = foo.exs.pdf
      #
      # => we want foo.pdf
      rename_file pdf_filename(filename), "#{without_file_extension filename}.pdf"
      # cleanup after pdflatex
      run("rm #{filename}.*", :verbose => false)
      # give Preview.app focus to make changes visible
      activate_preview_app!
    end

    desc "latex FILENAME", "compile exercise sheet into LaTeX source"
    def latex(filename)
      check_if_file_exists!(filename)  
      compile_to_latex!(filename)
    end

    # this method is used by Thor::Actions
    def self.source_root
      File.expand_path("../", File.dirname(__FILE__))
    end

    def self.compiler_path
      File.expand_path("bin/latexerator", self.source_root)
    end

    private

    def compile_to_latex!(filename)
      unless run("#{self.class.compiler_path} #{filename}", :verbose => false) 
        raise_error "Error while compiling to LaTeX source"
      end

      success_message "compiled to LaTeX source"
    end


    def compile_to_pdf!(filename)
      unless run("pdflatex -interaction=batchmode #{filename} > /dev/null", :verbose => false)
        raise_error "Error while compiling to pdf"
      end

      success_message "compiled from LaTeX source to pdf"
    end


    def create_exercise_sheet!(name)
      template("templates/sheet.exs.tt", "#{name}.#{extension}", :verbose => false)
      success_message "created template #{name}.#{extension}"
    end


    def check_if_file_exists!(filename)
      unless File.exists?(File.expand_path(filename, destination_root))
        raise_error "#{filename} doesn't exists"
      end
    end


    def preview_app_is_running?
      result = run_applescript %{tell app "System Events" to count processes whose name is "Preview"} 
      result.to_i == 0 ? false : true
    end

    def activate_preview_app!
      if preview_app_is_running?
        run_applescript %{tell application "Preview" to activate} 
      end
    end


    def run_applescript(script)
      `osascript -e '#{script}'`
    end


    def rename_file(from, to)
      unless run("mv #{from} #{to}", :verbose => false)
        raise_error
      end
    end


    def extension
      "exs"
    end


    def latex_filename(orig_filename)
      "#{orig_filename}.tex"
    end


    def pdf_filename(orig_filename)
      "#{orig_filename}.pdf"
    end

    def without_file_extension(filename)
      File.basename(filename, File.extname(filename))
    end

    def success_message(message)
      shell.say "#{indent} #{make_green utf8_check}  #{message}"
    end

    def raise_error(message = nil)
      message = "Oops, something went wrong" unless message
      raise Thor::Error, make_red("#{indent} #{utf8_cross}  #{message}")
    end


    #######################
    ### shell output helper
    #######################

    def utf8_check
      "\xE2\x9C\x94"
    end

    def utf8_cross
      "\xE2\x9C\x96"
    end

    def indent
      "    "
    end

    def make_green(string)
      shell.set_color(string, Thor::Shell::Color::GREEN)
    end

    def make_red(string)
      shell.set_color(string, Thor::Shell::Color::RED)
    end

  end # LaTeXercise

end # Cli
