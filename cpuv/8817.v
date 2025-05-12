module oper_selector ( sel, data, o); 
 parameter width_sel = 6; 
 parameter width_data = 6; 
 input [width_sel-1:0]  sel; 
 input [width_data-1:0]  data; 
 output o; 
 reg  temp_result; 
 reg [width_data-1:0]  result; 
 integer i; 
 initial 
  begin
    if (width_sel <= 0)
    begin
        $display("Error!  width_sel must be greater than 0.\n"); 
        $display ("Time: %0t  Instance: %m", $time); 
    end
    if (width_data != width_sel)
    begin
        $display("Error!  width_sel must be equal to width_data.\n"); 
        $display ("Time: %0t  Instance: %m", $time); 
    end
  end
 always @(data or sel) 
 begin
  temp_result = 1'b0; 
  for (i = 0; i < width_sel; i = i + 1) 
   if (sel[i] == 1) 
   begin
    temp_result= temp_result | data[i]; 
   end
 end
 assign o = temp_result; 
endmodule 