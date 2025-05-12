
module zclock(input  fclk,
              input  rst_n,
              input  zclk,
              input  rfsh_n,
              output reg zclk_out,
              output reg zpos,
              output reg zneg,
              input  wire zclk_stall,
              input  [1:0] turbo,
              output reg [1:0] int_turbo,
              input  wire external_port,
              input  wire iorq_n,
              input  wire m1_n,
              input  cbeg,
              input  pre_cend);

  reg  precend_cnt;
  wire h_precend_1;
  wire h_precend_2;
  reg  [2:0] zcount;
  reg  old_rfsh_n;
  wire stall;
  reg  clk14_src;
  wire pre_zpos_35,pre_zneg_35;
  wire pre_zpos_70,pre_zneg_70;
  wire pre_zpos_140,pre_zneg_140;

  
  always @(posedge fclk)
      if (zpos) 
        begin
          old_rfsh_n <= rfsh_n;
          if (old_rfsh_n && !rfsh_n) int_turbo <= turbo;
            
        end
        
  reg  [3:0] io_wait_cnt;

  reg  io_wait;

  wire io;

  reg  io_r;

  assign io = ~iorq_n & (external_port & m1_n);
  
  always @(posedge fclk)  if (zpos) io_r <= io;
    
  
  always @(posedge fclk or negedge rst_n)
      if (~rst_n) io_wait_cnt <= 4'd0;
      else if (!io_r && (int_turbo[1] && zpos && io)) io_wait_cnt[3] <= 1'b1;
      else if (io_wait_cnt[3]) io_wait_cnt <= 4'd1+io_wait_cnt;
        
  
  always @(posedge fclk)
      case (io_wait_cnt)

        4'b1000: io_wait <= 1'b1;

        4'b1001: io_wait <= 1'b1;

        4'b1010: io_wait <= 1'b1;

        4'b1011: io_wait <= 1'b1;

        4'b1100: io_wait <= 1'b1;

        4'b1101: io_wait <= 1'b0;

        4'b1110: io_wait <= 1'b1;

        4'b1111: io_wait <= 1'b0;

        default: io_wait <= 1'b0;

      endcase

  assign stall = zclk_stall | io_wait;
  
  always @(posedge fclk)
      if (!stall) clk14_src <= ~clk14_src;
        
  assign pre_zpos_140 = clk14_src;
  assign pre_zneg_140 = ~clk14_src;
  
  always @(posedge fclk)
      if (pre_cend) precend_cnt <= ~precend_cnt;
        
  assign h_precend_1 = pre_cend && precend_cnt;
  assign h_precend_2 = !precend_cnt && pre_cend;
  assign pre_zpos_35 = h_precend_2;
  assign pre_zneg_35 = h_precend_1;
  assign pre_zpos_70 = pre_cend;
  assign pre_zneg_70 = cbeg;
  assign pre_zpos = int_turbo[1] ? pre_zpos_140 : 
                    int_turbo[0] ? pre_zpos_70 : pre_zpos_35;
  assign pre_zneg = int_turbo[1] ? pre_zneg_140 : 
                    int_turbo[0] ? pre_zneg_70 : pre_zneg_35;
  
  always @(posedge fclk)
      begin
        zpos <= (~stall & zclk_out) & pre_zpos;
      end
  
  always @(posedge fclk)
      begin
        zneg <= (~zclk_out & pre_zneg) & ~stall;
      end
  
  always @(negedge fclk)
      begin
        if (zpos) zclk_out <= 1'b0;
          
        if (zneg) zclk_out <= 1'b1;
          
      end
endmodule

