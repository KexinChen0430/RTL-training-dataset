module FTCP_N (C, PRE, CLR, T, Q); 
parameter INIT = 0; 
input C, PRE, CLR, T; 
output wire Q; 
reg Q_; 
initial begin 
    Q_ <= INIT; 
end
always @(negedge C, posedge PRE, posedge CLR) begin 
    if (CLR == 1) 
        Q_ <= 0; 
    else if (PRE == 1) 
        Q_ <= 1; 
    else if (T == 1) 
        Q_ <= ~Q_; 
end
assign Q = Q_; 
endmodule 