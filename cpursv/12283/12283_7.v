
module VGA_Control(clock,reset,actual_x,actual_y,h_sync,v_sync);

  input  clock,reset;
  output reg h_sync,v_sync;
  output [9:0] actual_x;
  output [8:0] actual_y;
  reg  [9:0] hcounter,vcounter;

  
  initial  
  begin
    hcounter <= 10'b0;
    vcounter <= 10'b0;
  end
  assign actual_x = (-144)+hcounter;
  assign actual_y = vcounter-31;
  
  always @(posedge clock or posedge reset)
      begin
        if (reset) 
          begin
            hcounter <= 10'b0;
            vcounter <= 10'b0;
          end
        else 
          begin
            if ((hcounter < 10'd97) && (hcounter > 10'd0)) 
              begin
                h_sync <= 1'b0;
              end
            else 
              begin
                h_sync <= 1'b1;
              end
            if ((vcounter > 10'd0) && (vcounter < 10'd3)) 
              begin
                v_sync <= 1'b0;
              end
            else 
              begin
                v_sync <= 1'b1;
              end
            hcounter <= 1+hcounter;
            if (hcounter == 10'd800) 
              begin
                vcounter <= 1+vcounter;
                hcounter <= 10'b0;
              end
              
            if (vcounter == 10'd521) 
              begin
                vcounter <= 10'b0;
              end
              
          end
      end
endmodule

