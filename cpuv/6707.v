module aurora_64b66b_25p4G_WIDTH_CONVERSION # 
 (
     parameter INPUT_WIDTH =2, 
     parameter OUTPUT_WIDTH=4 
 )
 (
     DATA_OUT, 
     DATA_IN, 
     HEADER_IN, 
     DATAVALID_IN, 
     HEADER_OUT, 
     DATAVALID_OUT, 
     USER_CLK, 
     ENABLE, 
     RESET 
 );
 `define DLY #1 
     input                         RESET; 
     input                         USER_CLK; 
     input                         ENABLE; 
     input   [INPUT_WIDTH*8-1:0]   DATA_IN; 
     output  [OUTPUT_WIDTH*8-1:0]  DATA_OUT; 
     output  [1:0]                 HEADER_OUT; 
     output                        DATAVALID_OUT; 
     input   [1:0]                 HEADER_IN; 
     input                         DATAVALID_IN; 
     reg     [OUTPUT_WIDTH*8-1:0]  DATA_OUT; 
     reg     [1:0]                 HEADER_OUT; 
     reg     [INPUT_WIDTH*8-1:0]   data_in_r; 
     reg     [INPUT_WIDTH*8-1:0]   data_in_r2; 
     reg     [1:0]                 header_in_r; 
     reg     [1:0]                 header_in_r2; 
     reg                           datavalid_r; 
     reg                           datavalid_r2; 
     reg                           datavalid_neg_r; 
     reg                           datavalid_pos_r; 
     reg                           state; 
    always @(posedge USER_CLK) 
     begin
            data_in_r     <= `DLY  DATA_IN; 
            data_in_r2    <= `DLY  data_in_r; 
            header_in_r   <= `DLY HEADER_IN; 
            header_in_r2  <= `DLY header_in_r; 
     end
     always @(posedge USER_CLK) 
     begin
            datavalid_r   <=   `DLY DATAVALID_IN; 
            datavalid_r2   <=   `DLY datavalid_r; 
     end
     always @(posedge USER_CLK) 
     begin
          if(RESET) 
                  state <= `DLY 1'b1; 
          else if (ENABLE && datavalid_r2 && !datavalid_neg_r) 
                  state <= `DLY 1'b0; 
          else if (ENABLE && !datavalid_r2 && !datavalid_neg_r) 
                  state <= `DLY 1'b1; 
     end
     always @(posedge USER_CLK) 
     if(ENABLE) 
     begin
            datavalid_pos_r    <= `DLY datavalid_r; 
     end
     always @(negedge USER_CLK) 
     begin
            datavalid_neg_r  <= `DLY datavalid_r; 
     end
     always @(posedge USER_CLK) 
          if(RESET) DATA_OUT <= `DLY 32'b0; 
          else if(ENABLE) 
               begin
                   if(state) 
                   DATA_OUT <= `DLY {data_in_r2,data_in_r}; 
                  else if(!state) 
                   DATA_OUT <= `DLY {data_in_r,DATA_IN}; 
               end
     always @(posedge USER_CLK) 
       if (RESET) HEADER_OUT <= `DLY 2'b0; 
       else  if(ENABLE) 
           begin
               if(!state) 
                   HEADER_OUT            <= `DLY header_in_r; 
               else if(state) 
                   HEADER_OUT            <= `DLY header_in_r2; 
           end
     assign DATAVALID_OUT = datavalid_pos_r; 
 endmodule 