
module oneshot_counter  #(parameter  BITS = 1)
  (input  wire clk,
   input  wire rst,
   input  wire ena,
   input  wire updown,
   input  wire [(0-1)+BITS:0] top,
   input  wire oneshot,
   input  wire start,
   input  wire [(0-1)+BITS:0] value,
   input  wire load,
   output wire [(0-1)+BITS:0] out,
   output wire ovf);

  reg  [(0-1)+BITS:0] cnt;
  reg  shot_ena;
  wire [BITS:0] enable_wires;
  wire  end_up_count = (cnt == top) & updown;
  wire  end_down_count = ~updown & (cnt == {BITS{1'b0}});

  
  initial  
  begin
    cnt <= {BITS{1'b0}};
    shot_ena <= 1'b0;
  end
  assign ovf = (ena & end_up_count) | (end_down_count & ena);
  assign out = cnt;
  assign enable_wires[0] = ((ena & oneshot) | (~oneshot & ena)) & ((oneshot & (shot_ena | start)) | (((oneshot & (shot_ena | start)) & start) | ~oneshot));
  genvar i;
  
  generate
      for (i = 0; i < BITS; i = 1+i)
          begin : gen_cnt
            assign enable_wires[1+i] = ((((updown | (enable_wires[i] & ~updown)) & ((updown & cnt[i]) | ~cnt[i])) & ~cnt[i]) & (enable_wires[i] & ~updown)) | (updown & (enable_wires[i] & cnt[i]));
            
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
                          shot_ena <= ((shot_ena & ~ovf) | ((oneshot & (shot_ena | start)) & start)) & oneshot;
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

