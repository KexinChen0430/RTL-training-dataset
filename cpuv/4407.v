module StreamFifoLowLatency (
  input               io_push_valid,          
  output              io_push_ready,          
  input      [31:0]   io_push_payload_outputs_0, 
  output reg          io_pop_valid,           
  input               io_pop_ready,           
  output reg [31:0]   io_pop_payload_outputs_0, 
  input               io_flush,               
  output     [1:0]    io_occupancy,           
  input               clk,                    
  input               reset                   
);
wire       [31:0]   _zz_ram_port0;            
wire       [31:0]   _zz_io_pop_payload_outputs_0; 
reg                 _zz_1;                    
reg                 pushPtr_willIncrement;    
reg                 pushPtr_willClear;        
reg        [0:0]    pushPtr_valueNext;        
reg        [0:0]    pushPtr_value;            
wire                pushPtr_willOverflowIfInc; 
wire                pushPtr_willOverflow;     
reg                 popPtr_willIncrement;     
reg                 popPtr_willClear;         
reg        [0:0]    popPtr_valueNext;         
reg        [0:0]    popPtr_value;             
wire                popPtr_willOverflowIfInc; 
wire                popPtr_willOverflow;      
wire                ptrMatch;                 
reg                 risingOccupancy;          
wire                empty;                    
wire                full;                     
wire                pushing;                  
wire                popping;                  
wire                when_Stream_l995;         
wire                when_Stream_l1008;        
wire       [0:0]    ptrDif;                   
(* ram_style = "distributed" *) reg [31:0] ram [0:1];
assign _zz_io_pop_payload_outputs_0 = _zz_ram_port0[31 : 0];
assign _zz_ram_port0 = ram[popPtr_value];
always @(posedge clk) begin
  if(_zz_1) begin
    ram[pushPtr_value] <= io_push_payload_outputs_0;
  end
end
always @(*) begin
  _zz_1 = 1'b0;
  if(pushing) begin
    _zz_1 = 1'b1;
  end
end
always @(*) begin
  pushPtr_willIncrement = 1'b0;
  if(pushing) begin
    pushPtr_willIncrement = 1'b1;
  end
end
always @(*) begin
  pushPtr_willClear = 1'b0;
  if(io_flush) begin
    pushPtr_willClear = 1'b1;
  end
end
assign pushPtr_willOverflowIfInc = (pushPtr_value == 1'b1);
assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
always @(*) begin
  pushPtr_valueNext = (pushPtr_value + pushPtr_willIncrement);
  if(pushPtr_willClear) begin
    pushPtr_valueNext = 1'b0;
  end
end
always @(*) begin
  popPtr_willIncrement = 1'b0;
  if(popping) begin
    popPtr_willIncrement = 1'b1;
  end
end
always @(*) begin
  popPtr_willClear = 1'b0;
  if(io_flush) begin
    popPtr_willClear = 1'b1;
  end
end
assign popPtr_willOverflowIfInc = (popPtr_value == 1'b1);
assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
always @(*) begin
  popPtr_valueNext = (popPtr_value + popPtr_willIncrement);
  if(popPtr_willClear) begin
    popPtr_valueNext = 1'b0;
  end
end
assign ptrMatch = (pushPtr_value == popPtr_value);
assign empty = (ptrMatch && (! risingOccupancy));
assign full = (ptrMatch && risingOccupancy);
assign pushing = (io_push_valid && io_push_ready);
assign popping = (io_pop_valid && io_pop_ready);
assign io_push_ready = (! full);
assign when_Stream_l995 = (! empty);
always @(*) begin
  if(when_Stream_l995) begin
    io_pop_valid = 1'b1;
  end else begin
    io_pop_valid = io_push_valid;
  end
end
always @(*) begin
  if(when_Stream_l995) begin
    io_pop_payload_outputs_0 = _zz_io_pop_payload_outputs_0[31 : 0];
  end else begin
    io_pop_payload_outputs_0 = io_push_payload_outputs_0;
  end
end
assign when_Stream_l1008 = (pushing != popping);
assign ptrDif = (pushPtr_value - popPtr_value);
assign io_occupancy = {(risingOccupancy && ptrMatch),ptrDif};
always @(posedge clk) begin
  if(reset) begin
    pushPtr_value <= 1'b0;
    popPtr_value <= 1'b0;
    risingOccupancy <= 1'b0;
  end else begin
    pushPtr_value <= pushPtr_valueNext;
    popPtr_value <= popPtr_valueNext;
    if(when_Stream_l1008) begin
      risingOccupancy <= pushing;
    end
    if(io_flush) begin
      risingOccupancy <= 1'b0;
    end
  end
end
endmodule