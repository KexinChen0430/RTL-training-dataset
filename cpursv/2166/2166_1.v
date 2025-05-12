
module magic  #(parameter  width = 16, shift = $clog2(width))
  (input  [(0-1)+width:0] h,
   input  [1:0] type,
   input  left,
   output reg [(0-1)+width:0] z);

  localparam  NS = 0, LO = 1, AR = 1+1, RO = 3;

  
  always @(*)
      if (left) 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h*((1+1)**shift);

            AR: z <= h*((1+1)**shift);

            RO: z <= {h[((-shift)+(0-1))+width:0],h[(0-1)+width:(((-shift)+(0-1))+width)+(0-1)]};

          endcase

        end
      else 
        begin
          case (type)

            NS: z <= h;

            LO: z <= h>>shift;

            AR: z <= h>>>shift;

            RO: z <= {h[(0-1)+width:(((-shift)+(0-1))+width)+(0-1)],h[((-shift)+(0-1))+width:0]};

          endcase

        end
endmodule

