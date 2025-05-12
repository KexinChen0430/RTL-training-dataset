module oper_mux ( sel, data, o); 
	parameter width_sel = 6; 
	parameter width_data = 6; 
	input	[width_sel-1:0]  sel; 
	input	[width_data-1:0]  data; 
	output	o; 
	reg  temp_result; 
   initial 
    begin
            temp_result = 'bz; 
        if (width_data <= 0) 
        begin
            $display("Error!  width_data must be greater than 0.\n"); 
            $display ("Time: %0t  Instance: %m", $time); 
		end
        if (width_sel <= 0) 
        begin
            $display("Error!  width_sel must be greater than 0.\n"); 
            $display ("Time: %0t  Instance: %m", $time); 
		end
    end
    always @(data or sel) 
	begin
         temp_result = data[sel]; 
	end
    assign o = temp_result; 
endmodule 