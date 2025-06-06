
module ycrcb2rgb(R,G,B,clk,rst,Y,Cr,Cb);

  output [7:0] R,G,B;
  input  clk,rst;
  input  [9:0] Y,Cr,Cb;
  wire [7:0] R,G,B;
  reg  [20:0] R_int,G_int,B_int,X_int,A_int,B1_int,B2_int,C_int;
  reg  [9:0] const1,const2,const3,const4,const5;
  reg  [9:0] Y_reg,Cr_reg,Cb_reg;

  
  always @(posedge clk)
      begin
        const1 = 10'b0100101010;
        const2 = 10'b0110011000;
        const3 = 10'b0011010000;
        const4 = 10'b0001100100;
        const5 = 10'b1000000100;
      end
  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          Y_reg <= 0;
          Cr_reg <= 0;
          Cb_reg <= 0;
        end
      else 
        begin
          Y_reg <= Y;
          Cr_reg <= Cr;
          Cb_reg <= Cb;
        end
  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          A_int <= 0;
          B1_int <= 0;
          B2_int <= 0;
          C_int <= 0;
          X_int <= 0;
        end
      else 
        begin
          X_int <= const1*(Y_reg+(-'d64));
          A_int <= const2*(Cr_reg-'d512);
          B1_int <= (Cr_reg-'d512)*const3;
          B2_int <= const4*((0-'d512)+Cb_reg);
          C_int <= ((0-'d512)+Cb_reg)*const5;
        end
  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          R_int <= 0;
          G_int <= 0;
          B_int <= 0;
        end
      else 
        begin
          R_int <= X_int+A_int;
          G_int <= (X_int+(-B1_int))-B2_int;
          B_int <= C_int+X_int;
        end
  assign R = R_int[20] ? 0 : 
             (R_int[19:18] == 2'b0) ? R_int[17:10] : 8'b11111111;
  assign G = G_int[20] ? 0 : 
             (G_int[19:18] == 2'b0) ? G_int[17:10] : 8'b11111111;
  assign B = B_int[20] ? 0 : 
             (B_int[19:18] == 2'b0) ? B_int[17:10] : 8'b11111111;
endmodule

