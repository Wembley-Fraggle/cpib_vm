
HOWTO-Build
-----------
Das Projekt wird mit Gradle 2.1 auf einer Console gebuildet.
Es wird davon ausgegangen, dass Gradle korrekt installiert wurde. 
Mit dem Kommando
  gradle jar 
wird das Jar-File der virtuellen Maschine erstellt. Sofern keine 
Fehler bestehen, befindet sich die virtuelle Maschine im 
Ordner build\libs\vm.jar.

HOWTO-Run
---------
Um die virtuelle Maschine auszuführen,kann das 
Batch-File vm.bat verwendet wreden. Das Batch-Script verwendet 
das File "Sample.iml" ein, welches von der VM eingelesen
und anschliessend ausgeführt wird.

HOWTO-Eclipse
-------------
Um das Projekt in Eclipse builden zu können, muss das Projekt
als Gradle Projekt importiert werden. So kann der VM-Parser, 
welche beim Build-Prozess generiert wird, automatisch erstellt
werden.

Durch den Build-Schritt werden zusätzliche Klassen generiert,
welche im Gradle-Ordner build\generated-sources\java zu finden
sind. Damit Eclipse die Abhänigkeiten auflösen kann, sollte
dieser Pfad als Source-Folder in den Build-Path aufgenommen
werden.