function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = rand(rows(pts), rows(para.samples));
	
	% przy liczeniu g�sto�ci warto zastanowi� si�
	% nad kolejno�ci� oblicze� (p�tli)
	for i=1:rows(para.samples)
		h_n = para.parzenw / sqrt(rows(para.samples{i}));
		for j=1:rows(pts)
			npdf = zeros(rows(para.samples{i}), 1);
			for k=1:rows(para.samples{i})
				npdf(k, 1) = prod(normpdf(
					para.samples{i}(k, :),
					pts(j, :),
					h_n
				));
			end
			pdf(j, i) = mean(npdf);
		end
	end
end
