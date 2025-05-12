module bsg_trace_rom #(
    parameter `BSG_INV_PARAM(width_p),        
    parameter `BSG_INV_PARAM(addr_width_p)    
)
(
    input  [addr_width_p-1:0] addr_i,        
    output logic [width_p-1:0] data_o        
);
always_comb case(addr_i)
    0: data_o = width_p ' (27'b0001_11100000110000101_10_00_11); 
    1: data_o = width_p ' (27'b0010_000000000000000_01100011); 
    2: data_o = width_p ' (27'b0010_000000000000000_01100001); 
    3: data_o = width_p ' (27'b0010_000000000000000_01110000); 
    4: data_o = width_p ' (27'b0001_00001100110011111_01_11_01); 
    5: data_o = width_p ' (27'b0010_000000000000000_11011101); 
    6: data_o = width_p ' (27'b0010_000000000000000_01100111); 
    7: data_o = width_p ' (27'b0001_00001100110011111_00_11_01); 
    8: data_o = width_p ' (27'b0010_000000000000000_11001101); 
    9: data_o = width_p ' (27'b0011_00000000000000000_000000); 
    default: data_o = 'X;
endcase
endmodule