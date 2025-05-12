
module v_shift_registers(clk,rst,clk_ena,si,so);

  parameter  DELAY = 1;
  parameter  WIDTH = 8;
  input  clk,rst,clk_ena;
  input  [(0-1)+WIDTH:0] si;
  output [(0-1)+WIDTH:0] so;
  reg  [(DELAY+1)-1:0] tmp[(0-1)+WIDTH:0];
  integer i;

  
  always @(posedge clk or posedge rst)
      begin
        if (rst) 
          begin
            for (i = 0; i < WIDTH; i = 1+i)
                begin
                  tmp[i] = 'b0;
                end
          end
        else if (clk_ena) 
          begin
            for (i = 0; i < WIDTH; i = 1+i)
                begin
                  tmp[i] = {tmp[i][(-(1+1))+(DELAY+1):0],si[i]};
                end
          end
          
      end
  genvar g;
  
  generate
      for (g = 0; g < WIDTH; g = g+1)
          begin : asfas
            assign so[g] = tmp[g][(DELAY+1)-1];
          end
  endgenerate

endmodule

