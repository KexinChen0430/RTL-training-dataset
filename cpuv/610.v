module UDCounter(
    clock,      
    reset,      
    count,      
    direction,  
    data_o      
);
   parameter Size = 8;
   input wire [0] clock;      
   input wire [0] reset;      
   input wire [0] count;      
   input wire [0] direction;  
   output reg [(Size) - ('b1):0] data_o;
   always @ (posedge clock) begin
      if (reset) begin
         data_o <= {Size{1'b0}};
      end
      else begin
         if (count) begin
            case (direction)
              'b0: data_o <= data_o + 1;
              'b1: data_o <= data_o - 1;
            endcase
         end
      end
   end
endmodule