module altpcietb_bfm_log_common(dummy_out) ;
output dummy_out;
   `include "altpcietb_bfm_log.v"
   integer log_file ;
   reg [EBFM_MSG_ERROR_CONTINUE:EBFM_MSG_DEBUG] suppressed_msg_mask ;
   reg [EBFM_MSG_ERROR_CONTINUE:EBFM_MSG_DEBUG] stop_on_msg_mask ;
   initial
     begin
        suppressed_msg_mask = {EBFM_MSG_ERROR_CONTINUE-EBFM_MSG_DEBUG+1{1'b0}} ;
        suppressed_msg_mask[EBFM_MSG_DEBUG] = 1'b1 ;
        stop_on_msg_mask    = {EBFM_MSG_ERROR_CONTINUE-EBFM_MSG_DEBUG+1{1'b0}} ;
     end
endmodule