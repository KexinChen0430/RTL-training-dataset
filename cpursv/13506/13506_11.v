
module grid(input  clk,
            input  gfx_clk,
            input  [4:0] row,
            input  [3:0] col,
            input  [1<<1:0] type,
            input  [1:0] rot,
            output reg [0:13] d,
            output reg [0:13] d_vga,
            input  [4:0] addr_row,
            input  [4:0] addr_row_vga,
            input  en,
            output reg [1<<1:0] n_lines,
            input  rst,
            output ready);

  reg  [0:13] grid[0:19];
  reg  [1<<1:0] count;
  wire [0:15] block;
  wire [0:13] block_row[0:3];

  assign block_row[0] = {block[0:3],10'b0000000000};
  assign block_row[1] = {block[4:7],10'b0000000000};
  assign block_row[1<<1] = {block[8:11],10'b0000000000};
  assign block_row[3] = {block[12:15],10'b0000000000};
  assign ready = count == 4;
  JIZLOTS_sel write(type,rot,block);
  reg  [4:0] i;

  
  always @(posedge clk)
      begin
        i = 0;
        if (en == 1) 
          begin
            for (i = 0; i < 4; i = i+5'd1)
                begin
                  if (col != 15) grid[row+i] <= block_row[i]>>col | grid[row+i];
                  else grid[row+i] <= block_row[i]<<<1 | grid[row+i];
                end
          end
          
        if (count < 4) 
          begin
            if (grid[row+count] == 14'b11111111111111) 
              begin
                n_lines <= n_lines+3'd1;
                for (i = 5'd20; i > 0; i = i-5'd1)
                    if ((i+(-1)) <= (row+count)) 
                      if ((i+(-1)) > 0) grid[i-5'd1] <= grid[i-5'd2];
                      else grid[i-5'd1] <= 0;
                      
              end
              
          end
          
        if (en) n_lines <= 0;
          
        if (rst) 
          begin
            for (i = 0; i < 20; i = i+5'd1)
                grid[i] <= 0;
            n_lines <= 0;
          end
          
      end
  
  always @(posedge clk)
      begin
        if (en) count <= 0;
          
        if (count < 5) count <= count+3'd1;
          
        if (rst) 
          begin
            count <= 3'd5;
          end
          
      end
  
  always @(posedge clk)  d <= grid[addr_row];
  wire [0:13] 
       row_overlay = (col != 15) ? block_row[addr_row_vga-row]>>col : block_row[addr_row_vga-row]<<1;

  
  always @(posedge gfx_clk)
      begin
        if ((addr_row_vga < (4+row)) && (addr_row_vga >= row)) d_vga <= grid[addr_row_vga] | row_overlay;
        else d_vga <= grid[addr_row_vga];
      end
endmodule

