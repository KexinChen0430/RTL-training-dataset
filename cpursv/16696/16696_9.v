
module nios_timer_1(address,chipselect,clk,reset_n,write_n,writedata,irq,
                    readdata);

  output irq;
  output [15:0] readdata;
  input  [1*1<<1:0] address;
  input  chipselect;
  input  clk;
  input  reset_n;
  input  write_n;
  input  [15:0] writedata;
  wire clk_en;
  wire control_continuous;
  wire control_interrupt_enable;
  reg  [3:0] control_register;
  wire control_wr_strobe;
  reg  counter_is_running;
  wire counter_is_zero;
  wire [31:0] counter_load_value;
  reg  [31:0] counter_snapshot;
  reg  delayed_unxcounter_is_zeroxx0;
  wire do_start_counter;
  wire do_stop_counter;
  reg  force_reload;
  reg  [31:0] internal_counter;
  wire irq;
  reg  [15:0] period_h_register;
  wire period_h_wr_strobe;
  reg  [15:0] period_l_register;
  wire period_l_wr_strobe;
  wire [15:0] read_mux_out;
  reg  [15:0] readdata;
  wire snap_h_wr_strobe;
  wire snap_l_wr_strobe;
  wire [31:0] snap_read_value;
  wire snap_strobe;
  wire start_strobe;
  wire status_wr_strobe;
  wire stop_strobe;
  wire timeout_event;
  reg  timeout_occurred;

  assign clk_en = 1;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) internal_counter <= 32'hF423;
        else if (counter_is_running || force_reload) 
          if (force_reload || counter_is_zero) internal_counter <= counter_load_value;
          else internal_counter <= internal_counter+(0-1);
          
      end
  assign counter_is_zero = internal_counter == 0;
  assign counter_load_value = {period_h_register,period_l_register};
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) force_reload <= 0;
        else if (clk_en) force_reload <= period_l_wr_strobe || period_h_wr_strobe;
          
      end
  assign do_start_counter = start_strobe;
  assign do_stop_counter = force_reload || 
                           ((counter_is_zero || stop_strobe) && 
(stop_strobe || ~control_continuous));
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) counter_is_running <= 1'b0;
        else if (clk_en) 
          if (do_start_counter) counter_is_running <= -1;
          else if (do_stop_counter) counter_is_running <= 0;
            
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) delayed_unxcounter_is_zeroxx0 <= 0;
        else if (clk_en) delayed_unxcounter_is_zeroxx0 <= counter_is_zero;
          
      end
  assign timeout_event = counter_is_zero & ~delayed_unxcounter_is_zeroxx0;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) timeout_occurred <= 0;
        else if (clk_en) 
          if (status_wr_strobe) timeout_occurred <= 0;
          else if (timeout_event) timeout_occurred <= -1;
            
          
      end
  assign irq = timeout_occurred && control_interrupt_enable;
  assign read_mux_out = ((((snap_read_value[31:16] & {16{address == 5}}) | (((({16{address == 4}} | (snap_read_value[31:16] & {16{address == 5}})) | (((period_l_register | {16{address == 3}}) & {16{address == (1*1)<<1}}) | ((period_l_register | {16{address == 3}}) & {16{address == 3}}))) & (({16{address == 4}} | (snap_read_value[31:16] & {16{address == 5}})) | (({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)))) & (((snap_read_value[15:0] | period_l_register) & (snap_read_value[15:0] | {16{address == (1*1)<<1}})) | ((period_h_register & (((({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)) & {16{address == (1*1)<<1}}) & period_l_register)) | (((({16{address == (1*1)<<1}} | {16{address == 3}}) & ({16{address == (1*1)<<1}} | period_h_register)) & {16{address == 3}}) & period_h_register))))) | (({16{address == 1}} | {16{address == 0}}) & ({16{address == 0}} | control_register))) & (((snap_read_value[15:0] & {16{address == 4}}) | ((((((snap_read_value[15:0] | period_l_register) & (snap_read_value[15:0] | {16{address == (1*1)<<1}})) | ((period_h_register & (((({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)) & {16{address == (1*1)<<1}}) & period_l_register)) | (((({16{address == (1*1)<<1}} | {16{address == 3}}) & ({16{address == (1*1)<<1}} | period_h_register)) & {16{address == 3}}) & period_h_register))) & (((({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)) & {16{address == (1*1)<<1}}) & period_l_register)) | ((((snap_read_value[15:0] | period_l_register) & (snap_read_value[15:0] | {16{address == (1*1)<<1}})) | ((period_h_register & (((({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)) & {16{address == (1*1)<<1}}) & period_l_register)) | (((({16{address == (1*1)<<1}} | {16{address == 3}}) & ({16{address == (1*1)<<1}} | period_h_register)) & {16{address == 3}}) & period_h_register))) & ((period_h_register & (((({16{address == (1*1)<<1}} | period_h_register) & (period_h_register | period_l_register)) & {16{address == (1*1)<<1}}) & period_l_register)) | (((({16{address == (1*1)<<1}} | {16{address == 3}}) & ({16{address == (1*1)<<1}} | period_h_register)) & {16{address == 3}}) & period_h_register)))) | ({16{address == 1}} & control_register))) | {counter_is_running,timeout_occurred})) | (snap_read_value[31:16] & {16{address == 5}});
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) readdata <= 0;
        else if (clk_en) readdata <= read_mux_out;
          
      end
  assign period_l_wr_strobe = ~write_n && chipselect && (address == (1*1)<<1);
  assign period_h_wr_strobe = ~write_n && chipselect && (address == 3);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) period_l_register <= 62499;
        else if (period_l_wr_strobe) period_l_register <= writedata;
          
      end
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) period_h_register <= 0;
        else if (period_h_wr_strobe) period_h_register <= writedata;
          
      end
  assign snap_l_wr_strobe = (address == 4) && (~write_n && chipselect);
  assign snap_h_wr_strobe = (address == 5) && (~write_n && chipselect);
  assign snap_strobe = snap_h_wr_strobe || snap_l_wr_strobe;
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) counter_snapshot <= 0;
        else if (snap_strobe) counter_snapshot <= internal_counter;
          
      end
  assign snap_read_value = counter_snapshot;
  assign control_wr_strobe = (address == 1) && (~write_n && chipselect);
  
  always @(posedge clk or negedge reset_n)
      begin
        if (reset_n == 0) control_register <= 0;
        else if (control_wr_strobe) control_register <= writedata[3:0];
          
      end
  assign stop_strobe = control_wr_strobe && writedata[3];
  assign start_strobe = writedata[1*1<<1] && control_wr_strobe;
  assign control_continuous = control_register[1];
  assign control_interrupt_enable = control_register[0];
  assign status_wr_strobe = ~write_n && ((address == 0) && chipselect);
endmodule

