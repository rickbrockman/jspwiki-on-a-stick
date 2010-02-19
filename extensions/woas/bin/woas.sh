#!/bin/sh
# ----------------------------------------------------------------------------
#  Licensed to the Apache Software Foundation (ASF) under one or more
#  contributor license agreements.  See the NOTICE file distributed with
#  this work for additional information regarding copyright ownership.
#  The ASF licenses this file to You under the Apache License, Version 2.0
#  (the "License"); you may not use this file except in compliance with
#  the License.  You may obtain a copy of the License at
#  
#       http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

#   Copyright (c) 2001-2002 The Apache Software Foundation.  All rights
#   reserved.

# OS specific support.  $var _must_ be set to either true or false.
cygwin=false;
darwin=false;
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true 
           if [ -z "$JAVA_VERSION" ] ; then
             JAVA_VERSION="CurrentJDK"
           else
             echo "Using Java version: $JAVA_VERSION"
           fi
           if [ -z "$JAVA_HOME" ] ; then
             JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/${JAVA_VERSION}/Home
           fi
           ;;
esac

# Otherwise try to determine it from our invocation path
if [ -z "$WOAS_HOME" ] ; then
  ## resolve links - $0 may be a link to woas's home
  saveddir=`pwd`

  # need this for relative symlinks
  PRG="$0"    
  while [ -h "$PRG" ]; do
      ls=`ls -ld "$PRG"`
      link=`expr "$ls" : '.*-> \(.*\)$'`
      if expr "$link" : '/.*' > /dev/null; then
          PRG="$link"
      else
          PRG="`dirname $PRG`/$link"
      fi
  done
    
  # Make it fully specified
  cd "`dirname \"$PRG\"`"
  WOAS_HOME="`pwd -P`"

  cd "$saveddir"
fi

# For Cygwin, ensure paths are in UNIX format before anything is touched
if $cygwin ; then
  [ -n "$WOAS_HOME" ] &&
    WOAS_HOME=`cygpath --unix "$WOAS_HOME"`
  [ -n "$JAVA_HOME" ] &&
    JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
fi

if [ -z "$JAVACMD" ] ; then
  if [ -n "$JAVA_HOME"  ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
      # IBM's JDK on AIX uses strange locations for the executables
      JAVACMD="$JAVA_HOME/jre/sh/java"
    else
      JAVACMD="$JAVA_HOME/bin/java"
    fi
  else
    JAVACMD=java
  fi
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin; then
  [ -n "$WOAS_HOME" ] &&
    WOAS_HOME=`cygpath --path --windows "$WOAS_HOME"`
  [ -n "$JAVA_HOME" ] &&
    JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
  [ -n "$HOME" ] &&
    HOME=`cygpath --path --windows "$HOME"`
fi

case "$1" in
'')
  "$JAVACMD" -DSTOP.PORT=9628 -DSTOP.KEY=woas -jar "$WOAS_HOME"/start.jar
;;
'start')
  "$JAVACMD" -DSTOP.PORT=9628 -DSTOP.KEY=woas -jar "$WOAS_HOME"/start.jar
;;
'stop')
  "$JAVACMD" -DSTOP.PORT=9628 -DSTOP.KEY=woas -jar "$WOAS_HOME"/start.jar --stop
;;
'restart')
  echo "Usage: $0 [start|stop]"
;;
esac
