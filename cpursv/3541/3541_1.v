
module NormaliseAdderProcess(input  [31:0] z_postAddState,
                             input  [3:0] Opcode_AddState,
                             input  idle_AddState,
                             input  [31:0] sout_AddState,
                             input  [27:0] sum_AddState,
                             input  [7:0] InsTagAdder,
                             input  clock,
                             output reg idle_NormaliseSum,
                             output reg [31:0] sout_NormaliseSum,
                             output reg [27:0] sum_NormaliseSum,
                             output reg [3:0] Opcode_NormaliseSum,
                             output reg [31:0] z_postNormaliseSum,
                             output reg [7:0] InsTagNormaliseAdder);

  parameter  no_idle = 1'b0, put_idle = 1'b1;
  wire [7:0] s_exponent;

  assign s_exponent = sout_AddState[30:23];
  parameter 
       sin_cos    = 4'd0,
       sinh_cosh  = 4'd1,
       arctan     = 4'd2,
       arctanh    = 4'd3,
       exp        = 4'd4,
       sqr_root   = 4'd5,
       division   = 4'd6,
       tan        = 4'd7,
       tanh       = 4'd8,
       nat_log    = 4'd9,
       hypotenuse = 4'd10,
       PreProcess = 4'd11;

  
  always @(posedge clock)
      begin
        InsTagNormaliseAdder <= InsTagAdder;
        z_postNormaliseSum <= z_postAddState;
        Opcode_NormaliseSum <= Opcode_AddState;
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

