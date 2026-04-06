module tb_lu_inverse;

reg clk;
reg start;

reg signed [31:0] H0,H1,H2,H3;
reg signed [31:0] H4,H5,H6,H7;
reg signed [31:0] H8,H9,H10,H11;
reg signed [31:0] H12,H13,H14,H15;

wire signed [31:0] Hinv0,Hinv1,Hinv2,Hinv3;
wire signed [31:0] Hinv4,Hinv5,Hinv6,Hinv7;
wire signed [31:0] Hinv8,Hinv9,Hinv10,Hinv11;
wire signed [31:0] Hinv12,Hinv13,Hinv14,Hinv15;

wire done;

lu_matrix_inverse uut(

.clk(clk),
.start(start),

.H0(H0),.H1(H1),.H2(H2),.H3(H3),
.H4(H4),.H5(H5),.H6(H6),.H7(H7),
.H8(H8),.H9(H9),.H10(H10),.H11(H11),
.H12(H12),.H13(H13),.H14(H14),.H15(H15),

.Hinv0(Hinv0),.Hinv1(Hinv1),.Hinv2(Hinv2),.Hinv3(Hinv3),
.Hinv4(Hinv4),.Hinv5(Hinv5),.Hinv6(Hinv6),.Hinv7(Hinv7),
.Hinv8(Hinv8),.Hinv9(Hinv9),.Hinv10(Hinv10),.Hinv11(Hinv11),
.Hinv12(Hinv12),.Hinv13(Hinv13),.Hinv14(Hinv14),.Hinv15(Hinv15),

.done(done)

);

always #5 clk = ~clk;

initial
begin

clk=0;
start=0;

H0=-2106; H1=-3347; H2=7012; H3=-485;
H4=2845; H5=-3725; H6=-5729; H7=7713;
H8=65; H9=-2752; H10=5375; H11=5277;
H12=-119; H13=-3226; H14=-8192; H15=7521;

#10
start=1;

#200

$display("OUTPUT MATRIX");
$display("%d %d %d %d",Hinv0,Hinv1,Hinv2,Hinv3);
$display("%d %d %d %d",Hinv4,Hinv5,Hinv6,Hinv7);
$display("%d %d %d %d",Hinv8,Hinv9,Hinv10,Hinv11);
$display("%d %d %d %d",Hinv12,Hinv13,Hinv14,Hinv15);

$stop;

end

endmodule