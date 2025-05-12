module seg_status
  (
   input             boot_done, 
   input             mem_calib_done, 
   input             mem_error, 
   input             clear_screen_done, 
   input             sdcard_read_started, 
   input             sdcard_read_done, 
   input             sdcard_read_error, 
   input [7:0]       sdcard_progress, 
   input             uart_load_started, 
   input             uart_load_done, 
   input [7:0]       uart_progress, 
   input [11:0]      processor_status, 
   output reg [11:0] seg_digits 
   );
   always @ (*) begin
      if (!mem_calib_done) begin
         seg_digits = `STATE_MEM_UNCALIB; 
      end 
      else if (mem_error) begin
         seg_digits = `STATE_MEM_ERROR; 
      end 
      else if (!clear_screen_done) begin
         seg_digits = `STATE_CLEAR_SCREEN; 
      end 
      else if (sdcard_read_error) begin
         seg_digits = `STATE_SDCARD_ERROR; 
      end 
      else if (sdcard_read_started && !sdcard_read_done) begin
         seg_digits = `STATE_SDCARD_READ | sdcard_progress; 
      end 
      else if (!boot_done) begin
         seg_digits = `STATE_UART_LOAD | uart_progress; 
      end 
      else begin
         seg_digits = processor_status;
      end
   end
endmodule