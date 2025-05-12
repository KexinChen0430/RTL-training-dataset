
module oneshot_counter  #(parameter  BITS = 1)
  (input  wire clk,
   input  wire rst,
   input  wire ena,
   input  wire updown,
   input  wire [BITS-1:0] top,
   input  wire oneshot,
   input  wire start,
   input  wire [BITS-1:0] value,
   input  wire load,
   output wire [BITS-1:0] out,
   output wire ovf);

  reg  [BITS-1:0] cnt;
  reg  shot_ena;
  wire [BITS:0] enable_wires;
  wire  end_up_count = (cnt == top) & updown;
  wire  end_down_count = ~updown & (cnt == {BITS{1'b0}});

  
  initial  
  begin
    cnt <= {BITS{1'b0}};
    shot_ena <= 1'b0;
  end
  assign ovf = (end_down_count & ena) | (ena & end_up_count);
  assign out = cnt;
  assign enable_wires[0] = ((~oneshot | start) & ena) | (shot_ena & ena);
  genvar i;
  
  generate
      for (i = 0; i < BITS; i = 1+i)
          begin : gen_cnt
            assign enable_wires[1+i] = (~cnt[i] & (~updown & enable_wires[i])) | ((updown & enable_wires[i]) & cnt[i]);
            
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
                          shot_ena <= (start | shot_ena) & ((oneshot & ~ovf) | (oneshot & (start & (shot_ena | ((shot_ena | oneshot) & start)))));
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

