
module magic  #(parameter  width = 16, shift = $clog2(width))
  (input  [width+(-1):0] h,
   input  [1:0] type,
   input  left,
   output reg [width+(-1):0] z);

  localparam  NS = 0, LO = 1, AR = 1<<1, RO = 3;

  
  always @(*)
      if (left) 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h<<<shift;

            AR: z <= h<<<shift;

            RO: z <= {h[((-1)+(0-shift))+width:0],h[width+(-1):(((-1)+(0-shift))+(-1))+width]};

          endcase

        end
      else 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h>>shift;

            AR: z <= h>>>shift;

            RO: z <= {h[width+(-1):(((-1)+(0-shift))+(-1))+width],h[((-1)+(0-shift))+width:0]};

          endcase

        end
endmodule

