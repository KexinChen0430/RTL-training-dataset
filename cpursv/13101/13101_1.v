
module UPCOUNTER_POSEDGE(input  wire Clock,Reset,
                         input  wire [9:0] Initial,
                         input  wire Enable,
                         output reg [9:0] Q);

  
  always @(posedge Clock)
      begin
        if (Reset) Q <= Initial;
        else 
          begin
            if (Enable) Q <= 1+Q;
              
          end
      end
endmodule

