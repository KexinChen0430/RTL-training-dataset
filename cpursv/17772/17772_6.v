
module emesh2packet  #(parameter  AW = 32, PW = 104)
  (input  write_out,
   input  [1:0] datamode_out,
   input  [4:0] ctrlmode_out,
   input  [(-1)+AW:0] dstaddr_out,
   input  [(-1)+AW:0] data_out,
   input  [(-1)+AW:0] srcaddr_out,
   output [(-1)+PW:0] packet_out);

  assign packet_out[0] = write_out;
  assign packet_out[2:1] = datamode_out[1:0];
  assign packet_out[7:3] = ctrlmode_out[4:0];
  
  generate
      if (PW == 136) 
        begin : p136
          assign packet_out[39:8] = dstaddr_out[31:0];
          assign packet_out[71:40] = data_out[31:0];
          assign packet_out[103:72] = srcaddr_out[31:0];
          assign packet_out[135:104] = dstaddr_out[63:32];
        end
      else if (PW == 104) 
        begin : p104
          assign packet_out[39:8] = dstaddr_out[31:0];
          assign packet_out[71:40] = data_out[31:0];
          assign packet_out[103:72] = srcaddr_out[31:0];
        end
      else if (PW == 72) 
        begin : p72
          assign packet_out[39:8] = dstaddr_out[31:0];
          assign packet_out[71:40] = data_out[31:0];
        end
      else if (PW == 40) 
        begin : p40
          assign packet_out[23:8] = dstaddr_out[15:0];
          assign packet_out[39:24] = data_out[15:0];
        end
        
  endgenerate

endmodule

