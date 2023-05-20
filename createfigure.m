function [figure1, ax1, ax2] = createfigure()

figure1 = figure('WindowState','maximized');

% Create axes
ax1 = axes('Parent',figure1,...
    'Position',[0.037 0.079 0.45 0.89]);

% Create axes
ax2 = axes('Parent',figure1,...
    'Position',[0.54 0.082 0.45 0.89]);

return;

