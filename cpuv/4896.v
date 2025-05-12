module autoconstant_gooch
  (
   out1, out2, out3,
   in1, in2, in3
   );
   input [3:0]  in1;
   input [3:0]  in2;
   input [3:0]  in3;
   output [3:0] out1;
   output [3:0] out2;
   output [3:0] out3;
   reg [3:0]    out1;
   reg [3:0]    out2;
   reg [3:0]    out3;
   always @(in1 or in2 or in3)
     begin
        case (in1)
          4'b0001 :     begin
             out1  = in2;
          end
          4'b0010 :     begin
             out1  = in2 + in3;
          end
          4'b0100 :     begin
             out1  = in2 - in3;
          end
          4'b1000 :     begin
             out1  = in2;
          end
          default       :       begin
             out1  = {4{1'b0}};
          end
        endcase
     end
   always @(in1 or in2 or in3)
     begin
        case (in1)
          4'b0001 :     begin
             out2  = in2;
          end
          4'b0010 :     begin
             out2  = in2 + in3;
          end
          4'b0100 :     begin
             out2  = in2 - in3;
          end
          4'b1000 :     begin
             out2  = in2;
          end
          default       :       begin
             out2  = {4{1'b0}};
          end
        endcase
     end
   always @(in1 or in2 or in3)
     begin
        out3   = in1 + in2;
        temp2  = temp;
        case (in1)
          4'b0001 :     begin
             out3  = in2;
          end
          4'b0010 :     begin
             out3  = in2 + in3;
          end
          4'b0100 :     begin
             out3  = in2 - in3;
          end
          4'b1000 :     begin
             out3  = in2;
          end
          default       :       begin
             out3  = {4{1'b0}};
          end
        endcase
     end
endmodule