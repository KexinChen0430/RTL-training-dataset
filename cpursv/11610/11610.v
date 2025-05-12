
module SRFF_sp(input  clock,
               input  reset,
               input  io_input_set,
               input  io_input_reset,
               input  io_input_asyn_reset,
               output io_output_data);

  reg  _T_8;
  reg  [31:0] _RAND_0;
  wire _T_12;
  wire _T_13;
  wire _T_14;
  wire _T_16;

  assign _T_12 = io_input_reset ? 1'h0 : _T_8;
  assign _T_13 = io_input_set ? 1'h1 : _T_12;
  assign _T_14 = io_input_asyn_reset ? 1'h0 : _T_13;
  assign _T_16 = io_input_asyn_reset ? 1'h0 : _T_8;
  assign io_output_data = _T_16;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            _T_8 <= 1'h0;
          end
        else 
          begin
            if (io_input_asyn_reset) 
              begin
                _T_8 <= 1'h0;
              end
            else 
              begin
                if (io_input_set) 
                  begin
                    _T_8 <= 1'h1;
                  end
                else 
                  begin
                    if (io_input_reset) 
                      begin
                        _T_8 <= 1'h0;
                      end
                      
                  end
              end
          end
      end
endmodule

