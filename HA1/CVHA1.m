%  Gruppennummer:m23
%  Gruppenmitglieder: Wang,Sen 

%% Hausaufgabe 1
%  Einlesen und Konvertieren von Bildern sowie Bestimmung von 
%  Merkmalen mittels Harris-Detektor. 

%  F?r die letztendliche Abgabe bitte die Kommentare in den folgenden Zeilen
%  enfernen und sicherstellen, dass alle optionalen Parameter ?ber den
%  entsprechenden Funktionsaufruf fun('var',value) modifiziert werden k?nnen.


%% Bild laden
Image = imread('szene.jpg');
Image = im2double(Image);
IGray = rgb_to_gray(Image);
imshow(IGray)

%% Harris-Merkmale berechnen
tic;
Merkmale = harris_detektor(IGray);
toc;
