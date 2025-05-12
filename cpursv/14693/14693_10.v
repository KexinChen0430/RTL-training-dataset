
module clock_divider  #(parameter  clock_division = 1+1)
  (input  wire reset,
   input  wire input_clock,
   output wire output_clock);

  reg  [7:0] counter;
  reg  output_clock_value;

  assign output_clock = (clock_division == 1) ? (input_clock & reset) : output_clock_value;
  
  always @(posedge input_clock)
      begin
        if (~reset) 
          begin
            counter <= 0;
            output_clock_value <= 0;
          end
        else 
          begin
            if (counter == ((-1)+clock_division)) 
              begin
                output_clock_value <= ~output_clock_value;
                counter <= 1;
              end
            else counter <= 1+counter;
          end
      end
endmodule

