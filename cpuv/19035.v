module pcie_blk_cf_pwr
(
       input              clk,
       input              rst_n,
       input              cfg_turnoff_ok_n,
       output reg         cfg_to_turnoff_n,
       input              cfg_pm_wake_n,
       input              l0_pwr_turn_off_req,
       output reg         l0_pme_req_in,
       input              l0_pme_ack,
       output reg         send_pmeack,
       input              cs_is_pm,
       input              grant
);
always @(posedge clk)
begin
  if (~rst_n) begin
    cfg_to_turnoff_n    <= #`TCQ 1;
    send_pmeack         <= #`TCQ 0;
    l0_pme_req_in       <= #`TCQ 0;
  end else begin
    if (l0_pwr_turn_off_req)
      cfg_to_turnoff_n    <= #`TCQ 0;
    else if (~cfg_turnoff_ok_n)
      cfg_to_turnoff_n    <= #`TCQ 1;
    if (~cfg_turnoff_ok_n && ~cfg_to_turnoff_n)
      send_pmeack         <= #`TCQ 1;
    else if (cs_is_pm && grant)
      send_pmeack         <= #`TCQ 0;
    if (~cfg_pm_wake_n)
      l0_pme_req_in       <= #`TCQ 1;
    else if (l0_pme_ack)
      l0_pme_req_in       <= #`TCQ 0;
  end
end
endmodule