`timescale 1ns/1ps

module tb_matrix_inverse;

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

/* DUT */

matrix_inverse_lu dut(

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


/* Clock */

always #5 clk = ~clk;


/* File handling */

integer file;
real r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15;


/* Simulation */

initial
begin

clk = 0;
start = 0;

/* open dataset */

file = $fopen("channel_data.txt","r");

if(file == 0)
begin
$display("ERROR: Cannot open channel_data.txt");
$finish;
end


/* Continuous simulation */

while(!$feof(file))
begin

$fscanf(file,"%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f",
r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15);

/* Convert to Q16.16 */

H0 = r0*65536;
H1 = r1*65536;
H2 = r2*65536;
H3 = r3*65536;

H4 = r4*65536;
H5 = r5*65536;
H6 = r6*65536;
H7 = r7*65536;

H8 = r8*65536;
H9 = r9*65536;
H10 = r10*65536;
H11 = r11*65536;

H12 = r12*65536;
H13 = r13*65536;
H14 = r14*65536;
H15 = r15*65536;


/* Start inversion */

#10 start = 1;
#10 start = 0;

#20;


/* Print results */

$display("--------------------------------------------------");
$display("INPUT MATRIX");

$display("%f %f %f %f",r0,r1,r2,r3);
$display("%f %f %f %f",r4,r5,r6,r7);
$display("%f %f %f %f",r8,r9,r10,r11);
$display("%f %f %f %f",r12,r13,r14,r15);

$display("INVERSE MATRIX");

$display("%f %f %f %f",Hinv0/65536.0,Hinv1/65536.0,Hinv2/65536.0,Hinv3/65536.0);
$display("%f %f %f %f",Hinv4/65536.0,Hinv5/65536.0,Hinv6/65536.0,Hinv7/65536.0);
$display("%f %f %f %f",Hinv8/65536.0,Hinv9/65536.0,Hinv10/65536.0,Hinv11/65536.0);
$display("%f %f %f %f",Hinv12/65536.0,Hinv13/65536.0,Hinv14/65536.0,Hinv15/65536.0);

end

$fclose(file);

$display("All matrices processed.");

$finish;

end

endmodule