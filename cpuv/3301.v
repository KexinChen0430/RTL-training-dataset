module timer (clk, rst, flit_id, length, runtimer, timesup);
  input           clk, rst; 
  input [2 : 0]   flit_id; 
  input [11 : 0]  length; 
  input           runtimer; 
  output reg      timesup; 
  reg [11 : 0]     timeoutclockperiods; 
  reg [11 : 0]     count; 
  always @ (posedge clk) begin: timeout
    if(rst) begin 
      count <= 0;
      timeoutclockperiods <= 0;
    end
    else begin
      if (flit_id == `HEADER) begin 
        timeoutclockperiods <= length;
      end
      if (runtimer == 0) begin 
        count <= 0;
      end
      else begin 
        count <= count + 1;
      end
    end
  end
  always @ (count, timeoutclockperiods) begin : timeup
    if (count == timeoutclockperiods) 
      timesup = 1;
    else 
      timesup = 0;
  end
endmodule