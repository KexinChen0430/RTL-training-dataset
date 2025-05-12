
module UPCOUNTER_POSEDGE  #(parameter  SIZE = 16)
  (input  wire Clock,
   input  wire Reset,
   input  wire [SIZE+(0-1):0] Initial,
   input  wire Enable,
   output reg [SIZE+(0-1):0] Q);

  
  always @(posedge Clock)
      begin
        if (Reset) Q = Initial;
        else 
          begin
            if (Enable) Q = 1+Q;
              
          end
      end
endmodule

