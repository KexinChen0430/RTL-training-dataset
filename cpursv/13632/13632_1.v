
module FSM_upload_flit(clk,rst,en_for_reg,out_req_fifo_rdy,cnt_invs_eq_3,cnt_eq_max,
                       head_flit,inv_ids_reg,sel_cnt_invs,sel_cnt_eq_0,en_inv_ids,
                       en_flit_max_in,inc_sel_cnt_invs,inc_sel_cnt,ctrl,clr_max,
                       clr_inv_ids,clr_sel_cnt_inv,clr_sel_cnt,dest_sel,
                       fsm_state_out,en_flit_out);

  input  clk;
  input  rst;
  input  out_req_fifo_rdy;
  input  en_for_reg;
  input  cnt_invs_eq_3;
  input  cnt_eq_max;
  input  [15:0] head_flit;
  input  [3:0] inv_ids_reg;
  input  [1:0] sel_cnt_invs;
  input  sel_cnt_eq_0;
  output en_inv_ids;
  output en_flit_max_in;
  output inc_sel_cnt_invs;
  output inc_sel_cnt;
  output [1:0] ctrl;
  output clr_max;
  output clr_inv_ids;
  output clr_sel_cnt_inv;
  output clr_sel_cnt;
  output dest_sel;
  output [1:0] fsm_state_out;
  output en_flit_out;
  parameter  shreq_cmd = 5'b00000;
  parameter  exreq_cmd = 5'b00001;
  parameter  upload_idle = 2'b00;
  parameter  upload_scORinvreqs = 2'b01;
  parameter  upload_wbORflushreqs = 2'b10;
  reg  [1:0] upload_rstate;
  reg  [1:0] upload_nstate;

  
  always @(posedge clk)
      begin
        if (rst) upload_rstate <= 2'b00;
        else upload_rstate <= upload_nstate;
      end
  assign fsm_state_out = upload_rstate;
  reg  en_inv_ids;

  reg  en_flit_max_in;

  reg  inc_sel_cnt_invs;

  reg  inc_sel_cnt;

  reg  [1:0] ctrl;

  reg  clr_max;

  reg  clr_inv_ids;

  reg  clr_sel_cnt_inv;

  reg  clr_sel_cnt;

  reg  dest_sel;

  reg  en_flit_out;

  
  always @(*)
      begin
        upload_nstate = upload_idle;
        en_inv_ids = 1'b0;
        en_flit_max_in = 1'b0;
        inc_sel_cnt_invs = 1'b0;
        inc_sel_cnt = 1'b0;
        ctrl = 2'b00;
        clr_max = 1'b0;
        clr_inv_ids = 1'b0;
        clr_sel_cnt_inv = 1'b0;
        clr_sel_cnt = 1'b0;
        dest_sel = 1'b0;
        en_flit_out = 1'b0;
        case (upload_rstate)

          upload_idle: begin

              end

          upload_scORinvreqs: begin

              end

          upload_wbORflushreqs: begin

              end

        endcase

      end
endmodule

