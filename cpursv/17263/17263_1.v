
module packet2emesh  #(parameter  AW = 32, PW = 104)
  (input  [PW-1:0] packet_in,
   output write_in,
   output [1:0] datamode_in,
   output [4:0] ctrlmode_in,
   output [AW-1:0] dstaddr_in,
   output [AW-1:0] srcaddr_in,
   output [AW-1:0] data_in);

  
  generate
      if (PW == 104) 
        begin : p104
          assign write_in = packet_in[0];
          assign datamode_in[1:0] = packet_in[1<<1:1];
          assign ctrlmode_in[4:0] = {1'b0,packet_in[6:3]};
          assign dstaddr_in[31:0] = packet_in[39:8];
          assign srcaddr_in[31:0] = packet_in[103:72];
          assign data_in[31:0] = packet_in[71:40];
        end
      else if (PW == 136) 
        begin : p136
          assign write_in = packet_in[0];
          assign datamode_in[1:0] = packet_in[1<<1:1];
          assign ctrlmode_in[4:0] = packet_in[7:3];
          assign dstaddr_in[63:0] = {packet_in[135:104],packet_in[39:8]};
          assign srcaddr_in[63:0] = {packet_in[71:40],packet_in[135:72]};
          assign data_in[63:0] = packet_in[103:40];
        end
      else if (PW == 72) 
        begin : p72
          assign write_in = packet_in[0];
          assign datamode_in[1:0] = packet_in[1<<1:1];
          assign ctrlmode_in[4:0] = packet_in[7:3];
          assign dstaddr_in[31:0] = packet_in[39:8];
          assign data_in[31:0] = packet_in[71:40];
        end
      else if (PW == 40) 
        begin : p40
          assign write_in = packet_in[0];
          assign datamode_in[1:0] = packet_in[1<<1:1];
          assign ctrlmode_in[4:0] = packet_in[7:3];
          assign dstaddr_in[15:0] = packet_in[23:8];
          assign data_in[15:0] = packet_in[39:24];
        end
      else 
        begin : unknown

        end
  endgenerate

endmodule

