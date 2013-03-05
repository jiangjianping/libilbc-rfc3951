REM here are the file names and urls for the technical specification
SET technical_spec=rfc3951.txt
SET technical_spec_url=http://www.ietf.org/rfc/%technical_spec%

REM for the extract script
SET extract_script=extract-cfile.awk
SET extract_script_url=http://www.webrtc.org/ilbc-freeware/ilbc-source-code-and-utili/ilbc-utilities/%extract_script%

REM define the directories and files variables
SET curdir=%CD%
SET srcdir=..\..\..\..\src
SET checksum_dir=%srcdir%\known_checksums

REM define the tools
SET wget=wget.exe
SET awk=awk.exe

REM clean previous files if they exist
DEL /f %srcdir%\*.c
DEL /f %srcdir%\*.h

REM get the sources
IF NOT EXIST %extract_script% (
	%wget% %extract_script_url% -O %extract_script% --no-check-certificate
)
IF NOT EXIST %technical_spec% (
	%wget% %technical_spec_url% -O %technical_spec% --no-check-certificate
)
CD %srcdir%
%awk% -f %curdir%\%extract_script% %curdir%\%technical_spec%
