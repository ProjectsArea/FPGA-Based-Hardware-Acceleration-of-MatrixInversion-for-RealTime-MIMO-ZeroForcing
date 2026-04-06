module matrix_inverse_lu(

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

real A[0:3][0:3];
real L[0:3][0:3];
real U[0:3][0:3];
real Y[0:3][0:3];
real X[0:3][0:3];
real I[0:3][0:3];

integer i,j,k;
real sum;

always @(*)
begin

/* Convert Q16.16 to real */

A[0][0]=H0/65536.0;  A[0][1]=H1/65536.0;  A[0][2]=H2/65536.0;  A[0][3]=H3/65536.0;
A[1][0]=H4/65536.0;  A[1][1]=H5/65536.0;  A[1][2]=H6/65536.0;  A[1][3]=H7/65536.0;
A[2][0]=H8/65536.0;  A[2][1]=H9/65536.0;  A[2][2]=H10/65536.0; A[2][3]=H11/65536.0;
A[3][0]=H12/65536.0; A[3][1]=H13/65536.0; A[3][2]=H14/65536.0; A[3][3]=H15/65536.0;


/* Identity Matrix */

for(i=0;i<4;i=i+1)
for(j=0;j<4;j=j+1)
begin
if(i==j) I[i][j]=1;
else I[i][j]=0;
end


/* Initialize L and U */

for(i=0;i<4;i=i+1)
for(j=0;j<4;j=j+1)
begin
L[i][j]=0;
U[i][j]=0;
end


/* LU Decomposition (Doolittle Method) */

for(i=0;i<4;i=i+1)
begin

/* Compute U */

for(j=i;j<4;j=j+1)
begin
sum=0;
for(k=0;k<i;k=k+1)
sum=sum + L[i][k]*U[k][j];

U[i][j]=A[i][j]-sum;
end


/* Compute L */

for(j=i;j<4;j=j+1)
begin

if(i==j)
L[i][i]=1;

else
begin
sum=0;
for(k=0;k<i;k=k+1)
sum=sum + L[j][k]*U[k][i];

L[j][i]=(A[j][i]-sum)/U[i][i];
end

end

end


/* Forward Substitution: L * Y = I */

for(j=0;j<4;j=j+1)
begin

for(i=0;i<4;i=i+1)
begin

sum=0;

for(k=0;k<i;k=k+1)
sum=sum + L[i][k]*Y[k][j];

Y[i][j]=(I[i][j]-sum)/L[i][i];

end

end


/* Backward Substitution: U * X = Y */

for(j=0;j<4;j=j+1)
begin

for(i=3;i>=0;i=i-1)
begin

sum=0;

for(k=i+1;k<4;k=k+1)
sum=sum + U[i][k]*X[k][j];

X[i][j]=(Y[i][j]-sum)/U[i][i];

end

end


/* Convert back to Q16.16 */

Hinv0  = X[0][0]*65536;  Hinv1  = X[0][1]*65536;  Hinv2  = X[0][2]*65536;  Hinv3  = X[0][3]*65536;
Hinv4  = X[1][0]*65536;  Hinv5  = X[1][1]*65536;  Hinv6  = X[1][2]*65536;  Hinv7  = X[1][3]*65536;
Hinv8  = X[2][0]*65536;  Hinv9  = X[2][1]*65536;  Hinv10 = X[2][2]*65536;  Hinv11 = X[2][3]*65536;
Hinv12 = X[3][0]*65536;  Hinv13 = X[3][1]*65536;  Hinv14 = X[3][2]*65536;  Hinv15 = X[3][3]*65536;

done = start;

end

endmodule