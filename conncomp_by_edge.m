function [mean_comp, st_deviation] = conncomp_by_edge(v, e, n)
%adott sz�m� v�letlenszer�en elhelyezett �l eset�n az �sszef�gg� komponensek
%sz�m�nak eloszl�sa

% v: cs�csok sz�ma a gr�fban
% e: berajzoland� �lek sz�ma (maximum (v*(v-1))/2)
% n: eloszl�s meghat�roz�s�hoz a futtatand� iter�ci�k sz�ma

if v<=0 || e<=0 || n<=0
    error('A param�terek nem lehetnek negat�vak!');
end

comp_nr = zeros(1, n);

if e > (v*(v-1))/2
    e = (v*(v-1))/2;
end

histogram([]);
screen_size = get(groot, 'ScreenSize');
width = screen_size(3)/2;
height = screen_size(4);
set(gcf, 'Position', [width/2, 0, width, height*0.7]);


for k=1:n
    edges = randperm((v*(v-1))/2, e);
    edges = reindex_edges(edges, v);
    
    adj = zeros(v);
    adj(edges) = 1;
    adj(reindexed_symmetry(edges, v)) = 1;
    thegraph = graph(adj);
    
    comp_nr(k) = max(conncomp(thegraph)); 
    histogram(comp_nr(1:k), round(length(unique(comp_nr))*3/2));
    pause(1/(n*k)^2);
end
close

[mean_comp, st_deviation, max_freq] = norm_params(comp_nr);

hist_bins = round(length(unique(comp_nr))*3/2);

if st_deviation <= 0
    histogram(transpose(comp_nr), hist_bins);
else
    [~, ax1, ax2] = createfigure();
    histogram(ax1, transpose(comp_nr), hist_bins);
    
    xlabel(ax1, '�sszef�gg� komponensek sz�ma');
    ylabel(ax1, 'Relat�v gyakoris�g');
    hold(ax1, 'on');
    
    norm_min = mean_comp - (4 * st_deviation);
    norm_max = mean_comp + (4 * st_deviation);
    step = (norm_max - norm_min)/999;
    interval = norm_min : step : norm_max;
    norm = normpdf(interval, mean_comp, st_deviation);

   
    plot(ax1, interval, norm*max_freq/max(norm), 'r-', 'LineWidth', 2);
    
    plot(ax2, interval, norm, 'LineWidth', 2);
    title(ax2, 'S�r�s�gf�ggv�ny');
    hold off;
end

return;

