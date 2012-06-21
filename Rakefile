#!/usr/bin/env rake
require "bundler/gem_tasks"
require "git"
require "open-uri"
require 'zip/zip'

def unzip_file (file, destination)
  Zip::ZipFile.open(file) { |zip_file|
    zip_file.each { |f|
      f_path=File.join(destination, f.name)
      FileUtils.mkdir_p(File.dirname(f_path))
      zip_file.extract(f, f_path) unless File.exist?(f_path)
    }
  }
end

def update_version
  version_path = File.expand_path('../lib/jqmobi/rails/version.rb', __FILE__)
  version = File.read(version_path, :encoding => Encoding::UTF_8)
  yield version
  File.write(version_path, version)
end

desc %(Update both jq.mobi and jqmobi-ujs libraries)
multitask :default => ['update:jqmobi', 'update:ujs']

namespace :update do

  desc %(Update jq.mobi libraries)
  task :jqmobi do
    if ENV['JQMOBI']
      ver = ENV['JQMOBI']
      src = File.expand_path("../tmp/#{ver}", __FILE__)
      FileUtils.rm_rf(src)
      zip_path = File.expand_path("../tmp/#{ver}.zip", __FILE__)
      File.open(zip_path, "w") do |file|
        open("http://cloud.github.com/downloads/appMobi/jQ.Mobi/#{ver}.zip") { |f| file.write(f.read) }
      end
      unzip_file(zip_path, File.expand_path("../tmp/", __FILE__))
    else
      src = File.expand_path('../tmp/jqmobi', __FILE__)
      FileUtils.rm_rf(src)
      git = Git.clone('git://github.com/appMobi/jQ.Mobi.git', src)
      ver = git.revparse('HEAD')
    end
    dest = File.expand_path('../', __FILE__)
    FileUtils.copy(File.join(src, 'jq.mobi.js'), File.join(dest, 'vendor/assets/javascripts/jq.mobi.js'))
    FileUtils.copy(File.join(src, 'ui', 'jq.ui.js'), File.join(dest, 'vendor/assets/javascripts/jq.ui.js'))
    Dir.glob(File.join(src, 'plugins', '*.js')) do |file|
      FileUtils.copy(file, File.join(dest, 'vendor/assets/javascripts/plugins', File.split(file).last))
    end
    Dir.glob(File.join(src, 'plugins', 'css', '*.css')) do |file|
      FileUtils.copy(file, File.join(dest, 'vendor/assets/stylesheets/plugins', File.split(file).last))
    end
    update_version{|v| v.gsub!(/JQMOBI_VERSION = "[^"]+"/, "JQMOBI_VERSION = \"#{ver}\"") }
  end

  desc %(Update jqmobi-ujs library)
  task :ujs do
    FileUtils.rm_rf(File.expand_path('../tmp/jqmobi-ujs', __FILE__))
    git = Git.clone('git://github.com/mshibuya/jqmobi-ujs.git', File.expand_path('../tmp/jqmobi-ujs', __FILE__))
    FileUtils.copy(
      File.expand_path('../tmp/jqmobi-ujs/src/rails.js', __FILE__),
      File.expand_path('../vendor/assets/javascripts/jq.mobi_ujs.js', __FILE__)
    )
    update_version{|v| v.gsub!(/JQMOBI_UJS_VERSION = "[0-9a-f]{40}"/, "JQMOBI_UJS_VERSION = \"#{git.revparse('HEAD')}\"") }
  end
end
