module aurora_64b66b_25p4G_BLOCK_SYNC_SM #
 (
     parameter SH_CNT_MAX         = 16'd64,
     parameter SH_INVALID_CNT_MAX = 10'd16
 )
 (
     BLOCKSYNC_OUT,
     RXGEARBOXSLIP_OUT,
     RXHEADER_IN,
     RXHEADERVALID_IN,
     USER_CLK,
     SYSTEM_RESET
 );
     output         BLOCKSYNC_OUT;
     output         RXGEARBOXSLIP_OUT;
     input  [1:0]   RXHEADER_IN;
     input          RXHEADERVALID_IN;
     input          USER_CLK;
     input          SYSTEM_RESET;
     reg            BLOCKSYNC_OUT;
     reg            RXGEARBOXSLIP_OUT;
     reg            next_begin_c;
     reg            next_sh_invalid_c;
     reg            next_sh_valid_c;
     reg            next_slip_c;
     reg            next_sync_done_c;
     reg            next_test_sh_c;
     wire           sh_count_equals_max_i;
     wire           sh_invalid_cnt_equals_max_i;
     wire           sh_invalid_cnt_equals_zero_i;
     wire           slip_done_i;
     wire           sync_found_i;
     reg            begin_r;
     reg            sh_invalid_r;
     reg            sh_valid_r;
     reg    [15:0]  slip_count_i;
     reg            slip_r;
     reg            sync_done_r;
     reg    [15:0]  sync_header_count_i;
     reg    [9:0]   sync_header_invalid_count_i;
     reg            test_sh_r;
     reg            system_reset_r;
     reg            system_reset_r2;
     assign sync_found_i   = (RXHEADER_IN == 2'b01) || (RXHEADER_IN == 2'b10);
     always @(posedge USER_CLK)
     begin
         system_reset_r     <=  `DLY   SYSTEM_RESET;
         system_reset_r2    <=  `DLY   system_reset_r;
     end
     always @(posedge USER_CLK)
         if(system_reset_r2)
             {begin_r,test_sh_r,sh_valid_r,sh_invalid_r,slip_r,sync_done_r}  <=  `DLY    6'b100000;
         else
         begin
             begin_r          <=  `DLY    next_begin_c;
             test_sh_r        <=  `DLY    next_test_sh_c;
             sh_valid_r       <=  `DLY    next_sh_valid_c;
             sh_invalid_r     <=  `DLY    next_sh_invalid_c;
             slip_r           <=  `DLY    next_slip_c;
             sync_done_r      <=  `DLY    next_sync_done_c;
         end
localparam BEGIN_R_ST     = 6'b100000,
           TEST_SH_ST     = 6'b010000,
           SH_VALID_ST    = 6'b001000,
           SH_INVALID_ST  = 6'b000100,
           SLIP_R_ST      = 6'b000010,
           SYNC_DONE_R_ST = 6'b000001;
  always @(*)
  begin
      {next_begin_c,next_test_sh_c,next_sh_valid_c,next_sh_invalid_c,next_slip_c,next_sync_done_c} = 6'b000000;
      case({begin_r,test_sh_r,sh_valid_r,sh_invalid_r,slip_r,sync_done_r})
          BEGIN_R_ST:
          begin
              next_test_sh_c = 1'b1;
          end
          TEST_SH_ST:
          begin
              if(RXHEADERVALID_IN)
              begin
                  if(sync_found_i)
                      next_sh_valid_c = 1'b1;
                  else
                      next_sh_invalid_c = 1'b1;
              end
              else
                  next_test_sh_c = 1'b1;
          end
          SH_VALID_ST:
          begin
              if(sh_count_equals_max_i)
              begin
                  if(sh_invalid_cnt_equals_zero_i)
                      next_sync_done_c = 1'b1;
                  else if((sh_invalid_cnt_equals_max_i | !BLOCKSYNC_OUT))
                      next_slip_c = 1'b1;
                  else
                      next_begin_c = 1'b1;
              end
              else
                  next_test_sh_c = 1'b1;
          end
          SH_INVALID_ST:
          begin
              if(sh_invalid_cnt_equals_max_i)
                  next_slip_c = 1'b1;
              else
              begin
                  if(!BLOCKSYNC_OUT)
                      next_slip_c = 1'b1;
                  else if(sh_count_equals_max_i)
                      next_begin_c = 1'b1;
                  else
                      next_test_sh_c = 1'b1;
              end
          end
          SLIP_R_ST:
          begin
              if(slip_done_i)
                  next_begin_c =1'b1;
              else
                  next_slip_c = 1'b1;
          end
          SYNC_DONE_R_ST:
          begin
              next_begin_c = 1'b1;
          end
          default:
          begin
              next_begin_c = 1'b1;
          end
      endcase
  end
     always @(posedge USER_CLK)
         if(begin_r)
         begin
             sync_header_count_i   <=  `DLY    16'd0;
         end
         else if (sh_valid_r || sh_invalid_r)
         begin
             sync_header_count_i  <=  `DLY    sync_header_count_i + 16'd1;
         end
     assign sh_count_equals_max_i = (sync_header_count_i==SH_CNT_MAX);
     always @(posedge USER_CLK)
         if(begin_r)
         begin
             sync_header_invalid_count_i   <=  `DLY    10'd0;
         end
         else if (sh_invalid_r)
         begin
             sync_header_invalid_count_i  <=  `DLY    sync_header_invalid_count_i + 10'd1;
         end
     assign sh_invalid_cnt_equals_max_i  = (sync_header_invalid_count_i==SH_INVALID_CNT_MAX);
     assign sh_invalid_cnt_equals_zero_i = (sync_header_invalid_count_i==0);
     wire   slip_pulse_i = next_slip_c && !slip_r;
     always @(posedge USER_CLK)
         RXGEARBOXSLIP_OUT   <=  slip_pulse_i;
     always @(posedge USER_CLK)
         if(!slip_r) slip_count_i   <=  `DLY    16'h0000;
         else        slip_count_i   <=  `DLY    {slip_count_i[14:0],RXGEARBOXSLIP_OUT};
     assign slip_done_i = slip_count_i[15];
     always @(posedge USER_CLK)
         if(system_reset_r2 || slip_r)  BLOCKSYNC_OUT   <=  `DLY    1'b0;
         else if (sync_done_r)       BLOCKSYNC_OUT   <=  `DLY    1'b1;
 endmodule