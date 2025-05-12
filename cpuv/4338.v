module SSR_W2_H1_T2_Auint8_4_1_(input CLK, input process_valid, input process_CE, input [63:0] inp, output [95:0] process_output);
parameter INSTANCE_NAME="INST";
always @(posedge CLK) begin 
    if(process_valid===1'bx) begin 
        $display("Valid bit can't be x! Module '%s' function 'process'", INSTANCE_NAME);  
    end 
end
reg [31:0] SR_x0_y0;
wire [31:0] unnamedcast5496USEDMULTIPLEcast;
assign unnamedcast5496USEDMULTIPLEcast = ({inp[63:32]});
always @ (posedge CLK) begin 
    if (process_valid && process_CE) begin 
        SR_x0_y0 <= unnamedcast5496USEDMULTIPLEcast; 
    end 
end
assign process_output = {unnamedcast5496USEDMULTIPLEcast,({inp[31:0]}),SR_x0_y0};
endmodule