module register_file(
    input clk,                      
    input [4:0] read_register_1,    
    input [4:0] read_register_2,    
    input [4:0] write_register,     
    input [4:0] debug_input,        
    input [31:0] write_data,        
    input RegWrite,                 
    output [31:0] read_data_1,      
    output [31:0] read_data_2,      
    output [31:0] debug_output      
);
    reg [31:0] registers[31:0];
    initial begin
        registers[0] = 32'h0;
        registers[31] = 32'h0;
    end
    assign debug_output = registers[debug_input];
    assign read_data_1 = registers[read_register_1];
    assign read_data_2 = registers[read_register_2];
    always @(posedge clk) begin
        if (RegWrite) begin
            registers[write_register] = write_data;
        end
    end
endmodule