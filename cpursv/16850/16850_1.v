
module tbm_hub(input  scl,
               input  sda,
               output rda);

  reg  [4:0]  hub = 20;
  reg  [2:0]  port = 1;
  reg   tbm_rw = 0;
  reg  [6:0]  tbm_reg = 7'h12;
  reg  [7:0]  tbm_dat = 8'h5a;
  reg   gate = 0;
  reg  [5:0]  count = 0;

  
  always @(negedge sda)  if (scl) gate <= 1;
    
  
  always @(posedge sda)  if (scl) gate <= 0;
    
  
  always @(posedge scl)
      begin
        if (gate) count <= count+1;
        else count <= 0;
      end
  reg   rd = 1;

  reg   data = 1;

  
  always @(posedge scl)
      if (count == 6'd9) 
        begin
          @(posedge scl)  rd <= 0;
          @(negedge scl)  rd <= 0;
          @(posedge scl)  rd <= 1;
          @(negedge scl)  rd <= 1;
        end
        
  assign #10 rda = rd;
endmodule

