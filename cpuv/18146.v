module RegFile_1port(CLK, rst_n,
               ADDR_IN, D_IN, WE,
               ADDR_OUT, D_OUT
               );
   parameter                   data_width = 1;
   parameter                   addr_width = 1;
   parameter                   depth = 1<<addr_width;
   input                       CLK;
   input                       rst_n;
   input [addr_width - 1 : 0]  ADDR_IN;
   input [data_width - 1 : 0]  D_IN;
   input                       WE;
   input [addr_width - 1 : 0]  ADDR_OUT;
   output [data_width - 1 : 0] D_OUT;
   reg [data_width - 1 : 0]    arr[0 : depth-1];
   always@(posedge CLK)
     begin
        if (WE)
          arr[ADDR_IN] <= `BSV_ASSIGNMENT_DELAY D_IN;
     end 
   assign D_OUT  = arr[ADDR_OUT ];
endmodule