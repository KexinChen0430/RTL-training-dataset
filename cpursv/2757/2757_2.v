
module UPCOUNTER_POSEDGE  #(parameter  SIZE = 16)
  (input  wire Clock,
   input  wire Reset,
   input  wire [(-1)+SIZE:0] Initial,
   input  wire Enable,
   output reg [(-1)+SIZE:0] Q);

  
  always @(posedge Clock)
      begin
        if (Reset) Q = Initial;
        else 
          begin
            if (Enable) Q = Q+1;
              
          end
      end
endmodule

