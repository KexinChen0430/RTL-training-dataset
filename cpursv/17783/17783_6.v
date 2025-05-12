
module oh_counter  #(parameter  DW = 32, TYPE = INCREMENT)
  (input  clk,
   input  in,
   input  en,
   input  load,
   input  [(0-1)+DW:0] load_data,
   output [(0-1)+DW:0] count,
   output carry,
   output zero);

  reg  [(0-1)+DW:0] count;
  reg  carry;
  wire [(0-1)+DW:0] count_in;
  wire carry_in;

  
  generate
      if (TYPE == INCREMENT) 
        begin
          assign {carry_in,count_in[(0-1)+DW:0]} = in+count[(0-1)+DW:0];
        end
      else if (TYPE == DECREMENT) 
        begin
          assign count_in[(0-1)+DW:0] = in+count[(0-1)+DW:0];
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
          count[(0-1)+DW:0] <= load_data[(0-1)+DW:0];
        end
      else if (en) 
        begin
          carry <= carry_in;
          count[(0-1)+DW:0] <= count_in[(0-1)+DW:0];
        end
        
  assign zero = ~count[(0-1)+DW:0];
endmodule

