module crcx 
(
input pixclk, 
input rstn, 
input enable_crc, 
input init_crc, 
input [7:0] red, 
input [7:0] grn, 
input [7:0] blu, 
output [7:0] misr_red, 
output [7:0] misr_grn, 
output [7:0] misr_blu 
);
reg[23:0] crc_out; 
wire[23:0] crc_in ; 
assign crc_in[23:16] = red[7:0] ;
assign crc_in[15: 8] = grn[7:0] ;
assign crc_in[ 7: 0] = blu[7:0] ;
always @(posedge pixclk or negedge rstn)
    if (!rstn) 
       begin     
           crc_out[23:0] <=  24'hFFFFFF; 
       end
    else begin
     if (init_crc) 
             crc_out[23:0] <=  24'hFFFFFF; 
     else if (enable_crc) 
         begin
          crc_out[0]  <= crc_out[1]  ^ crc_in[1];
          crc_out[23] <= crc_out[0]  ^ crc_in[0];
         end
    end
assign  misr_red[7:0] = crc_out[23:16];
assign  misr_grn[7:0] = crc_out[15:8];
assign  misr_blu[7:0] = crc_out[7:0];
endmodule 