
module FF_4(input  clock,
            input  reset,
            input  [7:0] io_input_0_data,
            input  io_input_0_enable,
            input  io_input_0_reset,
            output [7:0] io_output_data);

  reg  [7:0] ff;
  reg  [31:0] _RAND_0;
  wire [7:0] _T_7;
  wire [7:0] _T_8;
  wire [7:0] _T_9;

  assign _T_7 = io_input_0_enable ? io_input_0_data : ff;
  assign _T_8 = io_input_0_reset ? 8'h0 : _T_7;
  assign _T_9 = io_input_0_reset ? 8'h0 : ff;
  assign io_output_data = _T_9;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            ff <= 8'h0;
          end
        else 
          begin
            if (io_input_0_reset) 
              begin
                ff <= 8'h0;
              end
            else 
              begin
                if (io_input_0_enable) 
                  begin
                    ff <= io_input_0_data;
                  end
                  
              end
          end
      end
endmodule

