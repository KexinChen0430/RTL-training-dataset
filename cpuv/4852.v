module twoPortMemSim (
    writeAddress,  
    writeClk,      
    writeEnable,   
    writeData,     
    readAddress,   
    readClk,       
    readEnable,    
    readData       
);
   parameter addresses   = 32; 
   parameter width       = 8;  
   parameter muxFactor   = 0;  
   parameter writeMask   = 1;  
   localparam addressWidth = $clog2(addresses); 
   input [addressWidth-1:0] writeAddress; 
   input                    writeClk;     
   input [writeMask-1:0]    writeEnable;  
   input [width-1:0]        writeData;    
   input [addressWidth-1:0] readAddress;  
   input                    readClk;      
   input                    readEnable;   
   output [width-1:0]       readData;     
   reg [width-1:0] mem [addresses-1:0]; 
   reg [width-1:0] readData;
   integer i;
   initial begin
      $display("%m : simulation model of memory"); 
   end
   always @(posedge writeClk) begin
      if (writeEnable != 0) begin 
         if (writeMask == 1) begin
            mem[writeAddress] <= writeData;
         end else begin
            for (i = 0; i < writeMask; i = i + 1) begin
               if (writeEnable[i] == 1) begin
                  mem[writeAddress][i] <= writeData[i];
               end
            end
         end
      end
   end
   always @(posedge writeClk) begin 
      if (readEnable) begin 
         readData <= mem[readAddress];
      end
   end
endmodule