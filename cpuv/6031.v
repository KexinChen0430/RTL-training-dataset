module BgPainter(input clk, input ce, 
                 input enable,             
                 input [2:0] cycle,        
                 input [2:0] fine_x_scroll, 
                 input [14:0] loopy,       
                 output [7:0] name_table,  
                 input [7:0] vram_data,    
                 output [3:0] pixel);      
  reg [15:0] playfield_pipe_1; 
  reg [15:0] playfield_pipe_2; 
  reg [8:0]  playfield_pipe_3; 
  reg [8:0]  playfield_pipe_4; 
  reg [7:0] current_name_table;      
  reg [1:0] current_attribute_table; 
  reg [7:0] bg0;                
  wire [7:0] bg1 =  vram_data;  
  initial begin
    playfield_pipe_1 = 0; 
    playfield_pipe_2 = 0; 
    playfield_pipe_3 = 0; 
    playfield_pipe_4 = 0; 
    current_name_table = 0; 
    current_attribute_table = 0; 
    bg0 = 0; 
  end
  always @(posedge clk) if (ce) begin 
    case (cycle[2:0]) 
    1: current_name_table <= vram_data; 
    3: current_attribute_table <= (!loopy[1] && !loopy[6]) ? vram_data[1:0] : 
                                  ( loopy[1] && !loopy[6]) ? vram_data[3:2] :
                                  (!loopy[1] &&  loopy[6]) ? vram_data[5:4] :
                                                             vram_data[7:6];
    5: bg0 <= vram_data; 
    endcase
    if (enable) begin 
      playfield_pipe_1[14:0] <= playfield_pipe_1[15:1]; 
      playfield_pipe_2[14:0] <= playfield_pipe_2[15:1]; 
      playfield_pipe_3[7:0] <= playfield_pipe_3[8:1]; 
      playfield_pipe_4[7:0] <= playfield_pipe_4[8:1]; 
      if (cycle[2:0] == 7) begin 
        playfield_pipe_1[15:8] <= {bg0[0], bg0[1], bg0[2], bg0[3], bg0[4], bg0[5], bg0[6], bg0[7]}; 
        playfield_pipe_2[15:8] <= {bg1[0], bg1[1], bg1[2], bg1[3], bg1[4], bg1[5], bg1[6], bg1[7]}; 
        playfield_pipe_3[8] <= current_attribute_table[0]; 
        playfield_pipe_4[8] <= current_attribute_table[1]; 
      end
    end
  end
  assign name_table = current_name_table; 
  wire [3:0] i = {1'b0, fine_x_scroll}; 
  assign pixel = {playfield_pipe_4[i], playfield_pipe_3[i], 
                  playfield_pipe_2[i], playfield_pipe_1[i]};
endmodule