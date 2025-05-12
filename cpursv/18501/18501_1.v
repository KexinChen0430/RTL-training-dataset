
module MUX  #(parameter  SIZE = 32)
  (input  wire Select,
   input  wire [(0-1)+SIZE:0] Data_B,
   input  wire [(0-1)+SIZE:0] Data_A,
   output reg [(0-1)+SIZE:0] Out);

  
  always @(*)
      begin
        if (Select == 1) Out <= Data_A;
        else if (Select == 0) Out <= Data_B;
          
      end
endmodule

