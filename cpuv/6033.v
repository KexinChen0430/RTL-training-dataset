module clock_reduce(
    input clk,                  
    input reset_n,              
    input [2:0] clock_sel,      
    output clk_reduced,         
    output clk_100_reduced      
);
reg [10:0] counter;             
reg [10:0] counter_100;         
assign clk_reduced     = clk_reduced_p | clk_reduced_n;       
assign clk_100_reduced = clk_100_reduced_p | clk_100_reduced_n; 
reg clk_reduced_i;              
reg clk_100_reduced_i;          
reg clk_reduced_p;              
reg clk_100_reduced_p;          
reg clk_reduced_n;              
reg clk_100_reduced_n;          
always@(*)
begin
    clk_reduced_p = 1'b0;       
    if(clk_reduced_i)
    begin
        clk_reduced_p = 1'b1;   
    end
end
always@(*)
begin
    clk_reduced_n = 1'b1;       
    if(!clk_reduced_i)
    begin
        clk_reduced_n = 1'b0;   
    end
end
always@(*)
begin
    clk_100_reduced_p = 1'b0;   
    if(clk_100_reduced_i)
    begin
        clk_100_reduced_p = 1'b1; 
    end
end
always@(*)
begin
    clk_100_reduced_n = 1'b1;   
    if(!clk_100_reduced_i)
    begin
        clk_100_reduced_n = 1'b0; 
    end
end
always@(posedge clk)
begin
    if(!reset_n) 
    begin
        counter <= 11'd0;             
        counter_100 <= 11'd0;         
        clk_reduced_i <= 1'b0;        
        clk_100_reduced_i <= 1'b0;    
    end
    else 
    begin
        case(clock_sel)
        3'd0: 
        endcase
        if(counter_100 >=11'd0 && counter_100 <=11'd1 )
        begin
            clk_100_reduced_i <= 1'b1;   
            counter_100 <= counter_100 + 11'd1; 
        end
        else if(counter_100 >=11'd2 && counter_100 <=11'd4)
        begin
            clk_100_reduced_i <= 1'b0;   
            counter_100 <= counter_100 + 11'd1; 
        end
        else
        begin
            clk_100_reduced_i <= 1'b1;   
            counter_100 <= 11'd0;        
        end
    end
end
endmodule