
module chacha20_poly1305_p1305(input  wire clk,
                               input  wire reset_n,
                               input  wire init,
                               input  wire next,
                               input  wire done,
                               input  wire [255:0] key,
                               output wire [127:0] tag);

  localparam  R_CLAMP = 128'h0ffffffc0ffffffc0ffffffc0fffffff;
  localparam  POLY1305 = 129'h3fffffffffffffffffffffffffffffffb;
  reg  [127:0] r_reg;
  reg  [127:0] r_new;
  reg  r_we;
  reg  [127:0] s_reg;
  reg  [127:0] s_new;
  reg  s_we;
  reg  [255:0] acc_reg;
  reg  [255:0] acc_new;
  reg  acc_we;
  reg  [2:0] p1305_ctrl_reg;
  reg  [2:0] p1305_ctrl_new;
  reg  p1305_ctrl_we;

  
  always @(posedge clk)
      begin
        if (!reset_n) 
          begin
            r_reg <= 128'h0;
            s_reg <= 128'h0;
            acc_reg <= 256'h0;
            p1305_ctrl_reg <= CTRL_IDLE;
          end
        else 
          begin
            if (r_we) r_reg <= r_new;
              
            if (s_we) s_reg <= s_new;
              
            if (acc_we) acc_reg <= acc_new;
              
            if (p1305_ctrl_we) p1305_ctrl_reg <= p1305_ctrl_new;
              
          end
      end
  
  always @* 
      begin : poly1305_dp
        reg  [512:0] block;

        acc_new = 256'h0;
        acc_we = 0;
        r_new = data_out[255:128] & R_CLAMP;
        r_we = 0;
        s_new = data_out[127:0];
        s_we = 0;
        if (poly1305_init) 
          begin
            r_we = 1;
            s_we = 1;
            acc_we = 1;
          end
          
        if (poly1305_next) 
          begin
            if (encdec) block = {1'h1,data_out};
            else block = {1'h1,data_in};
            acc_new = (((((((((((((((((((((((((((((((acc_reg%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)+(((((((((((((((((block%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305))%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)*((((((((((((r_reg%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305)%POLY1305))%POLY1305;
            acc_we = 1;
          end
          
      end
  
  always @* 
      begin : p1305_ctrl
        p1305_ctrl_new = CTRL_IDLE;
        p1305_ctrl_we = 0;
        case (p1305_ctrl_reg)

          CTRL_IDLE: begin

              end

          default: begin

              end

        endcase

      end
endmodule

