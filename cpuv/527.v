module true_dual_port_ram_single_clock
#(
    parameter DATA_WIDTH=8, 
    parameter ADDR_WIDTH=6  
)
(
    input [(DATA_WIDTH-1):0] data_a, 
    input [(ADDR_WIDTH-1):0] addr_a, 
    input we_a,                       
    input [(DATA_WIDTH-1):0] data_b, 
    input [(ADDR_WIDTH-1):0] addr_b, 
    input we_b,                       
    input clk,                        
    output reg [(DATA_WIDTH-1):0] q_a, 
    output reg [(DATA_WIDTH-1):0] q_b  
);
    reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
    always @ (posedge clk)
    begin
        if (we_a) 
        begin
            ram[addr_a] <= data_a; 
            q_a <= data_a;         
        end
        else 
        begin
            q_a <= ram[addr_a];    
        end
    end
    always @ (posedge clk)
    begin
        if (we_b) 
        begin
            ram[addr_b] <= data_b; 
            q_b <= data_b;         
        end
        else 
        begin
            q_b <= ram[addr_b];    
        end
    end
endmodule