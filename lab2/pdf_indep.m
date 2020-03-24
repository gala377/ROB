function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = zeros(rows(pts), rows(para.mu));

	% wynik nie zgadza się z tym podanym w `mainscript.m`
	% ale nie wydaje mi się żeby był tutaj błąd
	clslen = rows(para.mu);
	ptslen = rows(pts);
	for i = 1:clslen
		pdf(:, i) = prod(normpdf(
				pts,
				repmat(para.mu(i, :), ptslen, 1), 
				repmat(para.sig(i, :), ptslen, 1)),
			2);
	end
end
