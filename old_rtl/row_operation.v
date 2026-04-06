module row_operation(

input signed [31:0] a0,a1,a2,a3,
input signed [31:0] b0,b1,b2,b3,

input signed [31:0] factor,

output signed [31:0] r0,r1,r2,r3

);

assign r0 = b0 - (factor * a0) / 1000;
assign r1 = b1 - (factor * a1) / 1000;
assign r2 = b2 - (factor * a2) / 1000;
assign r3 = b3 - (factor * a3) / 1000;

endmodule