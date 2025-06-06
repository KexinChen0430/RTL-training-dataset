
module t(clk);

  input  clk;
  integer cyc;

  
  initial    cyc = 1;
  reg  [31:0] in_a;

  reg  [31:0] in_b;

  reg  [31:0] in_c;

  reg  [31:0] in_d;

  reg  [31:0] in_e;

  reg  [15:0] in_f;

  wire [31:0] in_g;

  assign in_g = in_a<<<4;
  reg  [31:0] out_x;

  reg  [31:0] out_y;

  reg  [31:0] out_z;

  reg  [31:0] out_o;

  reg  [31:0] out_p;

  reg  [31:0] out_q;

  assign out_x = {in_f & in_a[31:16],in_f & in_a[15:0]};
  assign out_y = {in_a[31:18] & in_b[31:18],in_a[17:0] & in_b[17:0]};
  assign out_z = {(in_d[31:14] & in_e[31:14]) & in_c[31:14],(in_c[13:0] & in_d[13:0]) & in_e[13:0]};
  assign out_o = out_y | out_z;
  assign out_p = {(in_e[31:16] | in_a[31:16]) & (in_f | in_e[31:16]),(in_f & in_a[15:0]) | in_e[15:0]};
  assign out_q = {{(((in_g[31:25] & ((~in_a[31:25] & in_g[31:25]) | ~in_g[31:25])) & (in_g[31:25] | ~in_g[31:25])) & ((~in_a[31:25] & in_g[31:25]) | ~in_g[31:25])) ^ (((in_g[31:25] | ~in_g[31:25]) & ((in_a[31:25] & (in_a[31:25] | ~in_a[31:25])) & ((~in_a[31:25] & in_g[31:25]) | ~in_g[31:25]))) & ((~in_a[31:25] & in_g[31:25]) | ~in_g[31:25])),(in_g[24:16] & ~in_a[24:16]) | (in_a[24:16] & (~in_a[24:16] | ~in_g[24:16]))},{((((in_a[15:5] | ~in_a[15:5]) & ~in_g[15:5]) | ((in_a[15:5] | ~in_a[15:5]) & ~in_a[15:5])) & (in_g[15:5] & (in_a[15:5] | ~in_a[15:5]))) ^ (in_a[15:5] & (((in_a[15:5] | ~in_a[15:5]) & ~in_g[15:5]) | ((in_a[15:5] | ~in_a[15:5]) & ~in_a[15:5]))),(((~in_g[4:0] | in_g[4:0]) & in_g[4:0]) & (~in_a[4:0] | in_a[4:0])) ^ ((in_a[4:0] & (~in_g[4:0] | in_g[4:0])) & (~in_a[4:0] | in_a[4:0]))}};
  
  always @(posedge clk)
      begin
        if (cyc != 0) 
          begin
            cyc <= cyc+1;
            in_a <= cyc;
            in_b <= cyc+1;
            in_c <= cyc+3;
            in_d <= 8+cyc;
            in_e <= cyc;
            in_f <= cyc[15:0];
            if (out_x != (in_a & {2{in_f}})) 
              $stop;
              
            if (out_y != ((in_a & ((in_c & in_e) | (in_b & (in_a | (in_c & in_e))))) & in_b)) 
              $stop;
              
            if (out_z != (in_d & (in_c & in_e))) 
              $stop;
              
            if (out_o != (((in_a & ((in_c & in_e) | (in_b & (in_a | (in_c & in_e))))) & in_b) | (((in_a | in_c) & (in_c | (in_b & (in_a | (in_c & in_e))))) & (in_e & ((in_d | in_b) & (in_a | in_d)))))) 
              $stop;
              
            if (out_p != (((in_e & in_a) | (in_a & {2{in_f}})) | in_e)) 
              $stop;
              
            if (out_q != (((((in_a | ~in_a) & ~in_g) | (~in_a & (in_a | ~in_a))) & ((((in_a | ~in_a) & ~in_g) | (~in_a & (in_a | ~in_a))) & in_g)) ^ ((((in_a | ~in_a) & ~in_g) | (~in_a & (in_a | ~in_a))) & ((in_a | ~in_a) & ((((in_a | ~in_a) & ~in_g) | (~in_a & (in_a | ~in_a))) & in_a))))) 
              $stop;
              
            if (cyc == 100) 
              begin
                $write("*-* All Finished *-*\n");
                $finish;
              end
              
          end
          
      end
endmodule

