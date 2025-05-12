
module top;

  reg   pass = 1'b1;
  wire [3:0] part_idx_up,part_idx_down,part_sel;
  wire [3:0] ps_array[1:0];

  assign part_idx_up[1 +: 2] = 2'b01;
  assign part_idx_up[3] = 1'b1;
  assign part_idx_down[2 -: 2] = 2'b10;
  assign part_idx_down[3] = 1'b0;
  assign part_sel[2:1] = 2'b01;
  assign part_sel[3] = 1'b1;
  assign ps_array[0][2:1] = 2'b01;
  assign ps_array[0][3] = 1'b1;
  
  initial  
  begin
    #1 ;
    if (part_idx_up !== 4'b101z) 
      begin
        $display("Failed +: select, expected 4'b101z, got %b",
                 part_idx_up);
        pass = 1'b0;
      end
      
    if (part_idx_down !== 4'b010z) 
      begin
        $display("Failed -: select, expected 4'b010z, got %b",
                 part_idx_down);
        pass = 1'b0;
      end
      
    if (part_sel !== 4'b101z) 
      begin
        $display("Failed const. part select, expected 4'b101z, got %b",
                 part_sel);
        pass = 1'b0;
      end
      
    if (ps_array[0] !== 4'b101z) 
      begin
        $display("Failed array part select, expected 4'b101z, got %b",
                 ps_array[0]);
        pass = 1'b0;
      end
      
    if (pass) 
      $display("PASSED");
      
  end
endmodule

