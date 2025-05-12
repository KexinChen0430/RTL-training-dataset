module bm_jk_rtl(
    clk,        
    clr_n,      
    j,          
    k,          
    q,          
    q_n         
);
input clk;     
input clr_n;   
input j;       
input k;       
output q;      
output q_n;    
wire clk;      
wire clr_n;    
wire j;        
wire k;        
reg q;         
wire q_n;      
parameter [1:0] HOLD   = 0, 
                RESET  = 1, 
                SET    = 2, 
                TOGGLE = 3; 
assign #`DEL q_n = ~q; 
always @(negedge clk or negedge clr_n) begin
    if (~clr_n) begin 
        q <= #`DEL 1'b0;
    end
    else begin 
        case ({j,k}) 
            RESET:  q <= #`DEL 1'b0; 
            SET:    q <= #`DEL 1'b1; 
            TOGGLE: q <= #`DEL ~q;   
        endcase
    end
end
endmodule 