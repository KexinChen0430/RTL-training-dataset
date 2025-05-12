module t ();
   byte         d_byte;      
   shortint     d_shortint;  
   int          d_int;       
   longint      d_longint;   
   integer      d_integer;   
   time         d_time;      
   chandle      d_chandle;   
   bit          d_bit;       
   logic        d_logic;     
   reg          d_reg;       
   bit [0:0]    d_bit1;      
   logic [0:0]  d_logic1;    
   reg [0:0]    d_reg1;      
   bit          d_bitz;      
   logic        d_logicz;    
   reg          d_regz;      
   real         d_real;      
   realtime     d_realtime;  
   initial begin
      d_bitz[0] = 1'b1;         
      d_logicz[0] = 1'b1;       
      d_regz[0] = 1'b1;         
`ifndef VERILATOR 
      d_chandle[0] = 1'b1;      
`endif
      d_real[0] = 1'b1;         
      d_realtime[0] = 1'b1;     
      d_byte[0] = 1'b1;         
      d_shortint[0] = 1'b1;     
      d_int[0] = 1'b1;          
      d_longint[0] = 1'b1;      
      d_integer[0] = 1'b1;      
      d_time[0] = 1'b1;         
      d_bit1[0] = 1'b1;         
      d_logic1[0] = 1'b1;       
      d_reg1[0] = 1'b1;         
   end
endmodule