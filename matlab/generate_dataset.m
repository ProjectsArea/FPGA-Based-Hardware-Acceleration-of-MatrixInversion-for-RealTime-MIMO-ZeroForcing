clear
clc

%% PARAMETERS

num_samples = 1000;     % number of channel realizations
scale = 8192;           % fixed point scaling (Q13)

%% CREATE OUTPUT FOLDERS

if ~exist('data','dir')
    mkdir('data')
end

%% OPEN FILES

fid_channel = fopen('data/channel_data.txt','w');
fid_refinv  = fopen('data/reference_inv.txt','w');
fid_rx      = fopen('data/rx_signal.txt','w');
fid_tx      = fopen('data/tx_signal.txt','w');

%% LOOP FOR DATASET GENERATION

for n = 1:num_samples

    %% Generate Rayleigh Channel Matrix (4x4)

    H = randn(4,4);

    % Normalize channel to prevent overflow
    H = H / max(abs(H(:)));

    %% Compute Floating-Point Inverse (Reference)

    H_inv = inv(H);

    %% Generate QPSK Symbols

    X = sign(randn(4,1)) + 1j*sign(randn(4,1));

    %% Noise

    noise = 0.01*randn(4,1);

    %% Received Signal

    Y = H*real(X) + noise;

    %% Convert to Fixed Point

    H_fixed = round(H * scale);
    Hinv_fixed = round(H_inv * scale);

    Y_fixed = round(Y * scale);
    X_fixed = round(real(X) * scale);

    %% Write Channel Matrix (for RTL)

    for i = 1:4
        fprintf(fid_channel,'%d %d %d %d\n',...
            H_fixed(i,1),H_fixed(i,2),H_fixed(i,3),H_fixed(i,4));
    end

    %% Write Reference Inverse (for MATLAB verification)

    for i = 1:4
        fprintf(fid_refinv,'%d %d %d %d\n',...
            Hinv_fixed(i,1),Hinv_fixed(i,2),Hinv_fixed(i,3),Hinv_fixed(i,4));
    end

    %% Write Received Signal

    fprintf(fid_rx,'%d %d %d %d\n',Y_fixed);

    %% Write Transmitted Signal

    fprintf(fid_tx,'%d %d %d %d\n',X_fixed);

end

%% CLOSE FILES

fclose(fid_channel);
fclose(fid_refinv);
fclose(fid_rx);
fclose(fid_tx);

disp('Dataset generation complete')
