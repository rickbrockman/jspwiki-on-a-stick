JSPWiki On A Stick
========================================================================================================================

1) Introduction
------------------------------------------------------------------------------------------------------------------------
Wiki On A Stick (WOAS) moves a JSPWiki on an USB stick providing start scripts to run it on Windows, Linux and Mac OS X. This allows you to carry around your JSPWiki and use it on any computer you are working with.


2) How to build WOAS
------------------------------------------------------------------------------------------------------------------------

2.1) Check out JSPWiki 3.8.2 from Subversion

2.2) Copy the 'extensions' directory to the JSPWiki checkout folder

2.3) Add the following snippet to the 'build.xml'

     <target name="woas-clean" description="Cleanup the WikiOnAStick extension">
       <ant antfile="${basedir}/extensions/woas/build.xml" inheritAll="false" target="woas:clean"/>
     </target>
     <target name="woas-dist" depends="war" description="Builds the WikiOnAStick extension">
       <ant antfile="${basedir}/extensions/woas/build.xml" inheritAll="false" target="woas:dist"/>
     </target>    

2.4) Invoke 'ant woas-clean woas-dist'

2.5) The ready-to-run wiki is found under './extensions/woas/target/woas'


3) Common Problems 
------------------------------------------------------------------------------------------------------------------------

3.1) Application does not start under Mac OS X - make sure that 'woas.app/Contents/MacOS/WikiOnAStick is executable.

3.2) Application does not start under Unix - make sure that 'woas.sh' is executable
