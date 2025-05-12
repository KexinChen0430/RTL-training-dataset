module NW_pipereg (
    push,       
    pop,        
    data_in,    
    data_out,   
    ready,      
    valid,      
    clk,        
    rst_n       
);
input push, pop, clk, rst_n;
input reg_t data_in;          
output reg_t data_out;        
output valid, ready;
logic valid;                  
reg_t r;                      
always@(posedge clk) begin
    if (!rst_n) begin          
        valid <= 1'b0;         
    end else begin
        assert (!(push & !ready)) else $fatal;
        if (pop) begin
        end
        if (push) begin
            r <= data_in;      
            valid <= 1'b1;     
        end else begin
            if (pop) begin
                valid <= 1'b0; 
            end
        end
    end
end 
assign ready = !valid || pop;
assign data_out = r;
endmodule