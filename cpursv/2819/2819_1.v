
module FFD_POSEDGE_SYNCRONOUS_RESET  #(parameter  SIZE = 8)
  (input  wire Clock,
   input  wire Reset,
   input  wire Enable,
   input  wire [(0-1)+SIZE:0] D,
   output reg [(0-1)+SIZE:0] Q);

  
  always @(posedge Clock)
      begin
        if (Reset) Q <= 0;
        else 
          begin
            if (Enable) Q <= D;
              
          end
      end
endmodule

