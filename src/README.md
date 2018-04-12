Navigation Stack przystosowany do bazy jezdnej robota Velma.
Paczka zawiera symulator omnivelma przygotowany w środowisku Gazebo: https://github.com/Antyradek/omnivelma.
W stosunku do pierwotnej wersji, baza została obrócona tak, by oś "przód-tył" robota była zgodna z osią x (pierwotnie y). 
Dodano również symualacje kinecta

Instalacja:

UWAGA:

Kompilacja paczki nie należy do łatwych!
Powodem jest fakt, iż część modułów w paczce people korzysta z OpenCV 2, a cześć z OpenCV 3. 
ROS posiada wbudowany OpenCV 3, lecz po zainstalowaniu OpenCV 2 nie byłem w stanie zmusić kompilatora i linkera do
poprawnego działania z OpenCV 3.

W związku z tym paczka zawiera opencv2_catkin oraz opencv3_catkin, będące jedynie nakładkami na standardowe opencv.

Kolejnym problem jest fakt, że catkin_make niepoprawnie rozpatruje kolejność kompilacji i nie generuje niezbędnych innym modułom 
nagłówków wiadomości (ROS MSG).

W celu poprawnej kompilacji należy wymusić należytą kolejność kompilacji poprzez wyłączenie odpowiednich pakietów z kompilacji poprzez
zmiane nazwy package.xml na package.xmlNOBUILD.

Kompilacja (w planach jest powstanie skryptu automatyzującego powyższe czynności):

0. Pomódl się

1. Stwórz folder ~/catkin_ws i pobierz zawartość repo do katalogu ~/catkin_ws/src

2. cd ~/catkin_ws/src

3. chmod +x install_omnivelma_with_dependencies.sh

4. ./install_omnivelma_with_dependencies.sh

5. cd ~/catkin_ws

6. source /opt/ros/kinetic/setup.bash

7. cd ~/catkin_ws/src/omnivelma

8. Usuń foldery build oraz devel jeżeli istnieją oraz wywołaj ./init

9. Wyłącz z kompilacji następujące paczki: people/face_detector, people/leg_detector, people/people_tracking_filter, people/people_velocity_tracker, omnivelma_navigation, opencv3_catkin (pozostaw opencv2_catkin)

10. catkin_make w ~/catkin_ws

11. Włącz do kompilacji omnivelma_navigation oraz people/people_tracking_filter, wyłącz z kompilacji people/leg_detector

12. catkin_make w ~/catkin_ws

13. Włącz do kompilacji people/people_velocity_tracker

14. catkin_make w ~/catkin_ws

15. Włącz do kompilacji people/leg_detector

16. catkin_make w ~/catkin_ws 

17. Włącz do kompilacji people/face_detector oraz opencv3_catkin, wyłącz z kompilacji opencv2_catkin

18. catkin_make w ~/catkin_ws 

Przy sporej dozie szczęścia kompilacja powinna zakończyć się sukcesem.
Niestety pomimo faktu użycia specjalnych paczek opencvX_catkin, ponowna kompilacja people/leg_detector i people/face_detector prawdopodobnie nie jest możliwa.

Przyczyna jest mi nieznana.

UWAGA: model człowieka, użyty w gazebo posiada na stałe zapisane ścieżki do tekstur (być może ulegnie to zmianie w przyszłości).
Należy podać odpowiednie ścieżki w pliku .cae modelu

W przypadku problemów z kompilacją warto sprawdzić prawa dostępu - ostatecznie chmod -R 777 ~/catkin_ws
