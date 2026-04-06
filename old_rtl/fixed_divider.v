module fixed_divider(

input signed [31:0] numerator,
input signed [31:0] denominator,

output signed [31:0] result

);

assign result = (numerator * 1000) / denominator;

endmodule