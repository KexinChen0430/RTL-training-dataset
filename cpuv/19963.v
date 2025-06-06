module dffa1(clk, arst, d, q);
    input clk;   
    input arst;  
    input d;     
    output reg q; 
    always @(posedge clk or negedge arst) begin
        if (~arst) 
            q <= 0; 
        else       
            q <= d; 
    end
endmodule 