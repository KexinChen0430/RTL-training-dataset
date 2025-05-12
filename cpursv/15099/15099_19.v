
module clock_divider(input  wire clk,
                     input  wire res,
                     input  wire [1:0] prescaler,
                     output wire clk_out);

  reg  clk_div;
  reg  [((1+1)**16)+(0-1):0] counter;
  reg  [((1+1)**16)+(0-1):0] counter2;

  assign clk_out = clk_div;
  
  always @(prescaler or clk or counter or counter2)
      begin
        case (prescaler)

          2'b00: clk_div = clk;

          2'b01: clk_div = counter[0];

          2'b10: clk_div = counter[((1+1)**16)+(0-1)];

          2'b11: clk_div = counter2[((1+1)**8)+(0-1)];

        endcase

      end
  
  always @(posedge clk)
      begin
        if (res) 
          begin
            counter <= {((1+1)**22)+(0-1){1'b0}};
            counter2 <= {((1+1)**22)+(0-1){1'b0}};
          end
        else counter <= 1'b1+counter;
      end
  
  always @(counter[((1+1)**16)+(0-1):((1+1)**16)+(0-1)])  counter2 <= counter2+1'b1;
endmodule

