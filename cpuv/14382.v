module cpu_v1(clk, rst, Aout, Bout, PCout, IRout, Zout, Cout);
input clk; 
input rst; 
output [7:0] Aout; 
output [7:0] Bout; 
output [9:0] PCout; 
output [13:0] IRout; 
output Zout; 
output Cout; 
reg [7:0] A; 
reg [7:0] B; 
reg [9:0] PC; 
reg [13:0] IR; 
reg Z; 
reg C; 
reg [7:0] RAM[0:15]; 
reg [13:0] ROM[0:1023]; 
wire [3:0] OPCODE = IR[13:10]; 
wire [9:0] ADDRESS = IR[9:0]; 
wire [7:0] OPERATOR = IR[7:0]; 
assign Aout = A; 
assign Bout = B; 
assign PCout = PC; 
assign IRout = IR; 
assign Zout = Z; 
assign Cout = C; 
initial
begin
    ROM[0] = 14'b1010_00_00000101; 
    ROM[1] = 14'b0000_0000000000; 
end
always @(posedge clk)
begin
    if (~rst) 
    begin
        PC <= 0;
        A <= 0;
        B <= 0;
        Z <= 0;
        C <= 0;
    end
    else 
    begin
        IR <= ROM[PC];
        PC <= PC + 1;
    end
end
always @(negedge clk)
begin
    case (OPCODE)
    endcase
end
endmodule