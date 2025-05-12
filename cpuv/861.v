module CapSense_Sys #(
  parameter DIRECT=1,     
  parameter FREQUENCY=24, 
  parameter N=4           
) (
  input          clk_i,       
  input          rst_i,       
  input  [N-1:0] capsense_i,  
  output         oe,          
  output [N-1:0] buttons_o,   
  output [N-1:0] debug_o      
);
localparam integer MOD_SAMP = FREQUENCY / 1.5; 
localparam integer MOD_BITS = $clog2(MOD_SAMP); 
localparam IDLE = 0, SAMPLING = 1, DO_SAMPLE = 2;
localparam ALL_1 = {N{1'b1}};
reg [1:0]   state = IDLE;
reg [N-1:0] btns_r;
wire clkSamp;
reg [MOD_BITS-1:0] cntSamp = 0;
wire clkPoll;
reg [16:0] cntPoll = 0;
wire [N-1:0] cur_btns;
reg  [N-1:0] prev_btn_r = 0;
reg  [N-1:0] cur_btn_r = 0;
always @(posedge clk_i)
  if (cntSamp == MOD_SAMP - 1)
     cntSamp = 0;
  else
     cntSamp = cntSamp + 1;
assign clkSamp = !cntSamp ? 1 : 0;
always @(posedge clk_i)
  if (clkSamp)
     cntPoll = cntPoll + 1;
assign clkPoll = !cntPoll ? 1 : 0;
assign oe = state == IDLE ? 1 : 0;
always @(posedge clk_i)
begin : do_fsm
  if (1'b0) 
     begin
     state = IDLE;
     btns_r = 0;
     end
  else
     begin
     case (state)
          IDLE:
             if (clkPoll)
                state = SAMPLING;
          SAMPLING:
             if (clkSamp && capsense_i)
                state = DO_SAMPLE;
          default: 
              if (clkSamp) 
                 begin
                 btns_r = ~capsense_i;
                 state = IDLE;
                 end
     endcase
     end
end
assign cur_btns = btns_r;
integer i;
always @(posedge clk_i)
begin
  for (i = 0; i < N; i = i + 1)
      if (!prev_btn_r[i] && cur_btns[i]) 
         cur_btn_r[i] = ~cur_btn_r[i]; 
  prev_btn_r = cur_btns;
end
assign buttons_o = DIRECT ? cur_btns : cur_btn_r;