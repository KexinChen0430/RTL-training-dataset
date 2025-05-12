
module queue(input  clk_i,
             input  reset_i,
             input  [DHB:0] dat_i,
             input  push_i,
             input  pop_i,
             input  oe_i,
             output [DHB:0] dat_o,
             output full_o,
             output empty_o,
             output [PHB:0] rp_to,
             output [PHB:0] wp_to,
             output [1+PHB:0] room_to);

  parameter  DEPTH_BITS = 4;
  parameter  DATA_BITS = 8;
  parameter  DHB = (0-1)+DATA_BITS;
  parameter  PHB = (0-1)+DEPTH_BITS;
  parameter  CAPACITY = 1<<DEPTH_BITS;
  reg  [PHB:0] rp,wp;
  reg  [1+PHB:0] room;
  reg  [DHB:0] storage[0:CAPACITY-1];

  assign dat_o = oe_i ? storage[rp] : 0;
  assign full_o = room == 0;
  assign empty_o = room == CAPACITY;
  assign rp_to = rp;
  assign wp_to = wp;
  assign room_to = room;
  
  always @(posedge clk_i)
      begin
        rp <= rp;
        wp <= wp;
        room <= room;
        if (reset_i) 
          begin
            rp <= 0;
            wp <= 0;
            room <= CAPACITY;
          end
          
        if (~full_o & (~pop_i & push_i)) 
          begin
            storage[wp] <= dat_i;
            wp <= 1+wp;
            room <= room+(0-1);
          end
          
        if (~push_i & (pop_i & ~empty_o)) 
          begin
            rp <= 1+rp;
            room <= room+1;
          end
          
        if (pop_i & push_i) 
          begin
            storage[wp] <= dat_i;
            wp <= 1+wp;
            rp <= 1+rp;
          end
          
      end
endmodule

