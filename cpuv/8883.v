module tri_bus ( datain, dataout ); 
	parameter width_datain = 1; 
	parameter width_dataout = 1; 
	input [(width_datain)-1:0] datain; 
	output [width_dataout-1:0] dataout; 
    reg [width_dataout-1:0] tmp_result; 
    integer i; 
   initial 
    begin
            tmp_result = 1'bz; 
        if (width_datain <= 0) 
        begin
            $display("Error!  width_datain must be greater than 0.\n"); 
            $display ("Time: %0t  Instance: %m", $time); 
		end
        if (width_dataout != 1) 
        begin
            $display("Error!  width_dataout must be equal to 1.\n"); 
            $display ("Time: %0t  Instance: %m", $time); 
		end
    end
    always @(datain) 
	begin
            for (i = 0; i < width_datain; i = i + 1) 
				if ((datain[i] == 1)||(datain[i] == 0)) 
				begin
				tmp_result[0]=datain[i]; 
				end
	end
    assign dataout = tmp_result; 
endmodule 