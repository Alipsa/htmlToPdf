#!/usr/bin/env bash

if command -v java ; then
	javaVersion=$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)
	if [[ (( $javaVersion -ge 17 )) ]]; then
	  echo "Java $javaVersion OK"
	else
	  echo "Java version 17 or greater required, trying to switch with sdkman"
	  if [[ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
	    source "$HOME/.sdkman/bin/sdkman-init.sh"
      jdk=$(sdk list java | grep installed | grep -E '17.' | head -n 1 | cut -d '|' -f 6 | sed 's/^ *//g')
      jdk=$(echo "$jdk" | xargs)
      sdk use java "${jdk}"
      javaVersion=$(java -version 2>&1 | head -1 | cut -d'"' -f2 | sed '/^1\./s///' | cut -d'.' -f1)
      if [[ (( $javaVersion -ge 17 )) ]]; then
      	  echo "Java $javaVersion OK"
      else
        echo "Failed to switch to java 17"
	      exit 1
	    fi
	  fi
	fi
else
  echo "Java not found in path"
  read -r
  exit 1
fi

DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$DIR" || exit

java -jar ./journo-viewer-0.6.0-SNAPSHOT.jar

