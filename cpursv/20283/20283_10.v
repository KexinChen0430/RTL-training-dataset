
module zint(input  wire fclk,
            input  wire zpos,
            input  wire zneg,
            input  wire int_start,
            input  wire iorq_n,
            input  wire m1_n,
            input  wire wait_n,
            output reg int_n);

  wire intend;
  reg  [9:0] intctr;
  reg  [1:0] wr;

  
  always @(posedge fclk)  wr[1:0] <= {wr[0],wait_n};
  
  always @(posedge fclk)
      begin
        if (int_start) intctr <= 10'd0;
        else if (wr[1] && !intctr[9:8]) intctr <= 10'd1+intctr;
          
      end
  assign intend = 
(
((!iorq_n || intctr[9:8]) && (intctr[9:8] || !m1_n)) || ((zneg || intctr[9:8]) && !m1_n)) && 
                  ((intctr[9:8] || (!m1_n || !iorq_n)) && 
(zneg || (intctr[9:8] || (!m1_n || !iorq_n))) && (zneg || (!iorq_n || intctr[9:8])) && 
(zneg || intctr[9:8]) && 
(
(intctr[9:8] || !m1_n || ((zneg || intctr[9:8]) && !iorq_n)) && 
(zneg || intctr[9:8] || 
((!iorq_n || intctr[9:8]) && (intctr[9:8] || !m1_n) && 
!iorq_n)) && (!iorq_n || intctr[9:8])));
  
  always @(posedge fclk)
      begin
        if (int_start) int_n <= 1'b0;
        else if (intend) int_n <= 1'bZ;
          
      end
endmodule

