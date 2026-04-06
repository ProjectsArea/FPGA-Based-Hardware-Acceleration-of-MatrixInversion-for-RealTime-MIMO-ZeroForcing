module zero_forcing_equalizer(

input clk,
input start,

// Inverse channel matrix
input signed [31:0] Hinv0,Hinv1,Hinv2,Hinv3,
input signed [31:0] Hinv4,Hinv5,Hinv6,Hinv7,
input signed [31:0] Hinv8,Hinv9,Hinv10,Hinv11,
input signed [31:0] Hinv12,Hinv13,Hinv14,Hinv15,

// Received vector
input signed [31:0] y0,y1,y2,y3,

// Output estimated transmitted vector
output reg signed [31:0] x0,x1,x2,x3,

output reg done
);

reg [2:0] state;

parameter IDLE = 0;
parameter COMPUTE = 1;
parameter FINISH = 2;


initial begin
state = IDLE;
done = 0;
end


always @(posedge clk)
begin

case(state)

IDLE:
begin
done <= 0;

if(start)
state <= COMPUTE;

end


COMPUTE:
begin

// Matrix-vector multiplication
x0 <= (Hinv0*y0 + Hinv1*y1 + Hinv2*y2 + Hinv3*y3)/1000;
x1 <= (Hinv4*y0 + Hinv5*y1 + Hinv6*y2 + Hinv7*y3)/1000;
x2 <= (Hinv8*y0 + Hinv9*y1 + Hinv10*y2 + Hinv11*y3)/1000;
x3 <= (Hinv12*y0 + Hinv13*y1 + Hinv14*y2 + Hinv15*y3)/1000;

state <= FINISH;

end


FINISH:
begin

done <= 1;
state <= IDLE;

end

endcase

end

endmodule