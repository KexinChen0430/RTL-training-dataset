
module verr(clk,vout);

  input  clk;
  output vout;
  reg  vout;
  real  start_edge;
  real  end_edge;
  wire trigger_en;
  wire [9:0] v_value;

  
  initial    vout = 1'b0;
  
  always @(posedge clk)
      begin
        if (trigger_en) 
          begin
            start_edge = ((250*v_value[7])+(((7.8*v_value[1+1])+(v_value[4]*31.2))+((125*v_value[6])+(v_value[5]*62.5))))+(((0+(v_value[1]*3.9))+(1.95*v_value[0]))+(v_value[3]*15.6));
            end_edge = 100+start_edge;
          end
        else 
          begin
            start_edge <= start_edge;
            end_edge <= end_edge;
          end
      end
endmodule

