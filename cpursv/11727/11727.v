
module SRFF_sp(input  clock,
               input  reset,
               input  io_input_set,
               input  io_input_reset,
               input  io_input_asyn_reset,
               output io_output_data);

  reg  _T_14;
  reg  [31:0] _GEN_0;
  wire _T_18;
  wire _T_19;
  wire _T_20;
  wire _T_22;

  assign io_output_data = _T_22;
  assign _T_18 = io_input_reset ? 1'h0 : _T_14;
  assign _T_19 = io_input_set ? 1'h1 : _T_18;
  assign _T_20 = io_input_asyn_reset ? 1'h0 : _T_19;
  assign _T_22 = io_input_asyn_reset ? 1'h0 : _T_14;
  
  always @(posedge clock)
      begin
        if (reset) 
          begin
            _T_14 <= 1'h0;
          end
        else 
          begin
            if (io_input_asyn_reset) 
              begin
                _T_14 <= 1'h0;
              end
            else 
              begin
                if (io_input_set) 
                  begin
                    _T_14 <= 1'h1;
                  end
                else 
                  begin
                    if (io_input_reset) 
                      begin
                        _T_14 <= 1'h0;
                      end
                      
                  end
              end
          end
      end
endmodule

