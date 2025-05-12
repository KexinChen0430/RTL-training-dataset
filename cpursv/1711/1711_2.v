
module tmu2_vinterp(input  sys_clk,
                    input  sys_rst,
                    output busy,
                    input  pipe_stb_i,
                    output pipe_ack_o,
                    input  signed  [17:0] ax,
                    input  signed  [17:0] ay,
                    input  signed  [17:0] bx,
                    input  signed  [17:0] by,
                    input  diff_cx_positive,
                    input  [16:0] diff_cx_q,
                    input  [16:0] diff_cx_r,
                    input  diff_cy_positive,
                    input  [16:0] diff_cy_q,
                    input  [16:0] diff_cy_r,
                    input  diff_dx_positive,
                    input  [16:0] diff_dx_q,
                    input  [16:0] diff_dx_r,
                    input  diff_dy_positive,
                    input  [16:0] diff_dy_q,
                    input  [16:0] diff_dy_r,
                    input  signed  [11:0] drx,
                    input  signed  [11:0] dry,
                    input  [10:0] dst_squareh,
                    output pipe_stb_o,
                    input  pipe_ack_i,
                    output reg signed  [11:0] x,
                    output reg signed  [11:0] y,
                    output signed  [17:0] tsx,
                    output signed  [17:0] tsy,
                    output signed  [17:0] tex,
                    output signed  [17:0] tey);

  reg  load;
  reg  next_point;

  
  always @(posedge sys_clk)
      begin
        if (load) x <= drx;
          
      end
  tmu2_geninterp18 i_cx(.sys_clk(sys_clk),.load(load),
                        .next_point(next_point),.init(ax),.positive(diff_cx_positive),
                        .q(diff_cx_q),.r(diff_cx_r),.divisor({6'd0,dst_squareh}),
                        .o(tsx));
  tmu2_geninterp18 i_cy(.sys_clk(sys_clk),.load(load),
                        .next_point(next_point),.init(ay),.positive(diff_cy_positive),
                        .q(diff_cy_q),.r(diff_cy_r),.divisor({6'd0,dst_squareh}),
                        .o(tsy));
  tmu2_geninterp18 i_bx(.sys_clk(sys_clk),.load(load),
                        .next_point(next_point),.init(bx),.positive(diff_dx_positive),
                        .q(diff_dx_q),.r(diff_dx_r),.divisor({6'd0,dst_squareh}),
                        .o(tex));
  tmu2_geninterp18 i_by(.sys_clk(sys_clk),.load(load),
                        .next_point(next_point),.init(by),.positive(diff_dy_positive),
                        .q(diff_dy_q),.r(diff_dy_r),.divisor({6'd0,dst_squareh}),
                        .o(tey));
  
  always @(posedge sys_clk)
      begin
        if (load) y <= dry;
        else if (next_point) y <= 12'd1+y;
          
      end
  reg  [10:0] remaining_points;

  
  always @(posedge sys_clk)
      begin
        if (load) remaining_points <= dst_squareh-11'd1;
        else if (next_point) remaining_points <= remaining_points-11'd1;
          
      end
  wire  last_point = remaining_points == 11'd0;

  reg  state;

  reg  next_state;

  parameter  IDLE = 1'b0;

  parameter  BUSY = 1'b1;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) state <= IDLE;
        else state <= next_state;
      end
  assign busy = state;
  assign pipe_ack_o = ~state;
  assign pipe_stb_o = state;
  
  always @(*)
      begin
        next_state = state;
        load = 1'b0;
        next_point = 1'b0;
        case (state)

          IDLE: begin
                if (pipe_stb_i) 
                  begin
                    load = 1'b1;
                    next_state = BUSY;
                  end
                  
              end

          BUSY: begin
                if (pipe_ack_i) 
                  begin
                    if (last_point) next_state = IDLE;
                    else next_point = 1'b1;
                  end
                  
              end

        endcase

      end
endmodule

