module top_module (input [3:0] in1, in2, in3, in4, in5, output [2:0] out1, out2, out3, out4, out5, out8, output outb2, outb3, outb4, outb6, outb7, output [7:0] outw1, outw2, outw3);
   reg [2:0]    out1;
   reg [2:0]    out2;
   reg [2:0]    out3;
   reg [2:0]    out4;
   reg [2:0]    out5;
   reg [2:0]    out8;
   reg          outb2;
   reg          outb3;
   reg          outb4;
   reg          outb6;
   reg          outb7;
   reg [7:0]    outw1;
   reg [7:0]    outw2;
   reg [7:0]    outw3;
   wire         outb8=1'b1, outb9=|{in1[0],in2[0]}, outb10=1'b0;
   always @(in1 or in2 or in3 or in4) begin
      :ignore_label
      out1  = $realtobits(in1); 
      out2  = ffs(in1 | (in2) ); 
      out3  = ffs  (in2); 
      $display ("chk ", in1); 
      show (in4); 
      if (|in3) out4=1; else out4=0; 
   end
   always @ (in1 or in2 or in3 or in5) begin
      casex ({in5[1:0], (3'b010==in2)})
        3'bx_1_0: out5=3'b000;
        3'bx_1_1: out5=3'b010;
        3'bx_0_x: out5=3'b100;
      endcase
      casex ({in3[in1]})
        1'bx: out5=3'b000;
      endcase
   end
`define temp 3'b010
   always @(in3) begin
      outb6  = (in3 == `temp); 
   end
   integer   i;
   reg [2:0] out7;
   always @ (in1) begin
      for (i=0; i<3; i=i+1) begin
         assign out7[i]  = ~in1[i]; 
      end
   end
   always @ (in1 or in2 or in3) begin
      {outw1 [ffs(in1)], outw2 [ffs(in2)]}  = 2'b10;
      {outw3[(|in1)?in2:in3], outb2}        = 2'b10;
   end
   initial memarry[0]  = in2;
   always @ (in1) begin
      $display (memarry[in1]); 
   end
   always @(in1 or in2)
     casex(in1[1:0]) 
       2'b01 :  out8  = 3'b001;
       2'b10 :  out8  = 3'b010;
       default
         out8  = in2;
     endcase
   parameter READ  = 3'b111,
     CFG  = 3'b010;
   always @(in1 or in2) begin
      outb7  = (in1==READ) || (in2==CFG); 
   end
   always @(in1) begin
      if (|in1) $display("We're at %t\n",$time); 
   end 
`define shift_instr 5'b01011
   always @(in1 or in2 or in3 or in4 or in5 or outw1)
     begin: label_no_sense
        casex (outw1) 
          {`shift_instr,3'bxxx}:
            outb3             = in3[0];
          8'b00001x10: outb3  = in4[0];
          8'b00110011:
            if (in5[0])
              outb3  = in1[0];
            else
              outb3  = in2[1];
          default
            outb3  = in4[0];
        endcase
     end
   parameter WIDLE  = 0;                
   always @ (in1 or in2 or in3 or in4) begin
      case(1'b1)
        in2[WIDLE]:
          outb4  = in1[0];
        in3[in4]:
          outb4  = in1[0];
        default:
          outb4  = 1'bx;
      endcase
   end
endmodule