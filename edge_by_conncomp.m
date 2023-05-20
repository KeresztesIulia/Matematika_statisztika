function [mean_edges, st_deviation] = edge_by_conncomp(v, k, n)
% annak eloszl�sa, hogy mennyi �lre van sz�ks�g adott sz�m� �sszef�gg�
% komponens kialak�t�s�ra (v�letlenszer�en elhelyezett �lek)

% v: cs�csok sz�ma
% k: el�rend� �sszef�gg� komponensek sz�ma
% n: eloszl�s meghat�roz�s�hoz a futtatand� iter�ci�k sz�ma

if k > v
    error('T�bb komponenst szeretn�nk el�rni, mint amennyit lehets�ges!');
end

if v<=0 || k<=0 || n<=0
    error('A param�terek nem lehetnek negat�vak!');
end

histogram([]);
screen_size = get(groot, 'ScreenSize');
width = screen_size(3)/2;
height = screen_size(4);
set(gcf, 'Position', [width/2, 0, width, height*0.7]);

edge_nr = zeros(1,n);
all_edges = 1 : v*(v-1)/2;
for t=1:n
    edges = v - k;
    available_edges = all_edges;
    current_edge_ind = randperm(v*(v-1)/2, edges);
    current_edges = reindex_edges(available_edges(current_edge_ind), v);
    available_edges(current_edge_ind) = [];
    
    adj = zeros(v);
    adj(current_edges) = 1;
    adj(reindexed_symmetry(current_edges, v)) = 1;
    thegraph = graph(adj);
    
    comps = max(conncomp(thegraph));

    while comps ~= k
        amount = comps - k;
        edges = edges + amount;
        current_edge_ind = randperm(length(available_edges), amount);
        current_edges = reindex_edges(available_edges(current_edge_ind), v);
        available_edges(current_edge_ind) = [];
        
        adj(current_edges) = 1;
        adj(reindexed_symmetry(current_edges, v)) = 1;
        thegraph = graph(adj);
        comps = max(conncomp(thegraph));
    end
    edge_nr(t) = edges;
    histogram(edge_nr(1:t), round(length(unique(edge_nr))*3/2));
    pause(1/(n*t)^2);
end
close;

[mean_edges, st_deviation, max_freq] = norm_params(edge_nr);

hist_bins = round(length(unique(edge_nr))*5/2);

if st_deviation <= 0
    histogram(transpose(edge_nr), hist_bins);
else
    [~, ax1, ax2] = createfigure();
    histogram(ax1, transpose(edge_nr), hist_bins);
    hold(ax1, 'on');
    
    norm_min = mean_edges - (5 * st_deviation);
    norm_max = mean_edges + (5 * st_deviation);
    step = (norm_max - norm_min)/1000;
    interval = norm_min : step : norm_max;
    norm = normpdf(interval, mean_edges, st_deviation);

    plot(ax1, interval, norm*max_freq/max(norm), 'r-', 'LineWidth', 2);
    
    plot(ax2, interval, norm, 'LineWidth', 2);
    hold off;
end

return;

