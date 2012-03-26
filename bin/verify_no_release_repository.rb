# verify the pom does not contain <repository> and <pluginRepository>
# note that here is a white list

require 'rexml/document'

base_dir = ARGV[0]

base_dir = base_dir + "/" unless base_dir.rindex("/") == base_dir.length - 1

@white_list = [ 'http://download.java.net/maven/2',
  'http://download.java.net/maven/2/',
  'http://scala-tools.org/repo-releases',
  'http://scala-tools.org/repo-releases/',
  'http://clojars.org/repo/',
  'http://nexus.scala-tools.org/content/repositories/snapshots/',
  'https://nexus.griddynamics.net/nexus/content/groups/public',
  'http://scala-tools.org/repo-snapshots',
  'http://repository.ops4j.org/maven2',
  'http://adterrasperaspera.com/lwjgl/',
  'http://archiva.openqa.org/repository/releases',
  'http://databinder.net/repo/',
  'http://maven.clapper.org/',
  'http://maven-gae-plugin.googlecode.com/svn/repository/',
  'http://maven.reucon.com/public/',
  'http://maven.twttr.com/',
  'http://mc-repo.googlecode.com/svn/maven2/releases',
  'http://mirrors.ibiblio.org/pub/mirrors/maven2/',
  'http://mvn.stax.net/content/repositories/public/',
  'http://nexus.scala-tools.org/content/repositories/releases',
  'http://nexus.scala-tools.org/content/repositories/releases/',
  'http://nexus.scala-tools.org/content/repositories/snapshots',
  'http://oauth.googlecode.com/svn/code/maven/',
  'http://oss.sonatype.org/content/repositories/github-releases/',
  'http://oss.sonatype.org/content/repositories/releases/',
  'http://people.apache.org/~mrdon/repository/',
  'http://people.apache.org/repo/m2-ibiblio-rsync-repository/',
  'http://powermock.googlecode.com/svn/repo/',
  'http://repo1.maven.org/maven2/',
  'http://repo1.maven.org/maven2/org/',
  'http://repo.fusesource.com/maven2',
  'http://repo.fusesource.com/maven2-snapshot',
  'http://repos.bryanjswift.com/maven2/',
  'http://repository.jboss.org/nexus/content/groups/public/',
  'http://repository.jboss.org/nexus/content/groups/public-jboss/',
  'http://repository.ops4j.org/mvn-snapshots',
  'http://scala-tools.org/repo-snapshots/',
  'https://m2proxy.atlassian.com/repository/public/',
  'https://oss.sonatype.org/content/groups/public/',
  'http://specs.googlecode.com/svn/maven2',
  'http://specs.googlecode.com/svn/maven2/',
  'http://tristanhunt.com:8081/content/groups/public/',
  'http://tristanhunt.com:8081/content/groups/public-snapshots/',
  'http://tristanhunt.com:8081/content/groups/releases_group/',
  'http://twdata-m2-repository.googlecode.com/svn/',
  'http://undercover.googlecode.com/svn/maven/repository/',
  'http://www2.ph.ed.ac.uk/maven2/',
  'http://www.scala-tools.org/repo-snapshots/',
  'http://bleu.west.spy.net/~dustin/m2repo/',
  'http://download.java.net/maven/glassfish',
  'http://snapshots.jboss.org/maven2',
  'http://snapshots.repository.codehaus.org',
  'http://www.dataforte.net/listing/maven/releases',
  'https://maven.atlassian.com/content/groups/public',
  'https://repository.jboss.org/nexus/content/groups/public',
  'https://repository.jboss.org/nexus/content/groups/public-jboss/',
  'http://snapshots.jboss.org/maven2/',
  'https://repository.jboss.org/nexus/content/groups/public/'
  ]

def verify_url(url)
  @white_list.each do |white|
    return true if white == url
  end
  false
end

Dir[base_dir + "**/*.*"].each do |file|
  begin

  next if File.directory?(file)
  next unless file[-4..-1] == ".pom"

  xml = nil
  open(file) { |f| xml = f.read }
  doc = REXML::Document.new xml

  repository_list = REXML::XPath.match(doc, "/project/repositories/repository")
  if repository_list != nil
    repository_list.each do |repository|
      url = REXML::XPath.first( repository, "./url")
      puts "#{file}  repository  #{url.text}" unless verify_url(url.text)
    end
  end

  plugin_repository_list = REXML::XPath.match(doc, "/project/pluginRepositories/pluginRepository")
  if plugin_repository_list != nil
    plugin_repository_list.each do |plugin_repository|
      url = REXML::XPath.first( plugin_repository, "./url")
      puts "#{file}  pluginRepository  #{url.text}" unless verify_url(url.text)
    end
  end

  rescue Exception => e
    puts "#{file}  Invalid POM"
  end
  
end
