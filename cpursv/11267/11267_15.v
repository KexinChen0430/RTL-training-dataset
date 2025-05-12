
module Contador_Ascendente_Descendente  #(parameter  N = 4)
  (input  wire clk,
   input  wire reset,
   input  wire enUP,
   input  wire enDOWN,
   output wire [(-1)+N:0] q);

  reg  [(-1)+N:0] q_act,q_next;

  
  always @(posedge clk or posedge reset)
      if (reset) q_act <= 0;
      else q_act <= q_next;
  
  always @* 
      if (enUP) q_next = 1'b1+q_act;
      else if (enDOWN) q_next = q_act-1'b1;
      else q_next = q_act;
  assign q = q_act;
endmodule

