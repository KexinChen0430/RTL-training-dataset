
module oh_counter  #(parameter  DW = 32, TYPE = INCREMENT)
  (input  clk,
   input  in,
   input  en,
   input  load,
   input  [DW+(-1):0] load_data,
   output [DW+(-1):0] count,
   output carry,
   output zero);

  reg  [DW+(-1):0] count;
  reg  carry;
  wire [DW+(-1):0] count_in;
  wire carry_in;

  
  generate
      if (TYPE == INCREMENT) 
        begin
          assign {carry_in,count_in[DW+(-1):0]} = in+count[DW+(-1):0];
        end
      else if (TYPE == DECREMENT) 
        begin
          assign count_in[DW+(-1):0] = in+count[DW+(-1):0];
        end
      else if (TYPE == GRAY) 
        begin
          
          initial            $display("NOT IMPLEMENTED");
        end
      else if (TYPE == LFSR) 
        begin
          
          initial            $display("NOT IMPLEMENTED");
        end
        
  endgenerate

  
  always @(posedge clk)
      if (load) 
        begin
          carry <= 1'b0;
          count[DW+(-1):0] <= load_data[DW+(-1):0];
        end
      else if (en) 
        begin
          carry <= carry_in;
          count[DW+(-1):0] <= count_in[DW+(-1):0];
        end
        
  assign zero = ~count[DW+(-1):0];
endmodule

