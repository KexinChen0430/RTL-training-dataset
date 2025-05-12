module fric_client
  (
   clk, 
   rst, 
   fric_in, 
   fric_out, 
   slave_addr, 
   slave_wdat, 
   slave_wstb, 
   slave_rdat, 
   master_type, 
   master_port, 
   master_addr, 
   master_wdat, 
   master_tstb, 
   master_trdy, 
   master_rstb, 
   master_rdat 
   );
   input           clk; 
   input           rst; 
   input [7:0]     fric_in; 
   output [7:0]    fric_out; 
   output [7:0]    slave_addr; 
   output [15:0]   slave_wdat; 
   output          slave_wstb; 
   input [15:0]    slave_rdat; 
   input [3:0]     master_type; 
   input [3:0]     master_port; 
   input [7:0]     master_addr; 
   input [15:0]    master_wdat; 
   input           master_tstb; 
   output          master_trdy; 
   output          master_rstb; 
   output [15:0]   master_rday; 
endmodule