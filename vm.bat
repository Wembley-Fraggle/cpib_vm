@echo off
SETLOCAL EnableDelayedExpansion  
SETLOCAL EnableExtensions

SET JAVA_CLASSPATH=
SET JAVA_CLASSPATH=%JAVA_CLASSPATH%./build/libs/vm.jar;
SET JAVA_CLASSPATH=%JAVA_CLASSPATH%lib\antlr4-runtime-4.3.jar;
SET JAVA_CLASSPATH=%JAVA_CLASSPATH%lib\antlr4-annotations-4.3.jar
SET JAVA_CLASSPATH=%JAVA_CLASSPATH%lib\org.abego.treelayout.core-1.0.1.jar
SET FILE=Sample.iml


SET EXECUTE=java -Dfile=%FILE% -cp %JAVA_CLASSPATH% ch.fhnw.lederer.virtualmachine.TestVM 
%EXECUTE%