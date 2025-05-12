module ram0(
    input wrclk,       
    input [15:0] di,   
    input wren,        
    input [9:0] wraddr, 
    input rdclk,       
    input rden,        
    input [9:0] rdaddr, 
    output reg [15:0] do); 
    (* ram_style = "block" *) reg [15:0] ram[0:1023]; 
    initial begin
        ram[0] = 16'b00000000_00000001; 
        ram[1] = 16'b10101010_10101010; 
        ram[2] = 16'b01010101_01010101; 
        ram[3] = 16'b11111111_11111111; 
        ram[4] = 16'b11110000_11110000; 
        ram[5] = 16'b00001111_00001111; 
        ram[6] = 16'b11001100_11001100; 
        ram[7] = 16'b00110011_00110011; 
        ram[8] = 16'b00000000_00000010; 
        ram[9] = 16'b00000000_00000100; 
    end
    always @ (posedge wrclk) begin
        if(wren == 1) begin 
            ram[wraddr] <= di; 
        end
    end
    always @ (posedge rdclk) begin
        if(rden == 1) begin 
            do <= ram[rdaddr]; 
        end
    end
endmodule