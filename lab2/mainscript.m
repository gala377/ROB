% wreszcie mo�na zaj�� si� kartami!
% wcze�niejszy fragment mo�na spokojnie usun�� po uruchomieniu
% funkcji licz�cych pdf
[train test] = load_cardsuits_data();

% pierwszy rzut oka na dane
% size(train)
% size(test)
% labels = unique(train(:,1))
% unique(test(:,1))
% [labels'; sum(train(:,1) == labels')]

% pierwszym zadaniem po za�adowaniu danych jest sprawdzenie,
% czy w zbiorze ucz�cym nie ma pr�bek odstaj�cych
% do realizacji tego zadania przydadz� si� funkcje licz�ce
% proste statystyki: mean, median, std, 
% wy�wietlenie histogramu cech(y): hist
% spojrzenie na dwie cechy na raz: plot2features (dostarczona w pakiecie)

train(186, :) = [];
train(641, :) = [];

% [mean(train); median(train)]
% hist domy�lnie dzieli zakres warto�ci na 10 koszyk�w
% wy�wietlenie w ten spos�b 8 etykiet do�� dobrze ilustruje 
% dzia�anie hist
%  hist(train(:,4))

% to nie s� cechy, kt�re wykorzysta�bym do klasyfikacji - mo�na
% znale�� du�o lepsze; do sprawdzania, czy s� warto�ci odstaj�ce
% nawet te cechy wystarcz�
% plot2features(train, 3, 4)

% do identyfikacji odstaj�cych pr�bek doskonale nadaj� si� wersje
% funkcji min i max z dwoma argumentami wyj�ciowymi


% poniewa� warto�ci minimalne czy maksymalne da si� wyznaczy� zawsze,
% dobrze zweryfikowa� ich odstawanie spogl�daj�c przynajmniej na s�siad�w
% podejrzanej pr�bki w zbiorze ucz�cym

% % powiedzmy, �e podejrzana jest pr�bka 41
% midx = 41
% train(midx-1:midx+1, :)

% % je�li nabra�em przekonania, �e pr�bka midx jest do usuni�cia, to:
% size(train)
% train(midx, :) = []; % usuni�cie wiersza midx z macierzy
% size(train)

% % procedur� szukania i usuwania warto�ci odstaj�cych trzeba powtarza� do skutku

% % po usuni�ciu warto�ci odstaj�cych mo�na zaj�� si� wyborem DW�CH cech dla klasyfikacji
% % w tym przypadku w zupe�no�ci wystarczy poogl�da� wykresy dw�ch cech i wybra� te, kt�re
% % daj� w miar� dobrze odseparowane od siebie klasy

% % Po ustaleniu cech (dok�adniej: indeks�w kolumn, w kt�rych cechy siedz�):
first_idx = 3;
second_idx = 4;
train = train(:, [1 first_idx second_idx]);
test = test(:, [1 first_idx second_idx]);

% to nie jest najros�dniejszy wyb�r; 4 i 6 na pewno trzeba zmieni�

% tutaj jawnie tworz� struktur� z parametrami dla klasyfikatora Bayesa 
% (po prawdzie, to dla funkcji licz�cej g�sto�� prawdobie�stwa) z za�o�eniem,
% �e cechy s� niezale�ne

pdfindep_para = para_indep(train);
pdfmulti_para = para_multi(train);
pdfparzen_para = para_parzen(train, 0.001); 
% w sprawozdaniu trzeba podawa� szeroko�� okna (nie liczymy tego parametru z danych!)	

% % wyniki do punktu 3
% base_ercf = zeros(1,3);
% base_ercf(1) = mean(bayescls(test(:,2:end), @pdf_indep, pdfindep_para) != test(:,1));
% base_ercf(2) = mean(bayescls(test(:,2:end), @pdf_multi, pdfmulti_para) != test(:,1));
% base_ercf(3) = mean(bayescls(test(:,2:end), @pdf_parzen, pdfparzen_para) != test(:,1));
% base_ercf

% % W kolejnym punkcie przyda si� funkcja reduce, kt�ra redukuje liczb� pr�bek w poszczeg�lnych
% % klasach (w tym przypadku redukcja b�dzie taka sama we wszystkich klasach - ZBIORU UCZ�CEGO)
% % Poniewa� reduce ma losowa� pr�bki, to eksperyment nale�y powt�rzy� 5 (lub wi�cej) razy
% % W sprawozdaniu prosz� poda� tylko warto�� �redni� i odchylenie standardowe wsp��czynnika b��du
% % Wyobra�am sobie, �e w ka�dym powt�rzeniu eksperymentu tworz�
% % now� wersj� zbioru ucz�cego:
% %   reduced_train = reduce(train, parts(i) * ones(1, class_count))

% parts = [0.1 0.25 0.5];
% rep_cnt = 5; % przynajmniej

% % YOUR CODE GOES HERE 
% %



% % Punkt 5 dotyczy jedynie klasyfikatora z oknem Parzena (na pe�nym zbiorze ucz�cym)

% parzen_widths = [0.0001, 0.0005, 0.001, 0.005, 0.01];
% parzen_res = zeros(1, columns(parzen_widths));

% % YOUR CODE GOES HERE 
% %



% [parzen_widths; parzen_res]
% % Tu a� prosi si� do�o�y� do danych numerycznych wykres
% semilogx(parzen_widths, parzen_res)

% % W punkcie 6 redukcja dotyczy ZBIORU TESTOWEGO, natomiast warto
% % zadba� o to, �eby parametry dla funkcji pdf by�y policzone
% % na ca�ym zbiorze ucz�cym (po poprzednich eksperymentach tak 
% % raczej nie jest)
% % Poniewa� losujemy pr�bki, to wypada powt�rzy� eksperyment 
% % stosown� liczb� razy i u�redni� wyniki
% % reduced_test = reduce(test, parts) 

% apriori = [0.165 0.085 0.085 0.165 0.165 0.085 0.085 0.165];
% parts = [1.0 0.5 0.5 1.0 1.0 0.5 0.5 1.0];
% rep_cnt = 5; % powt�rka, �eby nie zapomnie�

% % YOUR CODE GOES HERE 
% %


% % W ostatnim punkcie trzeba zastanowi� si� nad normalizacj�
% std(train(:,2:end))
% % Mo�e warto sprawdzi�, jak to wygl�da w poszczeg�lnych klasach?

% % Normalizacja potrzebna?
% % Je�li TAK, to jej parametry s� liczone TYLKO na zbiorze ucz�cym
% % Procedura normalizacji jest aplikowana do zbioru ucz�cego i testowego
% % Poniewa� zbiory ucz�cy i testowy s� przyzwoitej wielko�ci 
% % klasyfikujecie Pa�stwo testowy za pomoc� ucz�cego (nie ma
% % potrzeby u�ycia leave-one-out)


% % YOUR CODE GOES HERE 
% %

