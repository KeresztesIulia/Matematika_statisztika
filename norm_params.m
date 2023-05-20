function [mean_samp,standard_deviation, max_freq] = norm_params(samples)

n = length(samples);
mean_samp = mean(samples);
standard_deviation = 0;

for i=1:n
    standard_deviation = standard_deviation + (samples(i) - mean_samp)^2;
end
standard_deviation = sqrt(standard_deviation / (n-1));

samples_unique = unique(samples);
max_freq = 0;
for i = 1:length(samples_unique)
    freq = length(find(samples == samples_unique(i)));
    if freq > max_freq
        max_freq = freq;
    end
end

end

