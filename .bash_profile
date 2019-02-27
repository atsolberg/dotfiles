# Add bin and sbin to PATH
PATH=$PATH:/usr/local/bin:/usr/local/sbin

# More useful ls
alias ls='ls -ll'

# Show hidden files/folders
alias showhidden='defaults write -g AppleShowAllFiles -bool true'

# Tail today's log file - requires ssh key login to be setup, @see ssh.com/ssh/copy-id
alias tail-uat='echo "tail -f /usr/applications/ag-commerce-scc-uat/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@uatapp'
alias tail-uat2='echo "tail -f /usr/applications/ag-commerce-scc-uat-2/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@uatapp'
alias tail-dev='echo "tail -f /usr/applications/ag-commerce-scc-rsdev/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@devapp'
alias tail-prod1='echo "tail -f /usr/applications/ag-commerce-scc-prod/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@prodapp1'
alias tail-prod2='echo "tail -f /usr/applications/ag-commerce-scc-prod/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@prodapp2'
alias tail-prod3='echo "tail -f /usr/applications/ag-commerce-scc-prod/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@prodapp3'
alias tail-prod4='echo "tail -f /usr/applications/ag-commerce-scc-prod/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@prodapp4'
alias tail-prod5='echo "tail -f /usr/applications/ag-commerce-scc-prod/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@prodapp5'
alias tail-key='echo "tail -f /usr/applications/ag-commerce-scc-uat/log/tomcat/console-`/bin/date +\%Y\%m\%d`.log" | ssh asolberg@keyapp'

# Docker - add -d to run docker things in detached mode
alias dockbash='docker exec -it 2bc8a998f8c2 /bin/bash'

# Get the current backup of production db
alias getdb='scp asolberg@devapp:/usr/local/share/data/current.dmp.zip ~/Downloads'

# Oracle on docker - use create once, use start from then on.
alias dbcreate='docker run -d -p 8080:8080 -p 1521:1521 -v /Users/asolberg/Development/oracle_data/u01/app/oracle:/u01/app/oracle 12c | pbcopy && docker logs -f $(pbpaste)'
alias dbstart='docker start 2bc8a998f8c2 | pbcopy && docker logs -f $(pbpaste)'
alias dbstop='docker stop 2bc8a998f8c2'
alias dbstatus='echo "SELECT COUNT(*) FROM SCC_PROD_HYBRIS.PRD_PRODUCTS;" | $ORACLE_HOME/bin/sqlplus system/oracle@//localhost:1521/xe.oracle.docker'

# Hybris
alias go-hyb='cd ~/Development/hybris/bin/platform'
alias config-hyb='cp -f ~/.scripts/hybris-configs/local.properties ~/Development/hybris/config/'
alias start-hyb='go-hyb && config-hyb && . ./setantenv.sh && ant all && ./hybrisserver.sh -d'
alias all-hyb='go-hyb && config-hyb && . ./setantenv.sh && ant clean all && ./hybrisserver.sh -d'
alias test-hyb='go-hyb && source ./setantenv.sh; \
    ant yunitinit; \
    ant unittests -Dtestclasses.packages=com.sn.*; \
    ant unittests -Dtestclasses.packages=com.sn.* -Dtestclasses.web=true; \
    cd ../; java -cp `find "./" -name "lib" | xargs echo | tr " " ":"`:`find "./" -name "*classes" | xargs echo | tr " " ":"`:`find "./" -name "*.jar" | xargs echo | tr " " ":"` org.junit.runner.JUnitCore com.sn.testutils.SleepNumberTestSuite; cd platform;'
alias hybris-post-deploy='cd ${INSTALL_DIRECTORY}/hybris/bin/platform && . setantenv.sh && ant updatesystem && curl http://local.sleepnumber.com:9001/snws/api/sn/devops/executeScripts && curl http://local.sleepnumber.com:9001/snws/api/sn/devops/synchronizeCatalog?catalogId=snProductCatalog && curl http://local.sleepnumber.com:9001/snws/api/sn/devops/synchronizeCatalog?catalogId=snContentCatalog && ant executeCronJob -Dcronjob=snIndex-solr-full'

# Apache
alias apache='docker run --rm -it -p 80:80 -p 443:443 sn/apache:latest'

# Rabbit MQ
alias rbstart='rabbitmq-server -detached'
alias rbstop='rabbitmqctl stop'
alias rbstatus='rabbitmqctl status'

# Solr
alias solr='~/.scripts/solr-restart.sh'
alias solr-pid='lsof -ti :8983'
alias solr-stop='solrpid=$(solr-pid) && echo "killing solr process [$solrpid]" && kill -9 $solrpid'

# Start rabbit and solr
alias pre-hyb='rbstart && solr'

alias webroot='cd ~/Development/hybris/bin/custom/sn/snstorefront/web/webroot'
alias wp='webroot && npm run watch'

# node_modules
alias nodemods='webroot && rm -rf node_modules && npm install'

# Cypress
alias cy='open /Applications/Cypress.app'
alias cy-dev='open /Applications/Cypress.app --args --env configFile=dev'
alias cy-uat='open /Applications/Cypress.app --args --env configFile=test'
alias cy-uat2='open /Applications/Cypress.app --args --env configFile=test2'
alias cy-stage='open /Applications/Cypress.app --args --env configFile=stage'

export INSTALL_DIRECTORY="/Users/asolberg/Development"

# NVM - add to path and set node version to 10.1.0 
export NVM_DIR="/Users/asolberg/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

. ~/.nvm/nvm.sh
nvm use 10.1.0
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
