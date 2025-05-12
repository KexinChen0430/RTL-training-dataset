
module quad(clk,A,B,Z,zr,out);

  parameter  W = 14;
  input  clk,A,B,Z,zr;
  reg  [W-1:0] c,i;
  reg  zl;
  output [W<<1:0]  out = {zl,i,c};
  reg  [2:0] Ad,Bd;
  reg  [2:0] Zc;

  
  always @(posedge clk)  Ad <= {Ad[1:0],A};
  
  always @(posedge clk)  Bd <= {Bd[1:0],B};
  wire  good_one = &Zc;

  wire  good_zero = ~|Zc;

  reg  last_good;

  wire  index_pulse = !last_good && good_one;

  wire 
       count_enable = ((Bd[2] & ((((~(Bd[1] & ~Bd[2]) & ~Bd[2]) & Ad[2]) ^ ((~(Bd[1] & ~Bd[2]) & ~Bd[2]) & Ad[1])) | ~(((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))))) | (Bd[2] & (~(((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & ~Bd[2]) & (Bd[1] & ~Bd[2])))) ^ ((((~(((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))) | ((Ad[1] | ~Ad[1]) | ~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])))) & (~Bd[2] & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]))) | ((~(((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))) | ((Ad[1] | ~Ad[1]) | ~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])))) & ((~(((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))) | (((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & ~Bd[2])) & (~Bd[1] | ~(((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))))))) & (((~Bd[1] & Ad[1]) & ~(~Bd[1] & Ad[2])) | (((~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) & Bd[1]) | (Ad[2] & ~(~Bd[1] & Ad[1]))) & (~((~Ad[1] & Ad[2]) | (Ad[1] & ~Ad[2])) | ~Bd[1]))));

  wire 
       count_direction = ((~Ad[1] & Bd[2]) | (Bd[2] & (((((Ad[1] | Bd[2]) & Bd[2]) | ((Ad[1] | Bd[2]) & ~Bd[2])) & ~Bd[2]) & Ad[1]))) | (((((Ad[1] | Bd[2]) & Bd[2]) | ((Ad[1] | Bd[2]) & ~Bd[2])) & ~Bd[2]) & Ad[1]);

  
  always @(posedge clk)
      begin
        if (!good_one && Z) Zc <= 2'b1+Zc;
        else if (!good_zero) Zc <= Zc+(-2'b1);
          
        if (good_one) last_good <= 1;
        else if (good_zero) last_good <= 0;
          
        if (count_enable) 
          begin
            if (count_direction) c <= 1'd1+c;
            else c <= c-1'd1;
          end
          
        if (index_pulse) 
          begin
            i <= c;
            zl <= 1;
          end
        else if (zr) 
          begin
            zl <= 0;
          end
          
      end
endmodule

