
module tmu2_serialize  #(parameter  fml_depth = 26)
  (input  sys_clk,
   input  sys_rst,
   output reg busy,
   input  pipe_stb_i,
   output reg pipe_ack_o,
   input  [fml_depth+((-1)+(0-5)):0] tadra,
   input  [fml_depth+((-1)+(0-5)):0] tadrb,
   input  [fml_depth+((-1)+(0-5)):0] tadrc,
   input  [fml_depth+((-1)+(0-5)):0] tadrd,
   input  miss_a,
   input  miss_b,
   input  miss_c,
   input  miss_d,
   output reg pipe_stb_o,
   input  pipe_ack_i,
   output reg [fml_depth+((-1)+(0-5)):0] adr);

  reg  load_en;
  reg  [fml_depth+((-1)+(0-5)):0] r_tadra;
  reg  [fml_depth+((-1)+(0-5)):0] r_tadrb;
  reg  [fml_depth+((-1)+(0-5)):0] r_tadrc;
  reg  [fml_depth+((-1)+(0-5)):0] r_tadrd;
  reg  r_miss_a;
  reg  r_miss_b;
  reg  r_miss_c;
  reg  r_miss_d;

  
  always @(posedge sys_clk)
      begin
        if (load_en) 
          begin
            r_tadra <= tadra;
            r_tadrb <= tadrb;
            r_tadrc <= tadrc;
            r_tadrd <= tadrd;
            r_miss_a <= miss_a;
            r_miss_b <= miss_b;
            r_miss_c <= miss_c;
            r_miss_d <= miss_d;
          end
          
      end
  reg  [1:0] adr_sel;

  
  always @(*)
      begin
        case (adr_sel)

          2'd0: adr = r_tadra;

          2'd1: adr = r_tadrb;

          2'd2: adr = r_tadrc;

          default: adr = r_tadrd;

        endcase

      end
  reg  [3:0] missmask;

  reg  missmask_init;

  reg  missmask_we;

  
  always @(posedge sys_clk)
      begin
        if (missmask_init) missmask <= 4'b1111;
          
        if (missmask_we) 
          begin
            case (adr_sel)

              2'd0: missmask <= 4'b1110 & missmask;

              2'd1: missmask <= 4'b1101 & missmask;

              2'd2: missmask <= missmask & 4'b1011;

              default: missmask <= missmask & 4'b0111;

            endcase

          end
          
      end
  reg  state;

  reg  next_state;

  parameter  LOAD = 1'b0;

  parameter  SERIALIZE = 1'b1;

  
  always @(posedge sys_clk)
      begin
        if (sys_rst) state <= LOAD;
        else state <= next_state;
      end
  
  always @(*)
      begin
        next_state = state;
        busy = 1'b0;
        pipe_ack_o = 1'b0;
        pipe_stb_o = 1'b0;
        load_en = 1'b0;
        adr_sel = 2'd0;
        missmask_init = 1'b0;
        missmask_we = 1'b0;
        case (state)

          LOAD: begin
                pipe_ack_o = 1'b1;
                load_en = 1'b1;
                missmask_init = 1'b1;
                if (pipe_stb_i) next_state = SERIALIZE;
                  
              end

          SERIALIZE: begin
                pipe_stb_o = 1'b1;
                missmask_we = 1'b1;
                if (missmask[0] & r_miss_a) adr_sel = 2'd0;
                else if (r_miss_b & missmask[1]) adr_sel = 2'd1;
                else if (missmask[2] & r_miss_c) adr_sel = 2'd2;
                else if (r_miss_d & missmask[3]) adr_sel = 2'd3;
                else 
                  begin
                    pipe_stb_o = 1'b0;
                    next_state = LOAD;
                  end
                if (~pipe_ack_i) missmask_we = 1'b0;
                  
              end

        endcase

      end
endmodule

