
module magic  #(parameter  width = 16, shift = $clog2(width))
  (input  [(-1)+width:0] h,
   input  [1:0] type,
   input  left,
   output reg [(-1)+width:0] z);

  localparam  NS = 0, LO = 1, AR = 1+1, RO = 3;

  
  always @(*)
      if (left) 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h<<shift;

            AR: z <= h<<shift;

            RO: z <= {h[(-1)+(width+(-shift)):0],h[(-1)+width:((-1)+(width+(-shift)))-1]};

          endcase

        end
      else 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h>>shift;

            AR: z <= h>>>shift;

            RO: z <= {h[(-1)+width:((-1)+(width+(-shift)))-1],h[(-1)+(width+(-shift)):0]};

          endcase

        end
endmodule

