# verify pom gav matches their path
require 'rexml/document'

base_dir = ARGV[0]

base_dir = base_dir + "/" unless base_dir.rindex("/") == base_dir.length - 1

Dir[base_dir + "**/*.*"].each do |file|
  next if File.directory?(file)
  next unless file[-4..-1] == ".pom"

  begin
  xml = nil
  open(file) { |f| xml = f.read }
  doc = REXML::Document.new xml
  group_id = REXML::XPath.first(doc, "/project/groupId")
  artifact_id = REXML::XPath.first(doc, "/project/artifactId")
  version = REXML::XPath.first(doc, "/project/version")
  parent_group_id = REXML::XPath.first(doc, "/project/parent/groupId")
  parent_version = REXML::XPath.first(doc, "/project/parent/version")

  g = group_id == nil ? parent_group_id.text : group_id.text
  a = artifact_id.text
  v = version == nil ? parent_version.text : version.text

  path = file[base_dir.size, file.size - base_dir.size]
  if v[0,2] == '${'
    ga_path = g.to_s.gsub('.','/') + "/" + a + "/" 
    puts path unless ga_path == path[ 0, g.size + a.size + 2] 
  else
    gav_path = g.to_s.gsub('.','/') + "/" + a + "/" + v
    puts path unless gav_path == path[ 0, g.size + a.size + v.size + 2]
  end 

  rescue Exception => e
    puts e
    puts "#{file}  Invalid POM" 
  end
end
