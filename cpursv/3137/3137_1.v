
module buffer(input  wire [3:0] buff_in,
              input  wire buff_in_valid,
              output reg buff_out,
              output reg buff_out_valid,
              output wire buffer_full,
              input  wire CLK,
              input  wire Reset);

  reg  [31:0] buffer_array;
  reg  [31:0] sp;

  assign buffer_full = sp[29];
  
  always @(posedge CLK or negedge Reset)
      begin
        if (~Reset) 
          begin
            buffer_array <= 32'b0;
          end
        else 
          begin

          end
      end
  
  always @(posedge CLK or negedge Reset)
      begin
        if (~Reset) 
          begin
            buff_out <= 0;
            buff_out_valid <= 0;
          end
        else 
          begin

          end
      end
  
  always @(posedge CLK or negedge Reset)
      begin
        if (~Reset) 
          begin
            sp <= 32'b0;
          end
        else 
          begin

          end
      end
endmodule

