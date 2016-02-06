# Docker Mailcow

A Mailserver based on the Mailcow-Script running in a Docker-Container

Contact: Peter Knuewer (peter@c3re.de)

Geschichte:

Ich wurde gebeten, einen Mail-Server für den Chaostreff Reckliinghausen (c3RE) des Chaos Computer Clubs (CCC) aufzusetzen und zu betreiben. Da alle Infrastruktur-Services des c3RE in Docker-Containern laufen, sollte auch der Mailserver in einem Docker Container laufen. Ich wollte mir das Leben leicht machen und möglichst auf vorhandene Scripts/Script-Sammlungen zurueckgreifen. 

Nach kurzer Sichtung des Angebotes habe ich mich für die Script-Sammlung "Mailcow" entschieden.
=> https://github.com/andryyy/mailcow

Leider läuft die Mailcow nicht ohne weiteres in Docker-Containern. Die folgenden Problemfelder habe ich herausgefunden und angepasst:

1.) Web-Server

Mailcow kann sowohl mit Apache2 als auch mit Nginx als Web-Server betrieben werden. In meinem Docker-Container habe ich aber Nginx noch nicht zum laufen gebracht. Apache2 läuft ohne Probleme. Aus diesem Grund ist der Eintrag "httpd_platform="nginx" in Zeiler 30 der Datei "mailcow.config" zu ändern in "httpd_platform="apache2".

2.) MySQL-Server

Mailcow installiert und nutzt standardmässig einen eigenen MySQL-Server. Während auf diesen zu Beginn des Installationsscripts noch zugegriffen werden kann, verliert das Script während der Installation den Zugriff und bricht ab bzw. endet erfolgos. Zur Lösung muss der MySQL-Server während der Installation an der richtigen Stelle einmal neu gestartet werden. Dazu ist in der Datei includes/functions.sh eine neue Zeile 244 einzufügen:

243 if [[ $mysql_useable -ne 1 ]]; then
244				service mysql restar
245 			mysql --defaults-file=/etc/mysql/debian.cnf -e "UPDATE mysql.user SET Password=PASSWORD('$my_rootpw') WHERE USER='root'; FLUSH PRIVILEGES;"
246 fi

3.) Fuglu-Proxy

Nach der Installation kann der Mail-Server interne/externe eMails weder versenden noch empfangen. Ursächlich ist, dass alle Dienste in den Zeilen 547-552 includes/functions.sh neu gestartet werden. Der Fuglu-Proxy mit den Befehlen "service fuglu stop" und "service fuglu start". Diese Befehle funktionieren nicht. Richtig wäre der Start des Dienstes mit dem Befehl "fuglu".

Ich habe die oben genannten Fehler behoben und ein bischen Installations-Foo drum herum geschrieben, dass eine vollständig automatisierte INstallation in einem Docker-Container erlaubt. Voraussetzung ist ein funktionsfähiger Docker-Host.

Installation:

Mein Installationsverzeichnis ist /root/mailcow/
Pullen vom Docker-Hub sowie Erstellen und Starten des Docker-Containers mit ./start.sh
Wenn das geklappt hat seht ihr die Konsole des neuen Mail-Servers.
Dort in das Basisverzeichnis wechseln ("cd /root/mailcow-0.13.1") und die Installation mit "./install_mailcow.sh" starten. Nach der Abarbeitung der o.g. Fixe startet das originale Mailcow-Installationsscript. Nach Abschluß der Installation noch "./dienste_starten.sh" ausführen und die Installation sollte erfolgreich abgeschlossen sein.

Über Rückmeldungen und Verbesserungsvorschläge würde ich mich sehr freuen.

Peter
