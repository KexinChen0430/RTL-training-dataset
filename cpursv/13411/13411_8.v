
module operation(Ain,Bin,addSubVals,andVals,notBVal,sub,computedValue,
                 overflow);

  parameter  width = 1;
  input  [width-1:0] Ain,Bin;
  input  addSubVals,andVals,notBVal,sub;
  output [width-1:0] computedValue;
  reg  [width-1:0] computedValue;
  output overflow;
  wire sign,lastNonSign;
  wire [width-1:0] holder;

  
  always @(*)
      begin
        case ({addSubVals,sub,andVals,notBVal})

          4'b1000: computedValue = Bin+Ain;

          4'b1100: computedValue = (0-Bin)+Ain;

          4'b0010: computedValue = Ain & Bin;

          4'b0001: computedValue = ~Bin;

          default: computedValue = {width{1'bx}};

        endcase

      end
  assign overflow = addSubVals ? ((sign | lastNonSign) & ((~sign & lastNonSign) | ~lastNonSign)) : 1'b0;
  assign {lastNonSign,holder[(-1<<1)+width:0]} = addSubVals ? ((sub+Ain[(-1<<1)+width:0])+((Bin[(-1<<1)+width:0] & (~{width-1{sub}} | ({width-1{sub}} & ~Bin[(-1<<1)+width:0]))) ^ ((~{width-1{sub}} & {width-1{sub}}) | ({width-1{sub}} & ~Bin[(-1<<1)+width:0])))) : {lastNonSign,holder[(-1<<1)+width:0]};
  assign {sign,holder[width-1]} = addSubVals ? ((((~Bin[width-1] & sub) | (sub & ~sub)) | (~sub & Bin[width-1]))+(Ain[width-1]+lastNonSign)) : {sign,computedValue[width-1]};
endmodule

