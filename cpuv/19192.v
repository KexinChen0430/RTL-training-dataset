module maquina_4_estados(clock_50mhz, clock_1hz, segmentos, anodo,estado); 
  input clock_50mhz;                  
  output clock_1hz;                   
  output reg [6:0] segmentos = 7'b3F; 
  output reg anodo = 0;               
  output reg [1:0] estado = 0;        
  reg [25:0] cuenta_para_1hz = 0;     
  parameter [6:0] cero = 0;           
  parameter [6:0] uno = 0;            
  parameter [6:0] dos = 0;            
  parameter [6:0] tres = 0;           
  always @(posedge clock_50mhz)       
  begin
    cuenta_para_1hz = cuenta_para_1hz + 1; 
    if(cuenta_para_1hz == 25_000_000) 
      begin
          clock_1hz =  ~clock_1hz;    
          cuenta_para_1hz = 0;        
      end
  always @(posedge clock_1hz)         
  begin
    case(estado)                      
      0:  estado <= 1;                
      1:  estado <= 2;                
      2:  estado <= 3;                
      3:  estado <= 4;                
    endcase
  end
  always @(estado)                    
  begin
    case(estado)                      
      0: segmentos = cero;            
      1: segmentos = uno;             
      2: segmentos = dos;             
      3: segmentos = tres;            
    endcase
  end
endmodule                             