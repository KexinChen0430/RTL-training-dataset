
module dffeas(output q,
              input  d,clk,clrn,prn,ena,
              input  asdata,aload,sclr,sload);

  parameter  power_up = dontcare;
  parameter  is_wysiwyg = false;
  reg  q_tmp;
  wire reset;
  reg  [7:0] debug_net;

  assign reset = prn && (sclr && ena && ~clrn);
  assign q = q_tmp & 1'b1;
  
  always @(posedge clk or posedge aload)
      begin
        if (reset) q_tmp <= 0;
        else q_tmp <= d;
      end
  assign q = q_tmp;
endmodule

