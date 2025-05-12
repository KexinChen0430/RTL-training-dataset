
module synth_reg_reg(i,ce,clr,clk,o);

  parameter  width = 8;
  parameter  latency = 1;
  input  [(-1)+width:0] i;
  input  ce,clr,clk;
  output [(-1)+width:0] o;
  wire [(-1)+width:0] o;

  genvar idx;
  reg  [(-1)+width:0] reg_bank[latency:0];

  integer j;

  
  initial  
  begin
    for (j = 0; j < (1+latency); j = j+1)
        begin
          reg_bank[j] = {width{1'b0}};
        end
  end
  
  generate
      if (latency == 0) 
        begin : has_0_latency
          assign o = i;
        end
        
  endgenerate

  
  always @(i)
      begin
        reg_bank[0] = i;
      end
  
  generate
      if (latency > 0) 
        begin : more_than_1
          assign o = reg_bank[latency];
          for (idx = 0; idx < latency; idx = idx+1)
              begin : sync_loop
                
                always @(posedge clk)
                    begin
                      if (ce) 
                        begin
                          reg_bank[idx+1] <= reg_bank[idx];
                        end
                        
                    end
              end
        end
        
  endgenerate

endmodule

