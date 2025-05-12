module ram0(
    input wrclk,          
    input [63:0] di,      
    input wren,           
    input [8:0] wraddr,   
    input rdclk,          
    input rden,           
    input [8:0] rdaddr,   
    output reg [63:0] do); 
    (* ram_style = "block" *) reg [63:0] ram[0:511]; 
    genvar i; 
    generate
        for (i=0; i<1024; i=i+1) 
        begin
            initial begin
                ram[i] <= i; 
            end
        end
    endgenerate
    always @ (posedge wrclk) begin 
        if (wren == 1) begin 
            ram[wraddr] <= di; 
        end
    end
    always @ (posedge rdclk) begin 
        if (rden == 1) begin 
            do <= ram[rdaddr]; 
        end
    end
endmodule