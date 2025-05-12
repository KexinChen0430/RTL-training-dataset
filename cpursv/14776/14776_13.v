
module oneshot_counter  #(parameter  BITS = 1)
  (input  wire clk,
   input  wire rst,
   input  wire ena,
   input  wire updown,
   input  wire [BITS+(0-1):0] top,
   input  wire oneshot,
   input  wire start,
   input  wire [BITS+(0-1):0] value,
   input  wire load,
   output wire [BITS+(0-1):0] out,
   output wire ovf);

  reg  [BITS+(0-1):0] cnt;
  reg  shot_ena;
  wire [BITS:0] enable_wires;
  wire  end_up_count = (cnt == top) & updown;
  wire  end_down_count = ~updown & (cnt == {BITS{1'b0}});

  
  initial  
  begin
    cnt <= {BITS{1'b0}};
    shot_ena <= 1'b0;
  end
  assign ovf = ena & ((ena & end_down_count) | end_up_count);
  assign out = cnt;
  assign enable_wires[0] = ((ena & shot_ena) & oneshot) | (ena & ((start & oneshot) | (ena & ~oneshot)));
  genvar i;
  
  generate
      for (i = 0; i < BITS; i = i+1)
          begin : gen_cnt
            assign enable_wires[i+1] = enable_wires[i] & ((updown & cnt[i]) | ((((updown | (enable_wires[i] & ~cnt[i])) & (updown | ~updown)) & enable_wires[i]) & (~updown & ~cnt[i])));
            
            always @(posedge clk or negedge rst)
                begin
                  if (!rst) 
                    begin
                      if (i == 0) 
                        begin
                          shot_ena <= 1'b0;
                        end
                        
                      if (updown) cnt[i] <= 1'b0;
                      else cnt[i] <= top[i];
                    end
                  else if (load) 
                    begin
                      cnt[i] <= value[i];
                    end
                  else if (ena) 
                    begin
                      if (i == 0) 
                        begin
                          shot_ena <= (((~ovf | (start & oneshot)) & (start | shot_ena)) & (shot_ena | oneshot)) & oneshot;
                        end
                        
                      if (end_up_count) 
                        begin
                          cnt[i] <= 1'b0;
                        end
                      else if (end_down_count) 
                        begin
                          cnt[i] <= top[i];
                        end
                      else if (enable_wires[i]) 
                        begin
                          cnt[i] <= ~cnt[i];
                        end
                        
                    end
                    
                end
          end
  endgenerate

endmodule

