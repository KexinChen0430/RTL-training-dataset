module RegTwoN(CLK, RST, Q_OUT, D_INA, ENA, D_INB, ENB);
   parameter width = 1;
   parameter init  = {width {1'b0}} ;
   input     CLK;
   input     RST;
   input     ENA, ENB;
   input [width - 1 : 0] D_INA;
   input [width - 1 : 0] D_INB;
   output [width - 1 : 0] Q_OUT;
   reg [width - 1 : 0]    Q_OUT;
   always@(posedge CLK)
     begin
        if (RST == `BSV_RESET_VALUE)
          Q_OUT <= `BSV_ASSIGNMENT_DELAY init;
        else
          begin
             if (ENA)
               Q_OUT <= `BSV_ASSIGNMENT_DELAY D_INA;
             else if (ENB)
               Q_OUT <= `BSV_ASSIGNMENT_DELAY D_INB;
          end 
     end 
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial begin
      Q_OUT = {((width + 1)/2){2'b10}} ;
   end
`endif 
endmodule