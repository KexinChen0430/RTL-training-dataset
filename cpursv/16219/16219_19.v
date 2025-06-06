
module rx_dsp_model(input  clk,
                    input  reset,
                    input  run,
                    input  [7:0] decim,
                    output strobe,
                    output [31:0] sample);

  reg  [15:0]  pktnum = 0;
  reg  [15:0]  counter = 0;
  reg  run_d1;

  
  always @(posedge clk)  run_d1 <= run;
  
  always @(posedge clk)
      if (~run_d1 & run) 
        begin
          counter <= 0;
          pktnum <= 1+pktnum;
        end
      else if (strobe & run) counter <= 1+counter;
        
  assign sample = {pktnum,counter};
  reg  [7:0]  stb_ctr = 0;

  
  always @(posedge clk)
      if (reset) stb_ctr <= 0;
      else if (~run_d1 & run) stb_ctr <= 1;
      else if (run) 
        if (stb_ctr == (decim+(0-1))) stb_ctr <= 0;
        else stb_ctr <= 1+stb_ctr;
        
  assign strobe = stb_ctr == (decim+(0-1));
endmodule

