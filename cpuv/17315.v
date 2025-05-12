module e16_mesh_interface(
   wait_out, access_out, write_out, datamode_out, ctrlmode_out,
   data_out, dstaddr_out, srcaddr_out, access_reg, write_reg,
   datamode_reg, ctrlmode_reg, data_reg, dstaddr_reg, srcaddr_reg,
   clk, clk_en, reset, wait_in, access_in, write_in, datamode_in,
   ctrlmode_in, data_in, dstaddr_in, srcaddr_in, wait_int, access,
   write, datamode, ctrlmode, data, dstaddr, srcaddr
   );
   parameter DW = `CFG_DW;
   parameter AW = `CFG_AW;
   input            clk;          
   input            clk_en;       
   input            reset;        
   input            wait_in;      
   input            access_in;    
   input            write_in;     
   input [1:0]      datamode_in;  
   input [3:0]      ctrlmode_in;  
   input [DW-1:0]   data_in;      
   input [AW-1:0]   dstaddr_in;   
   input [AW-1:0]   srcaddr_in;   
   input            wait_int;     
   input            access;       
   input            write;        
   input [1:0]      datamode;     
   input [3:0]      ctrlmode;     
   input [DW-1:0]   data;         
   input [AW-1:0]   dstaddr;      
   input [AW-1:0]   srcaddr;      
   output           wait_out;     
   output           access_out;   
   output           write_out;    
   output [1:0]     datamode_out; 
   output [3:0]     ctrlmode_out; 
   output [DW-1:0]  data_out;     
   output [AW-1:0]  dstaddr_out;  
   output [AW-1:0]  srcaddr_out;  
   output           access_reg;   
   output           write_reg;    
   output [1:0]     datamode_reg; 
   output [3:0]     ctrlmode_reg; 
   output [DW-1:0]  data_reg;     
   output [AW-1:0]  dstaddr_reg;  
   output [AW-1:0]  srcaddr_reg;  
   reg          wait_out;
   reg          access_out;
   reg          write_out;
   reg [1:0]    datamode_out;
   reg [3:0]    ctrlmode_out;
   reg [DW-1:0] data_out;
   reg [AW-1:0] dstaddr_out;
   reg [AW-1:0] srcaddr_out;
   reg          access_reg;
   reg          write_reg;
   reg [1:0]    datamode_reg;
   reg [3:0]    ctrlmode_reg;
   reg [DW-1:0] data_reg;
   reg [AW-1:0] dstaddr_reg;
   reg [AW-1:0] srcaddr_reg;
   always @ (posedge clk or posedge reset)
     if(reset)
       access_reg <= 1'b0;         
     else if(clk_en)
       if(~wait_int)               
         access_reg <= access_in;
   always @ (posedge clk)
     if(clk_en)
       if(~wait_int & access_in)   
         begin
            write_reg <= write_in; 
            datamode_reg[1:0] <= datamode_in[1:0];
            ctrlmode_reg[3:0] <= ctrlmode_in[3:0];
            data_reg[DW-1:0] <= data_in[DW-1:0];
            dstaddr_reg[AW-1:0] <= dstaddr_in[AW-1:0];
            srcaddr_reg[AW-1:0] <= srcaddr_in[AW-1:0];
         end
   always @ (posedge clk or posedge reset)
     if(reset)
       access_out <= 1'b0;        
     else if(clk_en)
       if(!wait_in)                
         access_out <= access;
   always @ (posedge clk)
     if (clk_en)
       if(!wait_in & access)       
         begin
            srcaddr_out[AW-1:0] <= srcaddr[AW-1:0];
            data_out[DW-1:0] <= data[DW-1:0];
            write_out <= write;
            datamode_out[1:0] <= datamode[1:0];
            dstaddr_out[AW-1:0] <= dstaddr[AW-1:0];
            ctrlmode_out[3:0] <= ctrlmode[3:0];
         end
   always @ (posedge clk or posedge reset)
     if(reset)
       wait_out <= 1'b0;          
     else if(clk_en)
       wait_out <= wait_int;      
endmodule 