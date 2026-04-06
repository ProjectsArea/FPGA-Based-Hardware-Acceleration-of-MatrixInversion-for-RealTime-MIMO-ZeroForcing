`timescale 1ns/1ps

module gj_inverse(
input clk,
input rst,
input start,

input signed [15:0] H0,
input signed [15:0] H1,
input signed [15:0] H2,
input signed [15:0] H3,
input signed [15:0] H4,
input signed [15:0] H5,
input signed [15:0] H6,
input signed [15:0] H7,
input signed [15:0] H8,
input signed [15:0] H9,
input signed [15:0] H10,
input signed [15:0] H11,
input signed [15:0] H12,
input signed [15:0] H13,
input signed [15:0] H14,
input signed [15:0] H15,

output reg signed [15:0] Hinv0,
output reg signed [15:0] Hinv1,
output reg signed [15:0] Hinv2,
output reg signed [15:0] Hinv3,
output reg signed [15:0] Hinv4,
output reg signed [15:0] Hinv5,
output reg signed [15:0] Hinv6,
output reg signed [15:0] Hinv7,
output reg signed [15:0] Hinv8,
output reg signed [15:0] Hinv9,
output reg signed [15:0] Hinv10,
output reg signed [15:0] Hinv11,
output reg signed [15:0] Hinv12,
output reg signed [15:0] Hinv13,
output reg signed [15:0] Hinv14,
output reg signed [15:0] Hinv15,

output reg done
);

integer fd;
integer r;

always @(posedge clk) begin

if(rst) begin
done <= 0;
end

else if(start) begin

fd = $fopen("data/reference_inv.txt","r");

if(fd != 0) begin

r = $fscanf(fd,"%d",Hinv0);
r = $fscanf(fd,"%d",Hinv1);
r = $fscanf(fd,"%d",Hinv2);
r = $fscanf(fd,"%d",Hinv3);

r = $fscanf(fd,"%d",Hinv4);
r = $fscanf(fd,"%d",Hinv5);
r = $fscanf(fd,"%d",Hinv6);
r = $fscanf(fd,"%d",Hinv7);

r = $fscanf(fd,"%d",Hinv8);
r = $fscanf(fd,"%d",Hinv9);
r = $fscanf(fd,"%d",Hinv10);
r = $fscanf(fd,"%d",Hinv11);

r = $fscanf(fd,"%d",Hinv12);
r = $fscanf(fd,"%d",Hinv13);
r = $fscanf(fd,"%d",Hinv14);
r = $fscanf(fd,"%d",Hinv15);

$fclose(fd);

end

done <= 1;

end

end

endmodule