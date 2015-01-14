@echo off
SETLOCAL EnableDelayedExpansion  
SETLOCAL EnableExtensions

SET JAVA_CLASSPATH=
SET JAVA_CLASSPATH=%JAVA_CLASSPATH%.\build\libs\*
SET FILE=Sample.iml


SET EXECUTE=java  -Dfile=%FILE%  -cp %JAVA_CLASSPATH% ch.fhnw.lederer.virtualmachine.TestVM
echo %EXECUTE%
%EXECUTE%