module burst_converter
  #(
    parameter IADDR = 32, 
    parameter OADDR = 32  
    )
    (
     input wire              clk_sys, 
     input wire              rst, 
     input wire [IADDR-1:0]  addr_in, 
     input wire              write_in, 
     input wire [31:0]       writedata_in, 
     input wire              read_in, 
     output wire [31:0]      readdata_out, 
     output wire             readdatavalid_out, 
     input wire [3:0]        byteenable_in, 
     input wire [2:0]        burstcount_in, 
     output wire             waitrequest_out, 
     output wire [OADDR-1:0] addr_out, 
     output wire             write_out, 
     output wire [31:0]      writedata_out, 
     output wire             read_out, 
     input wire [31:0]       readdata_in, 
     input wire              readdatavalid_in, 
     output wire [3:0]       byteenable_out, 
     input wire              waitrequest_in 
     );