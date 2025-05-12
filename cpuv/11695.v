module sp_mux_16to1_sel4_7_1 #(
    parameter
        ID                = 0,        
        NUM_STAGE         = 1,        
        din1_WIDTH       = 32,        
        din2_WIDTH       = 32,        
        din17_WIDTH         = 32,     
        dout_WIDTH            = 32    
)(
    input  [6 : 0]     din1,        
    input  [6 : 0]     din2,        
    input  [3 : 0]    din17,        
    output [6 : 0]   dout          
);
wire [3 : 0]     sel;              
wire [6 : 0]     mux_1_0;          
wire [6 : 0]     mux_1_1;          
wire [6 : 0]     mux_2_0;          
wire [6 : 0]     mux_2_1;          
wire [6 : 0]     mux_3_0;          
wire [6 : 0]     mux_3_1;          
wire [6 : 0]     mux_4_0;          
assign sel = din17;
assign mux_1_0 = (sel[0] == 0)? din1 : din2;
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;
assign mux_3_0 = (sel[2] == 0)? mux_2_0 : mux_2_1;
assign mux_4_0 = (sel[3] == 0)? mux_3_0 : mux_3_1;
assign dout = mux_4_0;
endmodule 