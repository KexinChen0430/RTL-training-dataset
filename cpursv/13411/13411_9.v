
module operation(Ain,Bin,addSubVals,andVals,notBVal,sub,computedValue,
                 overflow);

  parameter  width = 1;
  input  [(-1)+width:0] Ain,Bin;
  input  addSubVals,andVals,notBVal,sub;
  output [(-1)+width:0] computedValue;
  reg  [(-1)+width:0] computedValue;
  output overflow;
  wire sign,lastNonSign;
  wire [(-1)+width:0] holder;

  
  always @(*)
      begin
        case ({addSubVals,sub,andVals,notBVal})

          4'b1000: computedValue = Ain+Bin;

          4'b1100: computedValue = (0-Bin)+Ain;

          4'b0010: computedValue = Bin & Ain;

          4'b0001: computedValue = ~Bin;

          default: computedValue = {width{1'bx}};

        endcase

      end
  assign overflow = addSubVals ? ((sign & ~lastNonSign) | ((~sign & (~lastNonSign | lastNonSign)) & (lastNonSign | (sign & ~lastNonSign)))) : 1'b0;
  assign {lastNonSign,holder[(0-1<<1)+width:0]} = addSubVals ? ((Ain[(0-1<<1)+width:0]+(((({(-1)+width{sub}} & ((~{(-1)+width{sub}} | (({(-1)+width{sub}} | ~{(-1)+width{sub}}) & ~Bin[(0-1<<1)+width:0])) | Bin[(0-1<<1)+width:0])) | Bin[(0-1<<1)+width:0]) & ~Bin[(0-1<<1)+width:0]) | ((Bin[(0-1<<1)+width:0] & ~{(-1)+width{sub}}) | (~{(-1)+width{sub}} & ({(-1)+width{sub}} & ~Bin[(0-1<<1)+width:0])))))+sub) : {lastNonSign,holder[(0-1<<1)+width:0]};
  assign {sign,holder[(-1)+width]} = addSubVals ? ((((~Bin[(-1)+width] & sub) | ((((~Bin[(-1)+width] & sub) | ~sub) & Bin[(-1)+width]) & ((sub | ((~sub | sub) & Bin[(-1)+width])) & ~sub)))+lastNonSign)+Ain[(-1)+width]) : {sign,computedValue[(-1)+width]};
endmodule

