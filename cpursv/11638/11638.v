
module FF_6(input  clock,
            input  reset,
            input  [1:0] io_input_0_data,
            input  io_input_0_reset,
            output [1:0] io_output_data);

  reg  [1:0] ff;
  reg  [31:0] _RAND_0;
  wire [1:0] _T_8;
  wire [1:0] _T_9;

  assign _T_8 = io_input_0_reset ? 2'h1 : io_input_0_data;
  assign _T_9 = io_input_0_reset ? 2'h1 : ff;
  assign io_output_data = _T_9;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            ff <= 2'h1;
          end
        else 
          begin
            if (io_input_0_reset) 
              begin
                ff <= 2'h1;
              end
            else 
              begin
                ff <= io_input_0_data;
              end
          end
      end
endmodule

