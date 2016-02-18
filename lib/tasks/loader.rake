desc 'Loads instrument'
task :load_instruments => :environment do
  Dir.chdir 'M:/bundles'
  folders = Dir.entries(".").reject { |x| x[0,1] == "." }

  folders.each do |folder|

    if File.exist? folder + '/ddi.xml'

      im = XML::CADDIES::Importer.new(folder + '/ddi.xml')
      im.parse

    end

  end

end

desc 'Loads dataset'
task :load_datasets => :environment do
  Dir.chdir 'M:/build/datasets'
  files = Dir.entries(".").reject { |x| x[0,1] == "." }

  files.each do |file|

    if File.exist? file

      da = XML::Sledgehammer::Importer.new(file)
      da.parse

    end

  end

end