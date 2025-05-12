module display_16hex (
    reset, clock_27mhz, data_in,
    disp_blank, disp_clock, disp_rs, disp_ce_b,
    disp_reset_b, disp_data_out
);
   input reset, clock_27mhz;    
   input [63:0] data_in;        
   output disp_blank, disp_clock, disp_data_out, disp_rs, disp_ce_b, disp_reset_b; 
   reg disp_data_out, disp_rs, disp_ce_b, disp_reset_b;
   reg [5:0] count;             
   reg [7:0] reset_count;       
   wire      dreset;            
   wire      clock = (count<27) ? 0 : 1; 
   always @(posedge clock_27mhz)
     begin
        count <= reset ? 0 : (count==53 ? 0 : count+1); 
        reset_count <= reset ? 100 : ((reset_count==0) ? 0 : reset_count-1); 
     end
   assign dreset = (reset_count != 0);
   assign disp_clock = ~clock;
   wire   clock_tick = ((count==27) ? 1 : 0); 
   reg [7:0] state;             
   reg [9:0] dot_index;         
   reg [31:0] control;          
   reg [3:0] char_index;        
   reg [39:0] dots;             
   reg [3:0] nibble;            
   reg [63:0] data;             
   assign disp_blank = 1'b0;    
   always @(posedge clock_27mhz)
     if (clock_tick)            
       begin
          if (dreset)           
            begin
               state <= 0;      
               dot_index <= 0;  
               control <= 32'h7F7F7F7F; 
            end
          else                  
            casex (state)       
            endcase 
       end
   always @ (data or char_index)
     case (char_index)
     endcase
   always @(nibble)
     case (nibble)
     endcase
endmodule