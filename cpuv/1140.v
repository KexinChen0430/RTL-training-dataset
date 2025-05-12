module note2dds_5st_gen(
    input wire clk,          
    input wire [6:0] note,   
    output [31:0] adder      
);
(* romstyle = "logic" *) reg [31:0] table_values;
reg [4:0] addr_reg;
wire [3:0] diap = (note <  12) ? 4'd0 :
                  (note <  24) ? 4'd1 :
                  (note <  36) ? 4'd2 :
                  (note <  48) ? 4'd3 :
                  (note <  60) ? 4'd4 :
                  (note <  72) ? 4'd5 :
                  (note <  84) ? 4'd6 :
                  (note <  96) ? 4'd7 :
                  (note < 108) ? 4'd8 :
                  (note < 120) ? 4'd9 : 4'd10;
wire [6:0] c_addr = note - (diap * 4'd12);
wire [3:0] divider = 4'd10 - diap;
always@(posedge clk) begin
    addr_reg <= c_addr[3:0]; 
    case(addr_reg)
        4'd0: table_values <= 32'd359575;
        4'd1: table_values <= 32'd380957;
        4'd2: table_values <= 32'd403610;
        4'd3: table_values <= 32'd427610;
        4'd4: table_values <= 32'd453037;
        4'd5: table_values <= 32'd479976;
        4'd6: table_values <= 32'd508516;
        4'd7: table_values <= 32'd538754;
        4'd8: table_values <= 32'd570790;
        4'd9: table_values <= 32'd604731;
        4'd10: table_values <= 32'd640691;
        4'd11: table_values <= 32'd678788;
        4'd12 to 4'd15: table_values <= 32'd0; 
    endcase
end
assign adder = table_values >> divider;
endmodule