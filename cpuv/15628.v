module RegA(CLK, RST, Q_OUT, D_IN, EN); 
   parameter width = 1; 
   parameter init = { width {1'b0}} ; 
   input     CLK; 
   input     RST; 
   input     EN; 
   input [width - 1 : 0] D_IN; 
   output [width - 1 : 0] Q_OUT; 
   reg [width - 1 : 0]    Q_OUT; 
   always@(posedge CLK or `BSV_RESET_EDGE RST) begin
      if (RST == `BSV_RESET_VALUE) 
        Q_OUT <= `BSV_ASSIGNMENT_DELAY init; 
      else 
        begin
           if (EN) 
             Q_OUT <= `BSV_ASSIGNMENT_DELAY D_IN; 
        end
   end 
`ifdef BSV_NO_INITIAL_BLOCKS
`else 
   initial begin 
      Q_OUT = {((width + 1)/2){2'b10}} ; 
   end
`endif 
endmodule 