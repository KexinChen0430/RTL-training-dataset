module fifo (
 din
, write_busy
, fifo_full
, dout
, read_busy
, fifo_empty
, fifo_clk
, rst_n
, fifo_flush
);
input [32-1:0] din;
input write_busy;
input read_busy;
input fifo_clk;
input rst_n;
input fifo_flush;
output [32-1:0] dout;
output fifo_empty;
output fifo_full;
reg  [32-1:0] dout;
reg  fifo_full;
reg  fifo_empty;
reg  [8:0] write_occupancy;
reg  [8:0] read_occupancy;
reg  [8:0] next_write_occupancy;
reg  [8:0] next_read_occupancy;
wire [7:0] next_write_ptr;
reg  [7:0] write_ptr;
wire [7:0] next_read_ptr;
reg  [7:0] read_ptr;
reg  [32-1:0] data_array[256-1:0];
wire [7:0] read_index;
wire [32-1:0] dout_next;
reg  write_busy_d;
always @(posedge fifo_clk or negedge rst_n) begin
	if (!rst_n) begin
		write_ptr <= 8'b0;
	end else begin
		write_ptr <= next_write_ptr;
	end
end 
assign next_write_ptr =  fifo_flush ? 8'b0 : (write_ptr + (write_busy & ~fifo_full));
always @(posedge fifo_clk or negedge rst_n) begin
	if (!rst_n) begin
       		read_ptr <= 8'b0;
  	end else begin
		read_ptr <= next_read_ptr;
	end
end 
assign next_read_ptr = fifo_flush ? 8'b0 : (read_ptr + (read_busy & ~fifo_empty));
assign read_index[8-1:0] = read_busy ? next_read_ptr : read_ptr;
always @(posedge fifo_clk)
	if (write_busy )
		data_array[write_ptr] <= din;
always @(posedge fifo_clk) begin
	dout <= dout_next;
end
assign dout_next = {data_array[read_index[8-1:0]]};
always @(posedge fifo_clk or negedge rst_n) begin
	if (!rst_n) begin
		write_occupancy <= 8'b0;
	end else begin
		write_occupancy <= next_write_occupancy;
	end
end
always @(posedge fifo_clk or negedge rst_n) begin
	if (!rst_n) begin
		read_occupancy <= 8'b0;
	end else begin
		read_occupancy <= next_read_occupancy;
	end
end
always @(posedge fifo_clk or negedge rst_n) begin
        if(!rst_n) begin
                write_busy_d <= 1'b0;
        end else begin
                write_busy_d <= write_busy;
        end
end
always @(*) begin
	if (fifo_flush) begin
		next_read_occupancy = 8'b0;
	end else begin
		case ({write_busy_d,read_busy})
			2'b00: 	next_read_occupancy = read_occupancy;
			2'b01:	next_read_occupancy = read_occupancy - 1'b1;
			2'b10:  next_read_occupancy = read_occupancy + 1'b1;
			2'b11: 	next_read_occupancy = read_occupancy;
			default:   next_read_occupancy = read_occupancy;
		endcase
	end
end
always @(*) begin
	if (fifo_flush) begin
		next_write_occupancy = 8'b0;
	end else begin
		case ({write_busy,read_busy})
			2'b00: 	next_write_occupancy = write_occupancy;
			2'b01:	next_write_occupancy = write_occupancy - 1'b1;
			2'b10: 	next_write_occupancy = write_occupancy + 1'b1;
			2'b11: 	next_write_occupancy = write_occupancy;
			default:   next_write_occupancy = write_occupancy;
		endcase
	end
end
always @(posedge fifo_clk or negedge rst_n) begin
		if (!rst_n)
			fifo_full <= 0;
		else if (next_write_occupancy == 256)
			fifo_full <= 1;
		else
			fifo_full <= 0;
end
always @(posedge fifo_clk or negedge rst_n) begin
		if (!rst_n)
			fifo_empty <= 1;
		else if (next_read_occupancy == 0)
			fifo_empty <= 1;
		else
			fifo_empty <= 0;
end
always @(posedge fifo_clk) begin
	if (fifo_full && write_busy) begin
		$display("ERROR: %m: Fifo overflow at time %t", $time);
		$finish;
	end
end 
always @(posedge fifo_clk) begin
	if (fifo_empty && read_busy) begin
		$display("ERROR: %m: Fifo underflow at time %t", $time);
		$finish;
	end
end 
endmodule