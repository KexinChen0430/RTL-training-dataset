module spi_slave_b2b_reduced(
clk,sck,mosi,miso,ssel,rst_n,recived_status
);
input clk;
input rst_n;
input sck,mosi,ssel;
output miso;
output recived_status;
reg recived_status;
reg sselr;
reg [7:0] byte_data_sent;
reg [7:0] next_byte_data_sent;
reg [7:0] bit_cnt;
wire ssel_active;
wire sck_risingedge;
wire sck_fallingedge;
wire ssel_startmessage;
wire ssel_endmessage;
				 if(bit_cnt == 8'hff)
				  begin
					 bit_cnt <= 8'h0;
					 next_byte_data_sent <= next_byte_data_sent + 1;
				 end
			end
		end
	end
end
assign miso = byte_data_sent[7];  
endmodule