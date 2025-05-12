module edc_generator #() (
    input   [31:0]  i_data,                  
    input   [7:0]   i_ecc,                   
    input           i_write_enabled,         
    output  [7:0]   o_ecc_syndrome           
);
wire [31:0] parity_check_matrix[0:7];
wire [7:0] generated_ecc; 
generate
    assign parity_check_matrix[7] = 32'b10101010_10101010_11000000_11000000;
    assign parity_check_matrix[6] = 32'b01010101_01010101_00110000_00110000;
    assign parity_check_matrix[5] = 32'b11111111_00000000_00001100_00001100;
    assign parity_check_matrix[4] = 32'b00000000_11111111_00000011_00000011;
    assign parity_check_matrix[3] = 32'b11000000_11000000_11111111_00000000;
    assign parity_check_matrix[2] = 32'b00110000_00110000_00000000_11111111;
    assign parity_check_matrix[1] = 32'b00001100_00001100_10101010_10101010;
    assign parity_check_matrix[0] = 32'b00000011_00000011_01010101_01010101;
endgenerate
genvar r,c; 
generate
    for (r=0; r<8; r=r+1) begin: ecc_calculation_loop
        assign generated_ecc[r] = (^ (parity_check_matrix[r] & i_data));
        assign o_ecc_syndrome[r] = i_write_enabled ? generated_ecc[r] : generated_ecc[r] ^ i_ecc[r];
    end
endgenerate
endmodule 