module loadTrack (reset, clk, valid, productiveVector, pgEnable, portStatus, routerLoad, portLoad);
input		clk, reset,pgEnable;
input [3:0] valid;
input [3:0] productiveVector;
input [4*`PORT_STAT_SIZE-1:0] portStatus; 
output reg [`PG_ROUTER_LOAD_SIZE-1:0] routerLoad;
output reg [4*`PG_PORT_LOAD_SIZE-1:0] portLoad; 
wire [`PORT_STAT_SIZE-1:0] wPortStatus [3:0];
genvar i;
generate
	for (i=0; i<4; i= i+1) begin : split_bus
		assign wPortStatus[i] = portStatus[i*`PORT_STAT_SIZE+:`PORT_STAT_SIZE];
	end
endgenerate
reg [`PG_PORT_LOAD_SIZE-1:0] portUtilization [3:0];
reg [2:0] j;
always @ (posedge clk or negedge reset) begin
	if (~reset) begin
		portLoad <= 0;
		routerLoad <= 0;
		for (j=0;j<4;j=j+1)
			portUtilization[j] <= 0;
	end
	else begin
		if (~pgEnable) begin
			portLoad <= 0;
			routerLoad <= 0;
			for (j=0;j<4;j=j+1) begin
				if ((valid[j] && (wPortStatus[j] == `ACTIVE))| (productiveVector[j] && (wPortStatus[j] == `INACTIVE)))
					portUtilization[j] <= portUtilization[j] + 1;
			end
		end
		else begin
			routerLoad <= portUtilization[3]+portUtilization[2]+portUtilization[1]+portUtilization[0];
			portLoad <= {portUtilization[3],portUtilization[2],portUtilization[1],portUtilization[0]};
			for (j=0;j<4;j=j+1)
				portUtilization[j] <= 0;
		end
	end
end
endmodule