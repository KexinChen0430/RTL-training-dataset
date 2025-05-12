module ForwardUnit(
    EX_RS,    
    EX_RT,    
    MEM_RD,   
    WB_RD,    
    MEM_WB,   
    WB_WB,    
    Forward_A, 
    Forward_B  
);
input MEM_WB, WB_WB; 
input [4:0] EX_RS, EX_RT, MEM_RD, WB_RD; 
output [1:0] Forward_A, Forward_B; 
reg [1:0] Forward_A, Forward_B; 
always @(EX_RS or EX_RT)
begin
    if (WB_WB && WB_RD != 0 && MEM_RD != WB_RD && WB_RD == EX_RS)
    begin
        assign Forward_A = 2'b01;
    end
    else if (MEM_WB && MEM_RD != 0 && MEM_RD == EX_RS)
    begin
        assign Forward_A = 2'b10;
    end
    else
    begin
        assign Forward_A = 2'b00;
    end
    if (WB_WB && WB_RD != 0 && MEM_RD != WB_RD && WB_RD == EX_RT)
    begin
        assign Forward_B = 2'b01;
    end
    else if (MEM_WB && MEM_RD != 0 && MEM_RD == EX_RT)
    begin
        assign Forward_B = 2'b10;
    end
    else
    begin
        assign Forward_B = 2'b00;
    end
end
endmodule 