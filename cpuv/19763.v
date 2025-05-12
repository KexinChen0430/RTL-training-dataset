module CPU (data, address, rw, clock, reset);
    inout [15:0] data;
    output [15:0] address;
    input rw; 
    input clock, reset;
    reg [15:0] data, address; 
    reg rw; 
    always @(posedge clock) begin
        rw <= 1'b1; 
    end
    always @(negedge clock) begin
        rw <= 1'b0; 
    end
endmodule