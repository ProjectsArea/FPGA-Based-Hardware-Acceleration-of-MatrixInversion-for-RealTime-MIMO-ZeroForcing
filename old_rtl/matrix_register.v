module matrix_register(

input clk,
input load,

input signed [31:0] d0,d1,d2,d3,
input signed [31:0] d4,d5,d6,d7,
input signed [31:0] d8,d9,d10,d11,
input signed [31:0] d12,d13,d14,d15,

output reg signed [31:0] q0,q1,q2,q3,
output reg signed [31:0] q4,q5,q6,q7,
output reg signed [31:0] q8,q9,q10,q11,
output reg signed [31:0] q12,q13,q14,q15

);

always @(posedge clk)
begin
    if(load)
    begin
        q0 <= d0; q1 <= d1; q2 <= d2; q3 <= d3;
        q4 <= d4; q5 <= d5; q6 <= d6; q7 <= d7;
        q8 <= d8; q9 <= d9; q10 <= d10; q11 <= d11;
        q12 <= d12; q13 <= d13; q14 <= d14; q15 <= d15;
    end
end

endmodule