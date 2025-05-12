
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

  assign will_postpone_fs = 
(is_compressing_s[2] || 
(wait_frame_sync && is_finishing)) && wait_frame_sync;
  assign finished = !is_finishing && was_finishing;
  assign end_postpone_fs = frame_sync || finished;
  assign will_delay_done_irq = !fs_postponed && finished && wait_frame_sync;
  
  always @(negedge sclk)
      begin
        if (wen & di[1]) wait_frame_sync <= di[0];
          
        if (di[3] & wen) wait_fifo <= di[2];
          
        rst <= wen & di[15];
        fs_postponed <= 
(!end_postpone_fs || 
(will_postpone_fs && frame_sync && !rst)) && 
                       (!rst && 
((will_postpone_fs && (fs_postponed || frame_sync)) || 
fs_postponed));
        delaying_done_irq <= 
((!frame_sync || will_delay_done_irq) && 
(!rst && will_delay_done_irq)) || 
                            (!rst && delaying_done_irq && 
(!frame_sync || will_delay_done_irq));
        is_compressing_s[2:0] <= {is_compressing_s[1:0],is_compressing};
        done_request <= 
(
(compressor_done && 
(!rst && (compressor_done || done_request))) || (done_request && !wait_fifo) || done_request) && 
                       (
(compressor_done || 
(done_request && (!compressor_fifo_done && fifo_empty)) || !compressor_fifo_done) && !rst);
        compressor_fifo_done <= done_request && 
                               ((fifo_empty || (done_request && !wait_fifo)) && 
!compressor_fifo_done);
        is_finishing <= 
(!is_compressing_s[1] || 
(done_request && (!compressor_fifo_done && fifo_empty)) || !compressor_fifo_done) && 
                       (((is_finishing && !rst) || !is_compressing_s[1]) && 
((is_finishing && !rst) || 
(!rst && is_compressing_s[2])) && 
(is_compressing_s[2] || 
(!compressor_fifo_done && !wait_fifo) || !compressor_fifo_done));
        was_finishing <= is_finishing;
        irq <= (finished && !will_delay_done_irq && !rst) || 
              (finished && !will_delay_done_irq && !rst) || 
              ((frame_sync && !will_postpone_fs && !rst) || 
(delaying_done_irq && (frame_sync && !rst)) || 
(
(
((fs_postponed || frame_sync) && 
(fs_postponed || delaying_done_irq)) || (frame_sync && !will_postpone_fs)) && (end_postpone_fs && !rst)));
      end
endmodule

