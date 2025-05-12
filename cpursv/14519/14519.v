
module bsg_flow_convert  #(parameter 
       send_v_and_ready_p  = 0,
       send_v_then_yumi_p  = 0,
       send_ready_then_v_p = 0,
       send_retry_then_v_p = 0,
       send_v_and_retry_p  = 0,
       recv_v_and_ready_p  = 0,
       recv_v_then_yumi_p  = 0,
       recv_ready_then_v_p = 0,
       recv_v_and_retry_p  = 0,
       recv_v_then_retry_p = 0,
       width_p             = 1)
  (input  [width_p-1:0] v_i,
   output [width_p-1:0] fc_o,
   output [width_p-1:0] v_o,
   input  [width_p-1:0] fc_i);

  if ((send_v_then_yumi_p & recv_v_and_ready_p) | (send_v_then_yumi_p & recv_ready_then_v_p)) assign fc_o = fc_i & v_i;
  else if (send_v_then_yumi_p & recv_v_and_retry_p) assign fc_o = ~fc_i & v_i;
  else if (send_ready_then_v_p & recv_v_then_yumi_p) 
    
    initial  
    begin
      $display("### %m a unhandled case requires fifo");
      $finish;
    end
  else if (send_ready_then_v_p & recv_v_then_retry_p) 
    
    initial  
    begin
      $display("### %m unhandled case requires fifo");
      $finish;
    end
  else if (send_retry_then_v_p & recv_v_then_yumi_p) 
    
    initial  
    begin
      $display("### %m unhandled case requires fifo");
      $finish;
    end
  else if ((send_retry_then_v_p | send_v_and_retry_p) ^ (recv_v_then_retry_p | recv_v_and_retry_p)) assign fc_o = ~fc_i;
  else assign fc_o = fc_i;
  if (recv_ready_then_v_p & ~send_ready_then_v_p) assign v_o = v_i & fc_i;
  else assign v_o = v_i;
endmodule

