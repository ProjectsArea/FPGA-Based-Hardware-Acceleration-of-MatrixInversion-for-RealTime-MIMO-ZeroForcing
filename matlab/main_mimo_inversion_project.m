clear;
clc;

%% PARAMETERS
num_samples = 1000;
N = 4;

mse_gj = zeros(num_samples,1);
mse_lu = zeros(num_samples,1);
mse_qr = zeros(num_samples,1);
mse_ns = zeros(num_samples,1);

%% DATA STORAGE
channel_data = zeros(num_samples,N,N);
ref_inv = zeros(num_samples,N,N);

%% SYMBOL GENERATION
num_symbols = 1000;
X = randi([0 1],N,num_symbols)*2-1; % BPSK symbols

snr_db = 20;

ber_gj = 0;
ber_lu = 0;
ber_qr = 0;
ber_ns = 0;

%% LOOP OVER CHANNEL MATRICES
for k = 1:num_samples

    H = randn(N);   % Rayleigh channel

    channel_data(k,:,:) = H;

    %% REFERENCE INVERSE
    H_ref = inv(H);
    ref_inv(k,:,:) = H_ref;

    %% ALGORITHM 1 : GAUSS JORDAN
    H_gj = gauss_jordan_inverse(H);

    %% ALGORITHM 2 : LU
    H_lu = lu_inverse(H);

    %% ALGORITHM 3 : QR
    H_qr = qr_inverse(H);

    %% ALGORITHM 4 : NEWTON SCHULZ
    H_ns = newton_schulz_inverse(H);

    %% MSE CALCULATION
    mse_gj(k) = mean((H_gj(:)-H_ref(:)).^2);
    mse_lu(k) = mean((H_lu(:)-H_ref(:)).^2);
    mse_qr(k) = mean((H_qr(:)-H_ref(:)).^2);
    mse_ns(k) = mean((H_ns(:)-H_ref(:)).^2);

    %% TRANSMISSION MODEL
    noise = randn(N,num_symbols)/sqrt(10^(snr_db/10));

    Y = H*X + noise;

    %% EQUALIZATION
    Xhat_gj = H_gj*Y;
    Xhat_lu = H_lu*Y;
    Xhat_qr = H_qr*Y;
    Xhat_ns = H_ns*Y;

    %% DETECTION
    Xg = sign(Xhat_gj);
    Xl = sign(Xhat_lu);
    Xq = sign(Xhat_qr);
    Xn = sign(Xhat_ns);

    %% BER
    ber_gj = ber_gj + sum(Xg(:)~=X(:));
    ber_lu = ber_lu + sum(Xl(:)~=X(:));
    ber_qr = ber_qr + sum(Xq(:)~=X(:));
    ber_ns = ber_ns + sum(Xn(:)~=X(:));

end

%% FINAL BER
ber_gj = ber_gj/(num_samples*num_symbols*N);
ber_lu = ber_lu/(num_samples*num_symbols*N);
ber_qr = ber_qr/(num_samples*num_symbols*N);
ber_ns = ber_ns/(num_samples*num_symbols*N);

%% PRINT RESULTS

fprintf("Average MSE Results\n");
fprintf("Gauss Jordan : %e\n",mean(mse_gj));
fprintf("LU           : %e\n",mean(mse_lu));
fprintf("QR           : %e\n",mean(mse_qr));
fprintf("Newton Schulz: %e\n",mean(mse_ns));

fprintf("\nBER Results\n");
fprintf("Gauss Jordan : %f\n",ber_gj);
fprintf("LU           : %f\n",ber_lu);
fprintf("QR           : %f\n",ber_qr);
fprintf("Newton Schulz: %f\n",ber_ns);

%% PLOT MSE

figure;
bar([mean(mse_gj) mean(mse_lu) mean(mse_qr) mean(mse_ns)])
set(gca,'xticklabel',{'GJ','LU','QR','NS'})
title('MSE Comparison')

%% SAVE DATA

save('channel_data.mat','channel_data')
save('reference_inv.mat','ref_inv')
