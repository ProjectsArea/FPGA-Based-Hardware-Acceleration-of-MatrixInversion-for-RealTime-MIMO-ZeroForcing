algorithms = {'GaussJordan','LU','QR','NewtonSchulz'};

MSE = [1.23e-23 1.09e-29 3.74e-23 5.6e2];
BER = [0.034 0.034 0.034 0.012];

figure
bar(MSE)
set(gca,'YScale','log')
title('Matrix Inversion MSE Comparison')
xlabel('Algorithm')
ylabel('MSE')
set(gca,'XTickLabel',algorithms)

figure
bar(BER)
title('BER Comparison')
xlabel('Algorithm')
ylabel('Bit Error Rate')
set(gca,'XTickLabel',algorithms)
