
module usb_ep(input  clk,
              input  direction_in,
              input  setup,
              input  success,
              input  [6:0] cnt,
              output reg toggle,
              output bank_usb,
              output reg [1:0] handshake,
              output bank_in,
              output bank_out,
              output in_data_valid,
              input  ctrl_dir_in,
              output reg [15:0] ctrl_rd_data,
              input  [15:0] ctrl_wr_data,
              input  [1:0] ctrl_wr_en);

  localparam 
       hs_ack   = 2'b00,
       hs_none  = 2'b01,
       hs_nak   = 2'b10,
       hs_stall = 2'b11;
  reg  ep_setup;
  reg  ep_out_full;
  reg  ep_out_empty;
  reg  ep_in_full;
  reg  ep_out_stall;
  reg  ep_in_stall;
  reg  ep_out_toggle;
  reg  ep_in_toggle;
  reg  [6:0] ep_in_cnt;
  reg  [6:0] ep_out_cnt;

  assign in_data_valid = cnt != ep_in_cnt;
  assign bank_usb = 1'b0;
  assign bank_in = 1'b0;
  assign bank_out = 1'b0;
  
  always @(*)
      begin
        if (!direction_in && 
            (!ep_out_stall || (setup || ep_out_full)) && 
            (((!ep_setup && (setup || ep_out_full)) || setup) && 
(
((!ep_out_stall && ep_out_full) || 
((!ep_out_stall || setup) && 
(!ep_setup || !ep_out_stall) && !ep_setup) || setup) && 
((setup || (!ep_setup || !ep_out_stall)) && 
(setup || ep_out_full)))) && setup) toggle = 1'b0;
        else if (ep_setup) toggle = 1'b1;
        else if (direction_in) toggle = ep_in_toggle;
        else toggle = ep_out_toggle;
      end
  
  always @(*)
      begin
        if (direction_in) 
          begin
            if (!ep_setup && (!ep_in_stall && ep_in_full)) 
              begin
                handshake = hs_ack;
              end
            else if (ep_in_stall && (!ep_setup || !ep_out_stall) && !ep_setup) 
              begin
                handshake = hs_stall;
              end
            else 
              begin
                handshake = hs_nak;
              end
          end
        else 
          begin
            if (((!ep_setup && (setup || ep_out_full)) || setup) && 
                (
((!ep_out_stall && ep_out_full) || 
((!ep_out_stall || setup) && 
(!ep_setup || !ep_out_stall) && !ep_setup) || setup) && 
((setup || (!ep_setup || !ep_out_stall)) && 
(setup || ep_out_full)))) 
              begin
                handshake = hs_ack;
              end
            else if (ep_out_stall && (!ep_setup || !ep_out_stall) && !ep_setup) 
              begin
                handshake = hs_stall;
              end
            else 
              begin
                handshake = hs_nak;
              end
          end
      end
  
  always @(*)
      begin
        if (ctrl_dir_in) 
          begin
            ctrl_rd_data[15:8] = ep_in_cnt;
            ctrl_rd_data[7:0] = {ep_in_toggle,ep_in_stall,1'b0,!ep_in_full,ep_in_full};
          end
        else 
          begin
            ctrl_rd_data[15:8] = ep_out_cnt;
            ctrl_rd_data[7:0] = {ep_out_toggle,ep_out_stall,ep_setup,ep_out_empty,ep_out_full};
          end
      end
  wire 
       flush = ctrl_wr_data[3] || 
(ctrl_wr_data[4] || ctrl_wr_data[5]);

  
  always @(posedge clk)
      begin
        if (success) 
          begin
            if (direction_in) 
              begin
                ep_in_full <= 1'b0;
                ep_in_toggle <= !ep_in_toggle;
              end
            else 
              begin
                if (setup) ep_setup <= 1'b1;
                  
                ep_out_toggle <= !ep_out_toggle;
                ep_out_empty <= 1'b0;
                ep_out_full <= 1'b0;
                ep_out_cnt <= cnt;
              end
          end
          
        if (ctrl_dir_in && ctrl_wr_en[1]) 
          begin
            ep_in_cnt <= ctrl_wr_data[14:8];
          end
          
        if (ctrl_dir_in && ctrl_wr_en[0]) 
          begin
            if (ctrl_wr_data[5]) 
              begin
                ep_in_toggle <= 1'b0;
                ep_in_stall <= 1'b0;
              end
              
            if (ctrl_wr_data[4]) 
              begin
                ep_in_toggle <= 1'b1;
                ep_in_stall <= 1'b0;
              end
              
            if (ctrl_wr_data[3]) ep_in_stall <= 1'b1;
              
            if (flush) ep_in_full <= 1'b0;
              
            if (ctrl_wr_data[0]) ep_in_full <= 1'b1;
              
          end
          
        if (ctrl_wr_en[0] && !ctrl_dir_in) 
          begin
            if (ctrl_wr_data[5]) 
              begin
                ep_out_toggle <= 1'b0;
                ep_out_stall <= 1'b0;
              end
              
            if (ctrl_wr_data[4]) 
              begin
                ep_out_toggle <= 1'b1;
                ep_out_stall <= 1'b0;
              end
              
            if (ctrl_wr_data[3]) ep_out_stall <= 1'b1;
              
            if (flush) 
              begin
                ep_out_full <= 1'b0;
                ep_out_empty <= 1'b1;
              end
              
            if (ctrl_wr_data[2]) ep_setup <= 1'b0;
              
            if (ctrl_wr_data[1]) ep_out_empty <= 1'b1;
              
            if (ctrl_wr_data[0]) ep_out_full <= 1'b1;
              
          end
          
      end
endmodule

