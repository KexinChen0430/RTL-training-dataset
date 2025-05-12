
module jt12_pg_sum(input  [3:0] mul,
                   input  [19:0] phase_in,
                   input  pg_rst,
                   input  signed  [5:0] detune_signed,
                   input  [16:0] phinc_pure,
                   output reg [19:0] phase_out,
                   output reg [9:0] phase_op);

  reg  [16:0] phinc_premul;
  reg  [19:0] phinc_mul;

  
  always @(*)
      begin
        phinc_premul = {{11{detune_signed[5]}},detune_signed}+phinc_pure;
        phinc_mul = (mul == 4'd0) ? {4'b0,phinc_premul[16:1]} : (mul*{3'd0,phinc_premul});
        phase_out = pg_rst ? 20'd0 : ({phinc_mul}+phase_in);
        phase_op = phase_out[19:10];
      end
endmodule

