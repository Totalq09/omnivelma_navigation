Paczka zawierająca zmodyfikowany model bazy jezdej velmy nazwany "omnivelma".
Pierwotnym autorem jest Radosława Świątkiewicza - https://github.com/Antyradek/omnivelma

Względem pierwowzoru zmieniono:

1. Obrócono model o 90 stopni w osi z - tak by jego (umowna, ze względu na fakt dookólności) oś x pokrywała się z osią x układu wykorzystywanego 
    przez pakiet nawigacyjny ROSa.

2. Dodano rozgłaszanie odometrii przez model dynamiczny.

3. Usunięto parametry solvera ode ustawione przez autora - uniemożliwiały uruchomienie symulacji.

4. Dodano obsługe kinecta, wraz z jego prostym obracaniem poprzez rozgłaszanie kąta obrotu na odpowiednim temacie.

5. Dodano model człowieka.

6. Dodano narzędzie opisane jako human_mover - umożliwia poruszanie się człowiekiem w sumulacji patrząc z jego perspektywy.

7. Dodano model komputera, stolika, krzesła oraz wymodelowano pomieszczenie laboratoryjne (w sposób uproszczony)

