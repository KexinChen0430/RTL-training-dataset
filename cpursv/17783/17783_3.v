
module oh_counter  #(parameter  DW = 32, TYPE = INCREMENT)
  (input  clk,
   input  in,
   input  en,
   input  load,
   input  [(-1)+DW:0] load_data,
   output [(-1)+DW:0] count,
   output carry,
   output zero);

  reg  [(-1)+DW:0] count;
  reg  carry;
  wire [(-1)+DW:0] count_in;
  wire carry_in;

  
  generate
      if (TYPE == INCREMENT) 
        begin
          assign {carry_in,count_in[(-1)+DW:0]} = count[(-1)+DW:0]+in;
        end
      else if (TYPE == DECREMENT) 
        begin
          assign count_in[(-1)+DW:0] = count[(-1)+DW:0]+in;
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
          count[(-1)+DW:0] <= load_data[(-1)+DW:0];
        end
      else if (en) 
        begin
          carry <= carry_in;
          count[(-1)+DW:0] <= count_in[(-1)+DW:0];
        end
        
  assign zero = ~count[(-1)+DW:0];
endmodule

