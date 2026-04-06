module lu_matrix_inverse(

input clk,
input start,

input signed [31:0] H0,H1,H2,H3,
input signed [31:0] H4,H5,H6,H7,
input signed [31:0] H8,H9,H10,H11,
input signed [31:0] H12,H13,H14,H15,

output reg signed [31:0] Hinv0,Hinv1,Hinv2,Hinv3,
output reg signed [31:0] Hinv4,Hinv5,Hinv6,Hinv7,
output reg signed [31:0] Hinv8,Hinv9,Hinv10,Hinv11,
output reg signed [31:0] Hinv12,Hinv13,Hinv14,Hinv15,

output reg done
);

always @(posedge clk)
begin

if(start)
begin

/* Placeholder computation */

Hinv0 = H0;
Hinv1 = H1;
Hinv2 = H2;
Hinv3 = H3;

Hinv4 = H4;
Hinv5 = H5;
Hinv6 = H6;
Hinv7 = H7;

Hinv8 = H8;
Hinv9 = H9;
Hinv10 = H10;
Hinv11 = H11;

Hinv12 = H12;
Hinv13 = H13;
Hinv14 = H14;
Hinv15 = H15;

done = 1;

end

end

endmodule