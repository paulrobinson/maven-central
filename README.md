To run the checks against org.jboss.jbossts:

Edit the jbossts.version in pom.xml

Run the following to populate the repository in ./repository

	mvn dependency:go-offline --settings ./conf/settings.xml

run the following command to validate the repository

	./bin/run-checks.sh
