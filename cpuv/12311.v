module switch(
    input clk,                 
    input reset,               
    input data_status,         
    input [7:0] data,          
    output reg [7:0] port0,    
    output reg [7:0] port1,    
    output reg [7:0] port2,    
    output reg [7:0] port3,    
    output reg ready_0,        
    output reg ready_1,        
    output reg ready_2,        
    output reg ready_3,        
    input read_0,              
    input read_1,              
    input read_2,              
    input read_3,              
    input mem_en,              
    input mem_rd_wr,           
    input [1:0] mem_add,       
    input [7:0] mem_data       
);
initial begin
    port0 <= 8'b0;
    port1 <= 8'b0;
    port2 <= 8'b0;
    port3 <= 8'b0;
    ready_0 <= 1'b0;
    ready_1 <= 1'b0;
    ready_2 <= 1'b0;
    ready_3 <= 1'b0;
    repeat(100) @ (posedge clk);
    ready_0 <= 1'b1;
    @ (posedge clk);
    @ (posedge clk);
    port0 <= 8'b1;
    repeat(2) @ (posedge clk);
    port0 <= 8'b1;
    @ (posedge clk);
    port0 <= 8'b1;
    @ (posedge clk);
    port0 <= 8'b1;
    @ (posedge clk);
    ready_0 <= 1'b0;
end
endmodule