X = [6,7,8,9,10];

Y = [2.5, 5.6, 7.2, 8.9, 10.4];

plot(X, Y, 'k-o','linewidth', 2, 'markersize', 4);

ylabel('ʱ��/s', 'fontweight', 'bold', 'fontsize', 12 );

xlabel('λ��/s', 'fontweight', 'bold', 'fontsize',12);

set(gca,'xtick',[64,  128, 256, 512, 1024]);

hold on

Z = [1.2, 2.3, 3.1, 4.5, 7.2];

plot(X, Z, 'k--o', 'linewidth', 2, 'markersize', 4);

legend ʵ������Y ʵ������Z

box off

legend('boxoff');

set(legend);

set(legend);
hold off

