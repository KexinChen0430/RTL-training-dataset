
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
            start_edge = ((((250*v_value[7])+((125*v_value[6])+(62.5*v_value[5])))+(v_value[1]*3.9))+(v_value[0]*1.95))+(((31.2*v_value[4])+(15.6*v_value[3]))+(7.8*v_value[2]));
            end_edge = 100+start_edge;
          end
        else 
          begin
            start_edge <= start_edge;
            end_edge <= end_edge;
          end
      end
endmodule

