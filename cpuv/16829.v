module niosii_nios2_gen2_0_cpu_nios2_oci_dbrk (
  input   [ 31: 0] E_st_data,                       
  input   [ 31: 0] av_ld_data_aligned_filtered,     
  input            clk,                             
  input   [ 17: 0] d_address,                       
  input            d_read,                          
  input            d_waitrequest,                   
  input            d_write,                         
  input            debugack,                        
  input            reset_n,                         
  output  [ 17: 0] cpu_d_address,                   
  output           cpu_d_read,                      
  output  [ 31: 0] cpu_d_readdata,                  
  output           cpu_d_wait,                      
  output           cpu_d_write,                     
  output  [ 31: 0] cpu_d_writedata,                 
  output           dbrk_break,                      
  output           dbrk_goto0,                      
  output           dbrk_goto1,                      
  output           dbrk_traceme,                    
  output           dbrk_traceoff,                   
  output           dbrk_traceon,                    
  output           dbrk_trigout                     
);
wire    [ 17: 0] cpu_d_address;                     
wire             cpu_d_read;                        
wire    [ 31: 0] cpu_d_readdata;                    
wire             cpu_d_wait;                        
wire             cpu_d_write;                       
wire    [ 31: 0] cpu_d_writedata;                   
wire             dbrk0_armed;                       
wire             dbrk0_break_pulse;                 
wire             dbrk0_goto0;                       
wire             dbrk0_goto1;                       
wire             dbrk0_traceme;                     
wire             dbrk0_traceoff;                    
wire             dbrk0_traceon;                     
wire             dbrk0_trigout;                     
wire             dbrk1_armed;                       
wire             dbrk1_break_pulse;                 
wire             dbrk1_goto0;                       
wire             dbrk1_goto1;                       
wire             dbrk1_traceme;                     
wire             dbrk1_traceoff;                    
wire             dbrk1_traceon;                     
wire             dbrk1_trigout;                     
wire             dbrk2_armed;                       
wire             dbrk2_break_pulse;                 
wire             dbrk2_goto0;                       
wire             dbrk2_goto1;                       
wire             dbrk2_traceme;                     
wire             dbrk2_traceoff;                    
wire             dbrk2_traceon;                     
wire             dbrk2_trigout;                     
wire             dbrk3_armed;                       
wire             dbrk3_break_pulse;                 
wire             dbrk3_goto0;                       
wire             dbrk3_goto1;                       
wire             dbrk3_traceme;                     
wire             dbrk3_traceoff;                    
wire             dbrk3_traceon;                     
wire             dbrk3_trigout;                     
reg              dbrk_break;                        
reg              dbrk_break_pulse;                  
wire    [ 31: 0] dbrk_data;                         
reg              dbrk_goto0;                        
reg              dbrk_goto1;                        
reg              dbrk_traceme;                      
reg              dbrk_traceoff;                     
reg              dbrk_traceon;                      
reg              dbrk_trigout;                      
assign cpu_d_address = d_address;                   
assign cpu_d_readdata = av_ld_data_aligned_filtered;
assign cpu_d_read = d_read;                         
assign cpu_d_writedata = E_st_data;                 
assign cpu_d_write = d_write;                       
assign cpu_d_wait = d_waitrequest;                  
assign dbrk_data = cpu_d_write ? cpu_d_writedata : cpu_d_readdata;
always @(posedge clk or negedge reset_n)
begin
  if (reset_n == 0)
    dbrk_break <= 0;                                
  else
    dbrk_break <= dbrk_break ? ~debugack            
                  : dbrk_break_pulse;                
end
assign dbrk0_armed = 1'b0;
assign dbrk0_trigout = 1'b0;
assign dbrk0_break_pulse = 1'b0;
assign dbrk0_traceoff = 1'b0;
assign dbrk0_traceon = 1'b0;
assign dbrk0_traceme = 1'b0;
assign dbrk0_goto0 = 1'b0;
assign dbrk0_goto1 = 1'b0;
assign dbrk1_armed = 1'b0;
assign dbrk1_trigout = 1'b0;
assign dbrk1_break_pulse = 1'b0;
assign dbrk1_traceoff = 1'b0;
assign dbrk1_traceon = 1'b0;
assign dbrk1_traceme = 1'b0;
assign dbrk1_goto0 = 1'b0;
assign dbrk1_goto1 = 1'b0;
assign dbrk2_armed = 1'b0;
assign dbrk2_trigout = 1'b0;
assign dbrk2_break_pulse = 1'b0;
assign dbrk2_traceoff = 1'b0;
assign dbrk2_traceon = 1'b0;
assign dbrk2_traceme = 1'b0;
assign dbrk2_goto0 = 1'b0;
assign dbrk2_goto1 = 1'b0;
assign dbrk3_armed = 1'b0;
assign dbrk3_trigout = 1'b0;
assign dbrk3_break_pulse = 1'b0;
assign dbrk3_traceoff = 1'b0;
assign dbrk3_traceon = 1'b0;
assign dbrk3_traceme = 1'b0;
assign dbrk3_goto0 = 1'b0;
assign dbrk3_goto1 = 1'b0;
always @(posedge clk or negedge reset_n)
begin
  if (reset_n == 0)
  begin
    dbrk_trigout <= 0;
    dbrk_break_pulse <= 0;
    dbrk_traceoff <= 0;
    dbrk_traceon <= 0;
    dbrk_traceme <= 0;
    dbrk_goto0 <= 0;
    dbrk_goto1 <= 0;
  end
  else
  begin
    dbrk_trigout <= dbrk0_trigout | dbrk1_trigout | dbrk2_trigout | dbrk3_trigout;
    dbrk_break_pulse <= dbrk0_break_pulse | dbrk1_break_pulse | dbrk2_break_pulse | dbrk3_break_pulse;
    dbrk_traceoff <= dbrk0_traceoff | dbrk1_traceoff | dbrk2_traceoff | dbrk3_traceoff;
    dbrk_traceon <= dbrk0_traceon | dbrk1_traceon | dbrk2_traceon | dbrk3_traceon;
    dbrk_traceme <= dbrk0_traceme | dbrk1_traceme | dbrk2_traceme | dbrk3_traceme;
    dbrk_goto0 <= dbrk0_goto0 | dbrk1_goto0 | dbrk2_goto0 | dbrk3_goto0;
    dbrk_goto1 <= dbrk0_goto1 | dbrk1_goto1 | dbrk2_goto1 | dbrk3_goto1;
  end
end
endmodule