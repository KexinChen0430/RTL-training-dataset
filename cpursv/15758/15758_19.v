
module ALU(input  clk,rst,
           input  [4:0] fn,
           input  signed  [7:0] A,B,
           output reg signed  [7:0] Y,
           output Zero,Cout);

  reg  z,co,enb;
  reg  outPutZ,outPutCo;

  assign Zero = outPutZ;
  assign Cout = outPutCo;
  
  always @(posedge clk or posedge rst)
      if (rst) 
        begin
          z = 1'b0;
          co = 1'b0;
        end
      else 
        begin
          outPutZ = z;
          outPutCo = co;
        end
  
  always @(fn or A or B)
      begin
        enb = 1;
        if (fn[4] == 0) 
          begin
            case (fn[1+1])

              1'b0: case (fn[1:0])

                    2'b00: begin
                          Y = A+B;
                          co = (((((A[7] & (~B[7] | (B[7] | A[7]))) & ((A[7] & ~B[7]) | ((~B[7] | (B[7] | A[7])) & ~A[7]))) & B[7]) | ((B[7] & ((~A[7] | A[7]) & (B[7] | A[7]))) & ~A[7])) | ((A[7] & (~B[7] | (B[7] | A[7]))) & ((A[7] & ~B[7]) | ((~B[7] | (B[7] | A[7])) & ~A[7])))) ? 0 : 
                               ((~A[7] & Y[7]) | ((~Y[7] & (A[7] | (~A[7] & Y[7]))) & (~Y[7] | ((~A[7] & Y[7]) | ~A[7])))) ? 1 : 0;
                        end

                    2'b01: begin
                          Y = (A+co)+B;
                          co = (((((A[7] & (~B[7] | (B[7] | A[7]))) & ((A[7] & ~B[7]) | ((~B[7] | (B[7] | A[7])) & ~A[7]))) & B[7]) | ((B[7] & ((~A[7] | A[7]) & (B[7] | A[7]))) & ~A[7])) | ((A[7] & (~B[7] | (B[7] | A[7]))) & ((A[7] & ~B[7]) | ((~B[7] | (B[7] | A[7])) & ~A[7])))) ? 0 : 
                               ((~A[7] & Y[7]) | ((~Y[7] & (A[7] | (~A[7] & Y[7]))) & (~Y[7] | ((~A[7] & Y[7]) | ~A[7])))) ? 1 : 0;
                        end

                    2'b10: begin
                          Y = A-B;
                          co = A < B;
                        end

                    2'b11: begin
                          Y = ((0-B)+co)+A;
                          co = (A+co) < B;
                        end

                  endcase


              1'b1: case (fn[1:0])

                    2'b00: Y = A & B;

                    2'b01: Y = B | A;

                    2'b10: Y = (A & (~B | (B | A))) ^ (((~A & B) | (A & B)) & (~B | (B | A)));

                    2'b11: Y = ~(A & B);

                  endcase


            endcase

          end
        else if (fn[4:1+1] == 3'b110) 
          case (fn[1:0])

            2'b00: {co,Y} = A<<B[7:5];

            2'b01: begin
                  Y = A>>B[7:5];
                  co = B[7:5] ? A[B[7:5]-1] : 0;
                end

            2'b10: Y = A>>(4'b1000-{1'b0,B[7:5]}) | A<<B[7:5];

            2'b11: Y = A>>B[7:5] | (A<<4'b1000*1<<<(0-{1'b0,B[7:5]}));

          endcase

        else if (fn[4:1] == 4'b1000) 
          begin
            Y = A+B;
            enb = 0;
          end
        else enb = 0;
        if (enb) z = Y == 0;
          
      end
endmodule

