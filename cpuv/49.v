module soc_design_Sys_Timer (
  input   [2:0]  address,       
  input          chipselect,    
  input          clk,           
  input          reset_n,       
  input          write_n,       
  input   [15:0] writedata,     
  output         irq,           
  output [15:0]  readdata       
);
wire             clk_en;                    
wire             control_interrupt_enable;  
reg              control_register;          
wire             control_wr_strobe;         
reg              counter_is_running;        
wire             counter_is_zero;           
wire    [16:0]   counter_load_value;        
reg              delayed_unxcounter_is_zeroxx0; 
wire             do_start_counter;          
wire             do_stop_counter;           
reg              force_reload;              
reg     [16:0]   internal_counter;          
wire             period_h_wr_strobe;        
wire             period_l_wr_strobe;        
wire    [15:0]   read_mux_out;              
reg     [15:0]   readdata;                  
wire             status_wr_strobe;          
wire             timeout_event;             
reg              timeout_occurred;          
endmodule