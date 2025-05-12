
module FullAdderViaHAs;

  reg   x1 = 0;
  reg   x2 = 0;
  wire s;
  wire c;
  wire [7:0] x1TVals;
  wire [7:0] x2TVals;
  reg   cin = 0;
  wire [7:0] cinTVals;
  wire FullAdderViaHAs0_0_s_HA1HA2;
  wire FullAdderViaHAs0_0_c_HA1CL;
  wire FullAdderViaHAs0_0_c_HA2CL;

  assign x1TVals = 8'd15;
  assign x2TVals = 8'd51;
  assign cinTVals = 8'd85;
  
  always @(x2 or c or s or cin or x1)
      begin : FULLADDERVIAHAS_TBV_PRINT_DATA
        $write("%h",x1);
        $write(" ");
        $write("%h",x2);
        $write(" ");
        $write("%h",cin);
        $write(" ");
        $write("%h",s);
        $write(" ");
        $write("%h",c);
        $write(\n);
      end
  assign FullAdderViaHAs0_0_s_HA1HA2 = (~(((((((x2 & (((~x2 | x2) & x1) & x2)) ^ x2) & ~x1) ^ ((x1 & (x2 ^ (x2 & x1))) & ~x1)) | (~x1 & ((~x2 | x2) & x1))) | (~x1 | (x2 | x1))) & x2) & (((((((x2 & (((~x2 | x2) & x1) & x2)) ^ x2) & ~x1) ^ ((x1 & (x2 ^ (x2 & x1))) & ~x1)) | (~x1 & ((~x2 | x2) & x1))) | (~x1 | (x2 | x1))) & ((~x2 | x2) & x1))) | (~(((((((x2 & (((~x2 | x2) & x1) & x2)) ^ x2) & ~x1) ^ ((x1 & (x2 ^ (x2 & x1))) & ~x1)) | (~x1 & ((~x2 | x2) & x1))) | (~x1 | (x2 | x1))) & ((~x2 | x2) & x1)) & (((((((x2 & (((~x2 | x2) & x1) & x2)) ^ x2) & ~x1) ^ ((x1 & (x2 ^ (x2 & x1))) & ~x1)) | (~x1 & ((~x2 | x2) & x1))) | (~x1 | (x2 | x1))) & x2));
  assign FullAdderViaHAs0_0_c_HA1CL = x2 & x1;
  assign s = (cin | FullAdderViaHAs0_0_s_HA1HA2) & (~cin | ((cin | FullAdderViaHAs0_0_s_HA1HA2) & ~FullAdderViaHAs0_0_s_HA1HA2));
  assign FullAdderViaHAs0_0_c_HA2CL = FullAdderViaHAs0_0_s_HA1HA2 & cin;
  assign c = FullAdderViaHAs0_0_c_HA1CL | FullAdderViaHAs0_0_c_HA2CL;
  
  initial  
  begin : FULLADDERVIAHAS_TBV_STIMULES
    integer i;

    for (i = 0; i < 8; i = 1+i)
        begin
          x1 <= x1TVals[i];
          x2 <= x2TVals[i];
          cin <= cinTVals[i];
          #1 ;
        end
    $finish;
  end
endmodule

