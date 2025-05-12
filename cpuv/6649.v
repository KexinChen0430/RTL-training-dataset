module messbauer_saw_tooth_generator #
(
    parameter GCLK_PERIOD = 20,
    parameter DIRECT_SLOPE_DURATION = 512,         
	 parameter CHANNEL_DURATION = (16 * (`MAX_CHANNEL_NUMBER / DIRECT_SLOPE_DURATION)) * 1000 / (2 * GCLK_PERIOD),
    parameter REVERSE_SLOPE_DURATION = (15464000 / (2 * GCLK_PERIOD)) / CHANNEL_DURATION ,         
    parameter DATA_WIDTH = 12
)
(
    input wire clk,
    input wire areset_n,
    output reg [DATA_WIDTH-1:0] out_value
);
    localparam RATIO_SLOPE_DURATOIN = DIRECT_SLOPE_DURATION / REVERSE_SLOPE_DURATION;
	 reg dir;
	 reg [15:0] counter;
    always @ (posedge clk)
    begin
	     if (!areset_n)
	     begin
		      out_value <= 0;
				counter <=0;
		      dir <= 0;
	     end
	     else
	     begin
		      counter <= counter + 1;
            if(dir == 0)
            begin
				    if (counter == CHANNEL_DURATION)
					 begin
                    out_value <= out_value + 1;
						  counter <= 0;
					 end
                if(out_value == DIRECT_SLOPE_DURATION)
                    dir <= 1;
            end
            else
            begin
				    if (counter == CHANNEL_DURATION)
					 begin
                    out_value <= out_value > RATIO_SLOPE_DURATOIN ? out_value - RATIO_SLOPE_DURATOIN : 0;
						  counter <= 0;
					 end
                if(out_value == 0)
                    dir <= 0;
            end
		  end
    end
endmodule