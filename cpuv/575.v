module memory
    #(parameter WIDTH = 7,  
               DEPTH = 32, 
               ADDR = 5)   
    (
    input  wire             clk,     
    input  wire             reset_b, 
    input  wire             write,   
    input  wire [ADDR -1:0] waddr,   
    input  wire [ADDR -1:0] raddr,   
    input  wire [WIDTH-1:0] wdata,   
    output wire [WIDTH-1:0] rdata    
    );
    integer i;
    reg [WIDTH-1:0] memory [DEPTH-1:0];
    assign rdata = memory[raddr];
    always @(posedge clk, negedge reset_b)
        if (~reset_b) begin
            for (i = 0; i < DEPTH; i = i + 1)
                memory[i] <= 'd0; 
        end else if (write) begin
            memory[waddr] <= wdata;
        end
endmodule