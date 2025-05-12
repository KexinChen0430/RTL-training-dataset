
module NormaliseAdder(input  idle_AddState,
                      input  [31:0] sout_AddState,
                      input  [27:0] sum_AddState,
                      input  clock,
                      output reg idle_NormaliseSum,
                      output reg [31:0] sout_NormaliseSum,
                      output reg [27:0] sum_NormaliseSum);

  parameter  no_idle = 1'b0, put_idle = 1'b1;
  wire [7:0] s_exponent;

  assign s_exponent = sout_AddState[30:23];
  
  always @(posedge clock)
      begin
        idle_NormaliseSum <= idle_AddState;
        if (idle_AddState != put_idle) 
          begin
            sout_NormaliseSum[31] <= sout_AddState[31];
            sout_NormaliseSum[22:0] <= sout_AddState[22:0];
            if (sum_AddState[27] == 1'b1) 
              begin
                sout_NormaliseSum[30:23] <= s_exponent+1;
                sum_NormaliseSum <= sum_AddState>>1;
              end
            else if (sum_AddState[26:3] == 24'h000000) 
              begin
                sout_NormaliseSum[30:23] <= 10'h382;
              end
            else if (sum_AddState[26:4] == 23'h000000) 
              begin
                sout_NormaliseSum[30:23] <= s_exponent-23;
                sum_NormaliseSum <= sum_AddState*(1<<<1**23);
              end
            else 
              begin
                sout_NormaliseSum[30:23] <= s_exponent;
                sum_NormaliseSum <= sum_AddState;
              end
          end
        else 
          begin
            sout_NormaliseSum <= sout_AddState;
            sum_NormaliseSum <= 0;
          end
      end
endmodule

