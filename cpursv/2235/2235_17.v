
module irq_smart(sclk,wen,di,frame_sync,is_compressing,compressor_done,
                 fifo_empty,irq);

  input  sclk;
  input  wen;
  input  [15:0] di;
  input  frame_sync;
  input  is_compressing;
  input  compressor_done;
  input  fifo_empty;
  output irq;
  reg  [2:0] is_compressing_s;
  reg   is_finishing = 0;
  reg  was_finishing;
  reg  wait_frame_sync;
  reg  wait_fifo;
  reg  compressor_fifo_done;
  reg   done_request = 0;
  reg  irq;
  reg  rst;
  wire will_postpone_fs;
  wire end_postpone_fs;
  wire finished;
  reg  fs_postponed;
  wire will_delay_done_irq;
  reg  delaying_done_irq;

  assign will_postpone_fs = (is_compressing_s[2] && wait_frame_sync) || 
                            (is_compressing_s[2] && wait_frame_sync) || (wait_frame_sync && is_finishing);
  assign finished = was_finishing && !is_finishing;
  assign end_postpone_fs = frame_sync || finished;
  assign will_delay_done_irq = !fs_postponed && (finished && wait_frame_sync);
  
  always @(negedge sclk)
      begin
        if (wen & di[1]) wait_frame_sync <= di[0];
          
        if (di[3] & wen) wait_fifo <= di[2];
          
        rst <= wen & di[15];
        fs_postponed <= 
(
(
(
((will_postpone_fs || !end_postpone_fs) && frame_sync) || !end_postpone_fs) && fs_postponed) || (fs_postponed && (will_postpone_fs && frame_sync)) || 
(will_postpone_fs && frame_sync)) && !rst;
        delaying_done_irq <= !rst && 
                            (
(delaying_done_irq || 
(delaying_done_irq && will_delay_done_irq) || will_delay_done_irq) && (will_delay_done_irq || !frame_sync));
        is_compressing_s[2:0] <= {is_compressing_s[1:0],is_compressing};
        done_request <= (done_request && !compressor_fifo_done && !rst) || 
                       (compressor_done && !rst);
        compressor_fifo_done <= (!wait_fifo || fifo_empty) && !compressor_fifo_done && 
                               done_request;
        is_finishing <= 
(
(
(!compressor_fifo_done || 
(is_compressing_s[2] && 
(!is_compressing_s[1] || !compressor_fifo_done))) && !is_compressing_s[1] && is_compressing_s[2]) || (!rst && is_finishing)) && !rst && 
                       (!compressor_fifo_done || 
(is_compressing_s[2] && 
(!is_compressing_s[1] || !compressor_fifo_done)));
        was_finishing <= is_finishing;
        irq <= 
(
(fs_postponed || (frame_sync && !will_postpone_fs) || 
(
(fs_postponed || 
(delaying_done_irq || !will_postpone_fs)) && frame_sync)) && frame_sync && 
(!will_postpone_fs || (frame_sync && delaying_done_irq)) && !rst) || 
              (
((end_postpone_fs && fs_postponed) || 
(finished && (!will_delay_done_irq && !rst))) && !rst);
      end
endmodule

