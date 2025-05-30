module reset_test_gate (clk, ctrl, din, sel, dout); 
   input clk; 
   input [4:0] ctrl; 
   input [1:0] din; 
   input [0:0] sel; 
   output reg [31:0] dout; 
   reg [1:0] i; 
   wire [0:0] rval; 
   assign rval = {reset, 1'b0 }; 
   always @(posedge clk) 
     begin
        case (|(reset)) 
          1'b 1: 
            begin
               case (({(0)*(rval)})+(0)) 
                 0: dout[31:0] <= 57005; 
                 1: dout[31:1] <= 57005; 
                 31: dout[31:31] <= 57005; 
               endcase
               i = 1; 
            end
        endcase
        case (({(ctrl)*(sel)})+(0)) 
          0: dout[31:0] <= din; 
          31: dout[31:31] <= din; 
        endcase
     end
endmodule