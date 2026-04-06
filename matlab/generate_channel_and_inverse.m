clear;
clc;

num_matrices = 100;
N = 4;

fid = fopen('../data/channel_data.txt','w');
fid2 = fopen('../data/reference_inv.txt','w');

for k = 1:num_matrices

    H = randi([-8192 8192],N,N);

    Hinv = inv(H);

    fprintf(fid,'%d %d %d %d\n',H(1,:));
    fprintf(fid,'%d %d %d %d\n',H(2,:));
    fprintf(fid,'%d %d %d %d\n',H(3,:));
    fprintf(fid,'%d %d %d %d\n',H(4,:));

    fprintf(fid2,'%f %f %f %f\n',Hinv(1,:));
    fprintf(fid2,'%f %f %f %f\n',Hinv(2,:));
    fprintf(fid2,'%f %f %f %f\n',Hinv(3,:));
    fprintf(fid2,'%f %f %f %f\n',Hinv(4,:));

end

fclose(fid);
fclose(fid2);

disp("Channel matrices and inverses generated successfully");
