function edges = reindex_edges(edges, v)

for i=1:length(edges)
    for j=1:v-1
        cumulative_sum = (j*(j+1))/2;
        if edges(i) <= j * v - cumulative_sum
            edges(i) = edges(i) + cumulative_sum;
            break;
        end
    end
end

return
