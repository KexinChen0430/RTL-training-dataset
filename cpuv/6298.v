module seeed_tft_command (
  input               rst,                
  input               clk,                
  output      [31:0]  debug,              
  input               i_cmd_write_stb,    
  input               i_cmd_read_stb,     
  input       [7:0]   i_cmd_data,         
  output  reg [7:0]   o_cmd_data,         
  input               i_enable,           
  input               i_cmd_rs,           
  output  reg         o_cmd_finished,     
  output              o_cmd_mode,         
  output  reg         o_write,            
  output  reg         o_read,             
  output  reg [7:0]   o_data_out,         
  input       [7:0]   i_data_in,          
  output  reg         o_data_out_en       
);
localparam  IDLE      = 4'h0;             
localparam  DELAY     = 4'h1;             
localparam  FINISHED  = 4'h2;             
reg           [3:0]   state;              
reg           [7:0]   count;              
assign  o_cmd_mode    = i_cmd_rs;         
always @ (posedge clk) begin              
  if (rst) begin                          
    state                   <=  IDLE;     
    o_data_out_en           <=  0;        
    o_data_out              <=  0;        
    o_cmd_finished          <=  0;        
    o_cmd_data              <=  0;        
    o_write                 <=  0;        
    o_read                  <=  0;        
    count                   <=  0;        
  end
  else begin                              
    o_cmd_finished          <=  0;        
    if (count < `DELAY_COUNT) begin       
        count               <= count + 1; 
    end
    case (state)                          
      IDLE: begin                         
        o_write             <=  0;        
        o_read              <=  0;        
        count               <=  `DELAY_COUNT; 
        o_data_out_en       <=  0;        
        if (i_cmd_write_stb) begin        
          o_data_out_en    <=  1;         
          o_data_out        <=  i_cmd_data; 
          o_write           <=  1;        
          state             <=  DELAY;    
          count             <=  0;        
        end
        else if (i_cmd_read_stb) begin    
          o_data_out_en     <=  0;        
          o_read            <=  1;        
          state             <=  DELAY;    
          count             <=  0;        
        end
      end
      DELAY: begin                        
        if (count >= `DELAY_COUNT) begin  
            state           <=  FINISHED; 
        end
      end
      FINISHED: begin                     
        o_write             <=  0;        
        o_read              <=  0;        
        if (!o_data_out_en) begin         
          o_cmd_data        <=  i_data_in; 
        end
        o_cmd_finished      <=  1;        
        state               <=  IDLE;     
      end
    endcase
  end
end
endmodule